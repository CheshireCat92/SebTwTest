//
//  ParseHelper.h
//  SebiaTwTest
//
//  Created by Cheshire on 24.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParseHelper : NSObject

+(void)parseJSONToTweetObjectsMapFromJson:(NSDictionary *)json withTag:(NSString*)tag;

@end
