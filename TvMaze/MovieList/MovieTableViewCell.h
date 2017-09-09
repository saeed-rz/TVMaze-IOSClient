//
//  MovieTableViewCell.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MovieTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vwInfoParent;
@property (weak, nonatomic) IBOutlet UILabel *lblMovieTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblGenre;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgMovieAvatar;
@property (weak, nonatomic) IBOutlet UIView *vwRate;
@property (weak, nonatomic) IBOutlet UILabel *lblRate;

@end
