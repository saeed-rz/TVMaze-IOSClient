//
//  DatabaseInterface.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "DatabaseInterface.h"

@implementation DatabaseInterface

+ (NSArray *)executeFetchRequestInDBForEntityWithName:(NSString *)entityName
                                        withPredicate:(NSPredicate *)predicate
                                  withSortDescriptors:(NSArray *)sortDescriptors
                           shouldReturnObjectAsFaults:(BOOL)returnAsFaults
{
    __block NSArray *fetchedObjects;
    
    NSManagedObjectContext *tempContext = [self createAndSetupNewTemporaryManagedObjectContext];
    [tempContext performBlockAndWait:^{
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:tempContext];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        [fetchRequest setReturnsObjectsAsFaults:returnAsFaults];
        [fetchRequest setPredicate:predicate];
        
        fetchedObjects = [tempContext executeFetchRequest:fetchRequest error:nil];
    }];
    
    NSMutableArray *fetchedObjectsOnMainThread = [@[] mutableCopy];
    
    for (NSManagedObject *fetchedObject in fetchedObjects)
    {
        [fetchedObjectsOnMainThread addObject:[[(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext] objectWithID:fetchedObject.objectID]];
    }
    
    return [fetchedObjectsOnMainThread copy];
}

+ (NSManagedObject *)insertNewObjectInDatabaseForEntityWithName:(NSString *)entityName inContext:(NSManagedObjectContext *)tempContext
{
    __block NSManagedObject *newObject = nil;
    
    [tempContext performBlockAndWait:^{
        
        newObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:tempContext];
        
        [self saveChildNSManagedObjectContext:tempContext];
    }];
    
    return newObject;
}

+ (NSManagedObjectContext *)createAndSetupNewTemporaryManagedObjectContext
{
    __block NSManagedObjectContext *moc = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    NSManagedObjectContext *tempContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    tempContext.parentContext = moc;
    
    return tempContext;
}

+ (void)saveChildNSManagedObjectContext:(NSManagedObjectContext *)moc
{
    NSError *error;
    //    NSManagedObjectContext *moc = [ApplicationDelegate managedObjectContext];
    //    if (![moc save:&error]) {
    //        NSLog(@"Failed to save to data store: %@ - %@",
    //              [error localizedDescription], [error userInfo]);
    //    }
    
    if (![moc save:&error])
    {
        NSLog(@"Core Data save error %@, %@", [error localizedDescription], [error userInfo]);
    }
    [moc performBlockAndWait:^{
        
        NSError *error = nil;
        if (![moc.parentContext save:&error])
        {
            NSLog(@"Core Data save error %@, %@", [error localizedDescription], [error userInfo]);
        }
    }];
}

+ (void)deleteManagedObject:(NSManagedObject *)managedObject inContext:(NSManagedObjectContext *)context
{
    [context deleteObject:managedObject];
    [self saveChildNSManagedObjectContext:context];
}

@end
