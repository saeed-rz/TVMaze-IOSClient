//
//  InfoViewController.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "InfoViewController.h"
#import "Show+CoreDataClass.h"
#import "Cast+CoreDataClass.h"
#import "Crew+CoreDataClass.h"
#import "DatabaseManager.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"showId = %i", self.showId];
    
    Show *show = [[DatabaseManager getAllObjectsForEntityName:@"Show" withSortDescriptors:nil andPredicate:predicate] objectAtIndex:0];
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[show.summary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    [self.lblStory setAttributedText:attrStr];
    
    
    NSArray *crews = [DatabaseManager getAllObjectsForEntityName:@"Crew" withSortDescriptors:nil andPredicate:nil];
    if(crews.count == 0)
        return;
    Crew *crew1 = [crews objectAtIndex:0];
    Crew *crew2 = [crews objectAtIndex:1];
    
    [self.lblCrew setText:[NSString  stringWithFormat:@"%@: %@ \r %@: %@",crew1.crewRole,crew1.crewTitle,crew2.crewRole,crew2.crewTitle]];
    
    NSArray *casts = [DatabaseManager getAllObjectsForEntityName:@"Cast" withSortDescriptors:nil andPredicate:nil];
    
    NSString *castTitle = @"";
    for (int index = 0; index < casts.count; index++)
    {
        Cast *cast = [casts objectAtIndex:index];
        castTitle = [NSString stringWithFormat:@"%@,%@",cast.castTitle,castTitle];
        if(index >= 4)
        {
            break;
        }
    }
    
    [self.lblCast setText:[NSString stringWithFormat:@"Stars: %@", castTitle]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
