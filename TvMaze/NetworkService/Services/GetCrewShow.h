//
//  GetCrewShow.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkInterface.h"
#import <AFNetworking.h>
#import "Global.h"

@interface GetCrewShow : NSObject

+ (void)getCrewShow:(NSInteger) showId;

@end
