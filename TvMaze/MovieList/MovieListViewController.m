//
//  MovieListViewController.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "MovieListViewController.h"
#import "CategoryListViewController.h"
#import "Genre+CoreDataClass.h"
#import "DatabaseManager.h"

@interface MovieListViewController ()

@end

@implementation MovieListViewController

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
    [self.vwLoading setHidden:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getAllShowSuccessfullty:) name:GetAllShowSucceedNotification object:nil];
    self.delegate = self;
    self.dataSource = self;
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"genreTitle" ascending: YES];
    self.allGenre = [DatabaseManager getAllObjectsForEntityName:@"Genre" withSortDescriptors:[NSArray arrayWithObject:sortDescriptor] andPredicate:nil];
    NSArray *all = [DatabaseManager getAllObjectsForEntityName:@"Show" withSortDescriptors:nil andPredicate:nil];
}

-(void) getAllShowSuccessfullty:(NSNotification *) notif
{
    [self.vwLoading setHidden:YES];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"genreTitle" ascending: YES];
    self.allGenre = [DatabaseManager getAllObjectsForEntityName:@"Genre" withSortDescriptors:[NSArray arrayWithObject:sortDescriptor] andPredicate:nil];
    [self reloadData];
}

#pragma mark - Interface Orientation Changes
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    // Update changes after screen rotates
    [self performSelector:@selector(setNeedsReloadOptions) withObject:nil afterDelay:duration];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return self.allGenre.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {

    Genre *genre = [self.allGenre objectAtIndex:index];
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0];
    label.text = genre.genreTitle;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];

    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {

    CategoryListViewController *cvc = [self.storyboard instantiateViewControllerWithIdentifier:@"contentViewController"];

    Genre *genre = [self.allGenre objectAtIndex:index];
    cvc.genre = genre.genreTitle;

    return cvc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {

    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 0.0;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
        case ViewPagerOptionTabLocation:
            return 1.0;
        case ViewPagerOptionTabHeight:
            return 44.0;
        case ViewPagerOptionTabOffset:
            return 36.0;
        case ViewPagerOptionTabWidth:
            return UIInterfaceOrientationIsLandscape(self.interfaceOrientation) ? 128.0 : 96.0;
        case ViewPagerOptionFixFormerTabsPositions:
            return 1.0;
        case ViewPagerOptionFixLatterTabsPositions:
            return 1.0;
        default:
            return value;
    }
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {

    switch (component) {
        case ViewPagerIndicator:
            return [UIColor colorWithRed:1 green:212.0/255.0 blue:71.0/255.0 alpha:1];
        case ViewPagerTabsView:
            return [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:56.0/255.0 alpha:1];
        case ViewPagerContent:
            return [[UIColor darkGrayColor] colorWithAlphaComponent:0.32];
        default:
            return color;
    }
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
