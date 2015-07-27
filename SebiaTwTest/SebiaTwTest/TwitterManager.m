//
//  TwitterManager.m
//  SebiaTwTest
//
//  Created by Cheshire on 21.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//
#import "ParseHelper.h"
#import "NSString+StringUrlEncode.h"
#import <AFNetworking.h>
#import "TwitterManager.h"

@implementation TwitterManager
{
    AFHTTPRequestOperationManager *manager;
    NSString *bearerToken;
    NSMutableDictionary *tweetsDict;
}

+(id)sharedManager
{
    static TwitterManager *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc]init];
    });
    return shared;
}

-(id)init
{
    if (self = [super init]) {
        
        manager = [[AFHTTPRequestOperationManager manager]initWithBaseURL:[NSURL URLWithString:@"https://api.twitter.com/"]];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:0];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        bearerToken = [NSString new];
        tweetsDict = [NSMutableDictionary new];
    }
    return self;
}

-(void)twAuthorize
{

    NSString *bearerKey = [NSString stringWithFormat:@"%@:%@",TW_CONS_KEY,TW_CONS_SECRET];
    NSData *authData = [bearerKey dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authString = [NSString stringWithFormat:@"Basic %@",[authData base64EncodedStringWithOptions:0]];
    NSMutableDictionary *params = [NSMutableDictionary new];
        params[@"grant_type"] = @"client_credentials";

    [manager.requestSerializer setValue:authString forHTTPHeaderField:@"Authorization"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"oauth2/token" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Login complete wit object -> %@", responseObject);
        bearerToken = [NSString stringWithFormat:@"Bearer %@",[responseObject objectForKey:@"access_token"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Login failure with error -> %@", error);
    }];

    
    
}

-(void)searchTweetsForHashTag:(NSString *)tag
{
    NSString *urlString = @"1.1/search/tweets.json?";
    NSString *requstURLString = [NSString new];
    NSMutableDictionary *params = [NSMutableDictionary new];
    NSString *hashTag = [NSString stringWithFormat:@"#%@",tag];
    params[@"q"] = hashTag;
    params[@"result_type"] = @"mixed";
    
    for (NSString *key in params) {
        NSString *param = [params[key] urlencode];
        requstURLString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@=%@",key,param ] ];
        urlString = [NSString stringWithFormat:@"%@&",requstURLString];
    }
    
    [manager.requestSerializer setValue:bearerToken forHTTPHeaderField:@"Authorization"];
    [manager GET:requstURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Operation complete");
        [[NSNotificationCenter defaultCenter]postNotificationName:TW_MAP_GETTING object:[NSArray arrayWithObjects:responseObject[@"statuses"],tag, nil]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Operation failure");
    }];
    
}

-(void)getTweetMap
{
    
}

@end
