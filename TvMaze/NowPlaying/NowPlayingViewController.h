//
//  NowPlayingViewController.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Show+CoreDataClass.h"
#import "NowPlayingInfoViewController.h"

@interface NowPlayingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *vwPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgShowAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblGenre;
@property (weak, nonatomic) IBOutlet UIView *vwIMDB;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;
@property (weak, nonatomic) IBOutlet UILabel *lblYearCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblDirector;
@property (weak, nonatomic) IBOutlet UILabel *lblWriter;
@property (weak, nonatomic) IBOutlet UIView *vwLoading;

@property NSInteger showId;
@property Show *show;
@property NowPlayingInfoViewController *nowPlayingInfo;
@end
