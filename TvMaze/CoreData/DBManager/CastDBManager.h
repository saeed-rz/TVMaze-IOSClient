//
//  CastDBManager.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cast+CoreDataClass.h"
#import "DatabaseInterface.h"
#import "DatabaseManager.h"

@interface CastDBManager : DatabaseManager

+ (Cast *)storeCast:(NSString *)title;

@end
