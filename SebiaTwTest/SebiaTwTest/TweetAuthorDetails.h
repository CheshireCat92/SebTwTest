//
//  TweetAuthorDetails.h
//  SebiaTwTest
//
//  Created by Cheshire on 27.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TweetAuthorDetails : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * profile_image;
@property (nonatomic, retain) NSString * followers;

@end
