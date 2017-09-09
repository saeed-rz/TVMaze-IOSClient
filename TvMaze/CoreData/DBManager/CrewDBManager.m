//
//  CrewDBManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "CrewDBManager.h"

@implementation CrewDBManager

+ (Crew *)storeCrew:(NSString *)title andRole:(NSString *) role
{
    __block Crew *newCrew = nil;
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    
    [tempContext performBlockAndWait:^{


            newCrew = (Crew *)[DatabaseInterface insertNewObjectInDatabaseForEntityWithName:@"Crew" inContext:tempContext];
            
            @try
            {
//                newCrew.showId = [showId intValue];
                newCrew.crewTitle = title;
                newCrew.crewRole = role;
                
                [DatabaseInterface saveChildNSManagedObjectContext:tempContext];
            }
            @catch (NSException *exception)
            {
                NSLog(@"%@",exception);
            }
        
        
        
    }];
    
    return newCrew;
}

@end
