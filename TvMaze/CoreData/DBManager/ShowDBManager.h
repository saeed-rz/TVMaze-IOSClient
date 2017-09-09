//
//  ShowDBManager.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
#import "Show+CoreDataClass.h"
#import "DatabaseInterface.h"

@interface ShowDBManager : DatabaseManager

+ (Show *)storeShowWithID:(NSNumber *)showId
                     Rate:(NSNumber *)Rate
                  ShowUrl:(NSString *)ShowUrl
                  Summary:(NSString *)Summary

                     Name:(NSString *)Name
              ImageMedium:(NSString *)ImageMedium
                   Genres:(NSString *)Genres;

@end
