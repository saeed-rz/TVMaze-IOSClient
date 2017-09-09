//
//  NowPlayingInfoViewController.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPagerController.h"

@interface NowPlayingInfoViewController : ViewPagerController <ViewPagerDelegate, ViewPagerDataSource>

@property NSInteger showId;

@end
