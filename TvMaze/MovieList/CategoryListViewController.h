//
//  CategoryListViewController.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "DatabaseManager.h"
#import "Show+CoreDataClass.h"
#import "MovieTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NowPlayingViewController.h"

@interface CategoryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblMovieList;


@property NSString *genre;
@property NSArray *shows;
@property NSInteger selectedShowId;

@end
