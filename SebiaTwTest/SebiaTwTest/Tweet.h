//
//  Tweet.h
//  SebiaTwTest
//
//  Created by Cheshire on 27.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TweetAuthorDetails;

@interface Tweet : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * tag;
@property (nonatomic, retain) TweetAuthorDetails *tweetAuthorDetails;

@end
