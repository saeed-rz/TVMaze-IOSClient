//
//  NetworkInterface.h
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface NetworkInterface : NSObject

+ (void)performPOSTRequestWithParameters:(NSDictionary *)parameters
                replaceMainWebServiceURL:(NSString*)mainWebServiceURL
                        headerParameters:(NSDictionary*)headerParams
                                   route:(NSString *)route
                       requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                      responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                        responseDelegate:(id)responseDelegate
                 successResponseSelector:(SEL)successSelector
                    failResponseSelector:(SEL)failSelector
                                userInfo:(NSDictionary *)userInfo;

+ (void)performGETRequestWitHeaderParameters:(NSDictionary *)headersParams
                    replaceMainWebServiceURL:(NSString*)mainWebServiceURL
                                       route:(NSString *)route
                           requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                          responseSerializer:(AFHTTPResponseSerializer *)responseSerializer
                            responseDelegate:(id)responseDelegate
                     successResponseSelector:(SEL)successSelector
                        failResponseSelector:(SEL)failSelector
                                    userInfo:(NSDictionary *)userInfo;

@end
