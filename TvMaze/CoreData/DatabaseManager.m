//
//  DatabaseManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "DatabaseManager.h"
#import "DatabaseInterface.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@implementation DatabaseManager

+ (void)deleteAllObjectsForEntityName:(NSString *)entityName
{
    __block NSArray *fetchedObjects;
    
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    [tempContext performBlockAndWait:^{
        
        fetchedObjects = [DatabaseInterface executeFetchRequestInDBForEntityWithName:entityName
                                                                       withPredicate:nil
                                                                 withSortDescriptors:nil
                                                          shouldReturnObjectAsFaults:NO];
        
        if (fetchedObjects)
        {
            for (NSManagedObject *object in fetchedObjects)
            {
                [DatabaseInterface deleteManagedObject:object inContext:object.managedObjectContext];
            }
        }
    }];
}

+ (void)deleteAllObjectsForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate
{
    __block NSArray *fetchedObjects;
    
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    [tempContext performBlockAndWait:^{
        
        fetchedObjects = [DatabaseInterface executeFetchRequestInDBForEntityWithName:entityName
                                                                       withPredicate:predicate
                                                                 withSortDescriptors:nil
                                                          shouldReturnObjectAsFaults:NO];
        
        if (fetchedObjects)
        {
            for (NSManagedObject *object in fetchedObjects)
            {
                [DatabaseInterface deleteManagedObject:object inContext:object.managedObjectContext];
            }
        }
    }];
}

+ (NSArray *)getAllObjectsForEntityName:(NSString *)entityName withSortDescriptors:(NSArray *)sortDescriptors andPredicate:(NSPredicate *)predicate
{
    __block NSArray *fetchedObjects;
    
    NSManagedObjectContext *tempContext = [DatabaseInterface createAndSetupNewTemporaryManagedObjectContext];
    [tempContext performBlockAndWait:^{
        
        fetchedObjects = [DatabaseInterface executeFetchRequestInDBForEntityWithName:entityName
                                                                       withPredicate:predicate
                                                                 withSortDescriptors:sortDescriptors
                                                          shouldReturnObjectAsFaults:NO];
    }];
    
    NSMutableArray *objectsOnMainThread = [[NSMutableArray alloc] init];
    for (int i = 0; i < [fetchedObjects count]; i++)
    {
        NSManagedObject *managedObject = [fetchedObjects objectAtIndex:i];
        [objectsOnMainThread addObject:[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] objectWithID:managedObject.objectID]];
    }
    return [objectsOnMainThread copy];
}

@end
