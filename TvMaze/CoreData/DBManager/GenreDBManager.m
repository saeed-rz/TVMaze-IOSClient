//
//  GenreDBManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "GenreDBManager.h"

@implementation GenreDBManager

+ (Genre *)storeGenre:(NSString *)genre
{
    __block Genre *newGenre = nil;
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    
    [tempContext performBlockAndWait:^{
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"genreTitle = %@", genre];
        NSArray *fetchResult = [DatabaseInterface executeFetchRequestInDBForEntityWithName:@"Genre"
                                                                             withPredicate:predicate
                                                                       withSortDescriptors:nil
                                                                shouldReturnObjectAsFaults:NO];
        
        if (!fetchResult || ([fetchResult count] > 1))
        {
            // Error
        }
        else if ([fetchResult count] == 0)
        {
            newGenre = (Genre *)[DatabaseInterface insertNewObjectInDatabaseForEntityWithName:@"Genre" inContext:tempContext];
            
            @try
            {
                newGenre.genreTitle = genre;
                
                
                [DatabaseInterface saveChildNSManagedObjectContext:tempContext];
            }
            @catch (NSException *exception)
            {
                NSLog(@"%@",exception);
            }
            
        }
        else
        {
            newGenre = [fetchResult lastObject];
        }
        
        
    }];
    
    return newGenre;
}

@end
