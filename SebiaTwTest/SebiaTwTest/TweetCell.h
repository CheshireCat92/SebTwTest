//
//  TweetCell.h
//  SebiaTwTest
//
//  Created by Cheshire on 24.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *tweetUserImage;
@property (strong, nonatomic) IBOutlet UILabel *hashtagLabel;
@property (strong, nonatomic) IBOutlet UITextView *tweetTextField;
@property (strong, nonatomic) IBOutlet UILabel *tweetPostingDateLabel;

@end
