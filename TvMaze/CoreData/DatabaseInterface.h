//
//  DatabaseInterface.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface DatabaseInterface : NSObject

+ (NSManagedObject *)insertNewObjectInDatabaseForEntityWithName:(NSString *)entityName inContext:(NSManagedObjectContext *)tempContext;
+ (NSManagedObjectContext *)createAndSetupNewTemporaryManagedObjectContext;
+ (void)saveChildNSManagedObjectContext:(NSManagedObjectContext *)moc;
+ (void)deleteManagedObject:(NSManagedObject *)managedObject inContext:(NSManagedObjectContext *)context;
+ (NSArray *)executeFetchRequestInDBForEntityWithName:(NSString *)entityName
                                        withPredicate:(NSPredicate *)predicate
                                  withSortDescriptors:(NSArray *)sortDescriptors
                           shouldReturnObjectAsFaults:(BOOL)returnAsFaults;

@end
