//
//  TwitterManager.h
//  SebiaTwTest
//
//  Created by Cheshire on 21.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import "Constants.h"
#import <Foundation/Foundation.h>

@interface TwitterManager : NSObject

+(id)sharedManager;
-(void)searchTweetsForHashTag:(NSString *)tag;
-(void)twAuthorize;

@end
