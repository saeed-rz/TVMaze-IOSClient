//
//  UtilityManager.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityManager : NSObject

+ (NSInvocation *)createInvocationForSelector:(SEL)callbackSelector
                                  andDelegate:(id)callbackDelegate
                          withSessionDataTask:(NSURLSessionDataTask *)sessionDatatask
                            andResponseObject:(NSDictionary *)responseDictionary
                                     andError:(NSError *)error
                                  andUserInfo:(NSDictionary *)userInfo;

@end
