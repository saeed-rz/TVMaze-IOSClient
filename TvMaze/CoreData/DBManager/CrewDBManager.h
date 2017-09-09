//
//  CrewDBManager.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Crew+CoreDataClass.h"
#import "DatabaseInterface.h"
#import "DatabaseManager.h"

@interface CrewDBManager : DatabaseManager

+ (Crew *)storeCrew:(NSString *)title andRole:(NSString *) role;

@end
