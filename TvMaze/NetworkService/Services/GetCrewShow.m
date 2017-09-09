//
//  GetCrewShow.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "GetCrewShow.h"
#import "CrewDBManager.h"

@implementation GetCrewShow

+ (void)getCrewShow:(NSInteger) showId
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
     NSString *route = [NSString stringWithFormat:@"/shows/%li/crew",(long)showId];
    
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
    
    [DatabaseManager deleteAllObjectsForEntityName:@"Crew"];
    
    NSArray *crewArray = responseObject;

    for (int index = 0; index < crewArray.count; index++)
    {
        NSDictionary *crew = [crewArray objectAtIndex:index];
        
        [CrewDBManager  storeCrew:[[crew objectForKey:@"person"] objectForKey:@"name"] andRole:[crew objectForKey:@"type"] ];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllCrewSucceedNotification object:nil];
}

+ (void)didFailToFinishGetAllShowWebServiceWithSessionDataTask:(NSURLSessionDataTask *)task withError:(NSError *)error withUserInfo:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllCrewFailedNotification object:nil];
}

@end
