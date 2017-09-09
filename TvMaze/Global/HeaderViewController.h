//
//  HeaderViewController.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Mainview 1
#define NowPlay 2

@interface HeaderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property NSInteger state;

-(void)setHeader:(int) state;

@end
