//
//  UserInfoViewController.h
//  SebiaTwTest
//
//  Created by Cheshire on 25.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "TweetAuthorDetails.h"

@interface UserInfoViewController : UIViewController

@property (strong, nonatomic) Tweet *tweet;
@property (strong, nonatomic) IBOutlet UIImageView *UserImage;
@property (strong, nonatomic) IBOutlet UILabel *UserName;
@property (strong, nonatomic) IBOutlet UILabel *UserFolowers;


@end
