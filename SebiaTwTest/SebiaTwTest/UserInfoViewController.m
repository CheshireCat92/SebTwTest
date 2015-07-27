//
//  UserInfoViewController.m
//  SebiaTwTest
//
//  Created by Cheshire on 25.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@end

@implementation UserInfoViewController
@synthesize tweet;
@synthesize UserImage,UserFolowers,UserName;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UserImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.tweetAuthorDetails.profile_image] ] ] ];
    [UserName setText:tweet.tweetAuthorDetails.name];
    [UserFolowers setText:tweet.tweetAuthorDetails.followers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
