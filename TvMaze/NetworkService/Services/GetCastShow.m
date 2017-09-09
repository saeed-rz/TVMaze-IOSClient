//
//  GetCastShow.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "GetCastShow.h"
#import "CastDBManager.h"

@implementation GetCastShow

+ (void)getCastShow:(NSInteger)showId
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSString *route = [NSString stringWithFormat:@"/shows/%li/cast",(long)showId];
    [NetworkInterface performGETRequestWitHeaderParameters:nil
                                  replaceMainWebServiceURL:nil
                                                     route:route
                                         requestSerializer:JSONRequestSerializer
                                        responseSerializer:JSONResponseSerializer
                                          responseDelegate:self
                                   successResponseSelector:@selector(didFinishGetAllShowWebServiceWithSessionDataTask:withResponseDictionary:withUserInfo:)
                                      failResponseSelector:@selector(didFailToFinishGetAllShowWebServiceWithSessionDataTask:withError:withUserInfo:)
                                                  userInfo:nil];
}

+ (void)didFinishGetAllShowWebServiceWithSessionDataTask:(NSURLSessionDataTask *)task withResponseDictionary:(NSDictionary *)responseObject withUserInfo:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    [DatabaseManager deleteAllObjectsForEntityName:@"Cast"];
    
    NSArray *castArray = responseObject;
    
    for (int index = 0; index < castArray.count; index++)
    {
        NSDictionary *cast = [castArray objectAtIndex:index];
        
        [CastDBManager storeCast:[[cast objectForKey:@"person"] objectForKey:@"name"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllCastSucceedNotification object:nil];
}

+ (void)didFailToFinishGetAllShowWebServiceWithSessionDataTask:(NSURLSessionDataTask *)task withError:(NSError *)error withUserInfo:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllCastFailedNotification object:nil];
}

@end
