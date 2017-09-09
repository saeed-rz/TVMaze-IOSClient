//
//  ShowDBManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "ShowDBManager.h"

@implementation ShowDBManager

+ (Show *)storeShowWithID:(NSNumber *)showId
                     Rate:(NSNumber *)Rate
                  ShowUrl:(NSString *)ShowUrl
                  Summary:(NSString *)Summary

                     Name:(NSString *)Name
              ImageMedium:(NSString *)ImageMedium
                   Genres:(NSString *)Genres
{
    __block Show *newShow = nil;
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    
    [tempContext performBlockAndWait:^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"showId = %@", showId];
        NSArray *fetchResult = [DatabaseInterface executeFetchRequestInDBForEntityWithName:@"Show"
                                                                                     withPredicate:predicate
                                                                               withSortDescriptors:nil
                                                                        shouldReturnObjectAsFaults:NO];
        
        if (!fetchResult || ([fetchResult count] > 1))
        {
            // Error
        }
        else if ([fetchResult count] == 0)
        {
            newShow = (Show *)[DatabaseInterface insertNewObjectInDatabaseForEntityWithName:@"Show" inContext:tempContext];
            
            @try
            {
                newShow.showId = [showId intValue];
                newShow.name = Name;
                newShow.url = ShowUrl;
                newShow.summary = Summary;
                newShow.genres = Genres;
                newShow.imageM = ImageMedium;
                newShow.rating = [Rate floatValue];
                
                [DatabaseInterface saveChildNSManagedObjectContext:tempContext];
            }
            @catch (NSException *exception)
            {
                NSLog(@"%@",exception);
            }
            
        }
        else
        {
            newShow = [fetchResult lastObject];
        }
        
        
    }];
    
    return newShow;
}

@end
