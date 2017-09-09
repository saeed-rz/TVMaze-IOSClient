//
//  InfoViewController.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblStory;
@property (weak, nonatomic) IBOutlet UILabel *lblCast;
@property (weak, nonatomic) IBOutlet UILabel *lblCrew;

@property NSInteger showId;

@end
