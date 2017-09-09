//
//  NetworkInterface.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "NetworkInterface.h"
#import "UtilityManager.h"

@implementation NetworkInterface

static NSString* uRLAddressRoot;

+ (void)performPOSTRequestWithParameters:(NSDictionary *)parameters
                replaceMainWebServiceURL:(NSString*)mainWebServiceURL
                        headerParameters:(NSDictionary*)headerParams
                                   route:(NSString *)route
                       requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                      responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                        responseDelegate:(id)responseDelegate
                 successResponseSelector:(SEL)successSelector
                    failResponseSelector:(SEL)failSelector
                                userInfo:(NSDictionary *)userInfo
{
    mainWebServiceURL = @"http://api.tvmaze.com";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:mainWebServiceURL]];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    if (headerParams)
    {
        for (NSString *key in [headerParams allKeys])
        {
            [manager.requestSerializer setValue:[headerParams objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [manager POST:route parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
        
        //Success
        NSDictionary *responseDict = responseObject;
        NSInvocation *responseInvocation = [UtilityManager createInvocationForSelector:successSelector
                                                                           andDelegate:responseDelegate
                                                                   withSessionDataTask:task
                                                                     andResponseObject:responseDict
                                                                              andError:nil
                                                                           andUserInfo:userInfo];
        
        [responseInvocation invoke];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Failure
        NSInvocation *responseInvocation = [UtilityManager createInvocationForSelector:failSelector
                                                                           andDelegate:responseDelegate
                                                                   withSessionDataTask:task
                                                                     andResponseObject:nil
                                                                              andError:error
                                                                           andUserInfo:userInfo];
        
        [responseInvocation invoke];
    }];
}

+ (void)performGETRequestWitHeaderParameters:(NSDictionary *)headerParams
                    replaceMainWebServiceURL:(NSString *)mainWebServiceURL
                                       route:(NSString *)route
                           requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                          responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                            responseDelegate:(id)responseDelegate
                     successResponseSelector:(SEL)successSelector
                        failResponseSelector:(SEL)failSelector
                                    userInfo:(NSDictionary *)userInfo
{
    mainWebServiceURL = @"http://api.tvmaze.com";
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:mainWebServiceURL]];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer;
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    if (headerParams)
    {
        for (NSString *key in [headerParams allKeys])
        {
            [manager.requestSerializer setValue:[headerParams objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    [manager GET:route parameters:nil success:^(NSURLSessionDataTask *task, id responseObject){
        
        //Success
        NSDictionary *responseDict = responseObject;
        NSInvocation *responseInvocation = [UtilityManager createInvocationForSelector:successSelector
                                                                           andDelegate:responseDelegate
                                                                   withSessionDataTask:task
                                                                     andResponseObject:responseDict
                                                                              andError:nil
                                                                           andUserInfo:userInfo];
        
        [responseInvocation invoke];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //Failure
        NSInvocation *responseInvocation = [UtilityManager createInvocationForSelector:failSelector
                                                                           andDelegate:responseDelegate
                                                                   withSessionDataTask:task
                                                                     andResponseObject:nil
                                                                              andError:error
                                                                           andUserInfo:userInfo];
        
        [responseInvocation invoke];
    }];
}

@end
