//
//  UtilityManager.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "UtilityManager.h"

@implementation UtilityManager

+ (NSInvocation *)createInvocationForSelector:(SEL)callbackSelector
                                  andDelegate:(id)callbackDelegate
                          withSessionDataTask:(NSURLSessionDataTask *)sessionDatatask
                            andResponseObject:(NSDictionary *)responseDictionary
                                     andError:(NSError *)error
                                  andUserInfo:(NSDictionary *)userInfo
{
    if([callbackDelegate respondsToSelector:callbackSelector])
    {
        NSInvocation *callbackInvocation = [NSInvocation invocationWithMethodSignature:[callbackDelegate methodSignatureForSelector:callbackSelector]];
        [callbackInvocation setSelector:callbackSelector];
        [callbackInvocation setTarget:callbackDelegate];
        
        // Arguments 0 and 1 are 'self' and '_cmd' respectively
        // Automatically set by NSInvocation
        
        [callbackInvocation setArgument:&(sessionDatatask) atIndex:2];
        
        if (responseDictionary)
            [callbackInvocation setArgument:&(responseDictionary) atIndex:3];
        else
            [callbackInvocation setArgument:&(error) atIndex:3];
        
        [callbackInvocation setArgument:&(userInfo) atIndex:4];
        
        return callbackInvocation;
    }
    return nil;
}

@end
