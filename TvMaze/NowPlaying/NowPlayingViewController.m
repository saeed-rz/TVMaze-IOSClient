//
//  NowPlayingViewController.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "NowPlayingViewController.h"
#import "DatabaseManager.h"
#import "Show+CoreDataClass.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GetCastShow.h"
#import "GetCrewShow.h"
#import "Crew+CoreDataClass.h"
#import "NowPlayingInfoViewController.h"
#import "HeaderViewController.h"

@interface NowPlayingViewController ()

@end

@implementation NowPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self Init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) Init
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllCastuccessfullty:) name:GetAllCastSucceedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllCrewSuccessfullty:) name:GetAllCrewSucceedNotification object:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"showId = %i", self.showId];
    self.show = [[DatabaseManager getAllObjectsForEntityName:@"Show" withSortDescriptors:nil andPredicate:predicate] objectAtIndex:0];
    
    [self.lblMovieTitle setText:self.show.name];
    self.lblGenre.text = self.show.genres;
    [self.lblRate setText:[NSString stringWithFormat:@"%1.1f",self.show.rating]];
    [self.imgShowAvatar sd_setImageWithURL:[NSURL URLWithString:self.show.imageM]];
    
    self.vwPlay.layer.cornerRadius = 24;
    self.vwIMDB.layer.cornerRadius = 8;
    
    [self.vwLoading setHidden:NO];
    [GetCastShow getCastShow:self.showId];
}

-(void) getAllCastuccessfullty:(NSNotification *) notif
{
    [GetCrewShow getCrewShow:self.showId];
}

-(void) getAllCrewSuccessfullty:(NSNotification *) notif
{
    [self.vwLoading setHidden:YES];
    NSArray *crews = [DatabaseManager getAllObjectsForEntityName:@"Crew" withSortDescriptors:nil andPredicate:nil];
    
    Crew *crew = [crews objectAtIndex:0];
    [self.lblDirector setText:[NSString stringWithFormat:@"%@:%@",crew.crewRole,crew.crewTitle]];
    
    crew = [crews objectAtIndex:1];
    [self.lblWriter setText:[NSString stringWithFormat:@"%@: %@",crew.crewRole,crew.crewTitle]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"infoSegue"])
    {
        NowPlayingInfoViewController *vc = segue.destinationViewController;
        
        vc.showId = self.showId;
    }
    if([segue.identifier isEqualToString:@"headerSegue"])
    {
        HeaderViewController *vc = segue.destinationViewController;
        [vc setHeader:Mainview];
    }
}




@end
