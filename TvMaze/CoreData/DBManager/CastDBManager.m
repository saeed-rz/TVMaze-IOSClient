//
//  CastDBManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "CastDBManager.h"

@implementation CastDBManager

+ (Cast *)storeCast:(NSString *)title
{
    __block Cast *newCast = nil;
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    
    [tempContext performBlockAndWait:^{
        
        
        newCast = (Cast *)[DatabaseInterface insertNewObjectInDatabaseForEntityWithName:@"Cast" inContext:tempContext];
        
        @try
        {
            newCast.castTitle = title;
            
            
            [DatabaseInterface saveChildNSManagedObjectContext:tempContext];
        }
        @catch (NSException *exception)
        {
            NSLog(@"%@",exception);
        }
        
        
        
    }];
    
    return newCast;
}

@end
