//
//  ParseHelper.m
//  SebiaTwTest
//
//  Created by Cheshire on 24.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import "ParseHelper.h"
#import "Tweet.h"
#import "TweetAuthorDetails.h"

@implementation ParseHelper

+(void)parseJSONToTweetObjectsMapFromJson:(NSDictionary *)json withTag:(NSString*)tag
{
    
        for (NSDictionary *nTweet in json) {
            Tweet* newTweet = [Tweet MR_createEntity];
            if (newTweet.tweetAuthorDetails == nil) {
                newTweet.tweetAuthorDetails = [TweetAuthorDetails  MR_createEntity];
            };
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            newTweet.text = nTweet[@"text"];
            newTweet.date = nTweet[@"created_at"];
            newTweet.tag = tag;
            

            newTweet.tweetAuthorDetails.followers = [nTweet[@"user"][@"friends_count"]stringValue];
            newTweet.tweetAuthorDetails.name = nTweet[@"user"][@"name"];
            UIImage *profileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nTweet[@"user"][@"profile_image_url"] ] ] ];
            NSData *profileImageData =UIImagePNGRepresentation(profileImage);
            newTweet.tweetAuthorDetails.profile_image = profileImageData;
            }];
        }

    
}


@end
