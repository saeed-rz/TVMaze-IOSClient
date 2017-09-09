//
//  DatabaseManager.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

+ (void)deleteAllObjectsForEntityName:(NSString *)entityName;
+ (NSArray *)getAllObjectsForEntityName:(NSString *)entityName withSortDescriptors:(NSArray *)sortDescriptors andPredicate:(NSPredicate *)predicate;
+ (void)deleteAllObjectsForEntityName:(NSString *)entityName withPredicate:(NSPredicate *)predicate;

@end
