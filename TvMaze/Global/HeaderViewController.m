//
//  HeaderViewController.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "HeaderViewController.h"



@interface HeaderViewController ()

@end

@implementation HeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    switch (self.state) {
        case Mainview:
            [self.lblTitle setText:@"GoMoview"];
            [self.btnLeft setImage:[UIImage imageNamed:@"ic_drawer"] forState:UIControlStateNormal];
            break;
        case NowPlay:
            [self.lblTitle setText:@"Now Playing"];
            [self.btnLeft setImage:[UIImage imageNamed:@"ic_back"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

-(void)setHeader:(int) state
{
    self.state = state;
    
    
}

- (IBAction)OnLeftButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
