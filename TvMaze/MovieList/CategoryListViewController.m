//
//  CategoryListViewController.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "CategoryListViewController.h"

@interface CategoryListViewController ()

@end

@implementation CategoryListViewController

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
    UIColor *color = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:56.0/255.0 alpha:1];
    [self.tblMovieList setDelegate:self];
    [self.tblMovieList setDataSource:self];
}

-(void) viewWillAppear:(BOOL)animated
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(genres CONTAINS[cd] %@)", self.genre];
    self.shows = [DatabaseManager getAllObjectsForEntityName:@"Show" withSortDescriptors:nil andPredicate:predicate];
    
    [self.tblMovieList reloadData];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shows.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" forIndexPath:indexPath];
    Show *show = [self.shows objectAtIndex:indexPath.row];
    
    [cell.lblMovieTitle setText:show.name];
    [cell.lblGenre setText:show.genres];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[show.summary dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];

    [cell.lblDescription setAttributedText:attrStr];
    [cell.lblRate setText:[NSString stringWithFormat:@"%1.1f", show.rating]];
    
    [cell.imgMovieAvatar sd_setImageWithURL:[NSURL URLWithString:show.imageM]];
    
    cell.vwRate.layer.cornerRadius = 16;
    cell.vwInfoParent.layer.cornerRadius = 5;
    
    
    [self setShadow:cell.vwInfoParent];
    
    
    UIBezierPath *maskPath = [UIBezierPath
                              bezierPathWithRoundedRect:cell.imgMovieAvatar.bounds
                              byRoundingCorners:(UIRectCornerAllCorners)
                              cornerRadii:CGSizeMake(5, 5)
                              ];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    [self setShadow:cell.imgMovieAvatar];
    maskLayer.frame = cell.imgMovieAvatar.bounds;
    maskLayer.path = maskPath.CGPath;
    
    cell.imgMovieAvatar.layer.mask = maskLayer;
    
    return cell;
}

-(void) setShadow:(UIView *)view
{
    view.layer.shadowRadius  = 1.5f;
    view.layer.shadowColor   = [UIColor colorWithRed:176.f/255.f green:199.f/255.f blue:226.f/255.f alpha:1.f].CGColor;
    view.layer.shadowOffset  = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.9f;
    view.layer.masksToBounds = NO;
    
    UIEdgeInsets shadowInsets     = UIEdgeInsetsMake(0, 0, -1.5f, 0);
    UIBezierPath *shadowPath      = [UIBezierPath bezierPathWithRect:UIEdgeInsetsInsetRect(view.bounds, shadowInsets)];
    view.layer.shadowPath    = shadowPath.CGPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Show *selectedShow = [self.shows objectAtIndex:indexPath.row];
    self.selectedShowId = selectedShow.showId;
    
    [self performSegueWithIdentifier:@"show_detail" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"show_detail"])
    {
        NowPlayingViewController *vc = segue.destinationViewController;
        vc.showId = self.selectedShowId;
    }
}


@end
