//
//  GetAllShow.m
//  TvMaze
//
//  Created by Saeed on 9/9/17.
//  Copyright © 2017 Saeed. All rights reserved.
//

#import "GetAllShow.h"
#import "ShowDBManager.h"
#import "GenreDBManager.h"

@implementation GetAllShow

+ (void)getAllShow
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [NetworkInterface performGETRequestWitHeaderParameters:nil
                                     replaceMainWebServiceURL:nil
                                                        route:@"/shows"
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
    
    
    NSArray *showArray = responseObject;
    NSString *genre = @"";
    NSArray *genres;
    
    for (int index = 0; index < showArray.count; index++)
    {
        NSDictionary *show = [showArray objectAtIndex:index];
        genres = [show objectForKey:@"genres"];
        
        for (int i = 0; i < [genres count]; i++)
        {
            [GenreDBManager storeGenre:[genres objectAtIndex:i]];
            if(i == 0)
            {
                genre = [NSString stringWithFormat:@"%@",[genres objectAtIndex:i]];
            }
            else
            {
                genre = [NSString stringWithFormat:@"%@,%@",genre,[genres objectAtIndex:i]];
            }
            
        }
        
        [ShowDBManager storeShowWithID:[show objectForKey:@"id"]
                                  Rate:[[show objectForKey:@"rating"] objectForKey:@"average"]
                               ShowUrl:[show objectForKey:@"url"]
                               Summary:[show objectForKey:@"summary"]
                                  Name:[show objectForKey:@"name"]
                           ImageMedium:[[show objectForKey:@"image"] objectForKey:@"medium"]
                                Genres:genre];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllShowSucceedNotification object:nil];
}

+ (void)didFailToFinishGetAllShowWebServiceWithSessionDataTask:(NSURLSessionDataTask *)task withError:(NSError *)error withUserInfo:(NSDictionary *)userInfo
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:GetAllShowFailedNotification object:nil];
}

@end
