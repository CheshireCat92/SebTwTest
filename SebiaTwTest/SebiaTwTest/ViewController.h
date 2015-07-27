//
//  ViewController.h
//  SebiaTwTest
//
//  Created by Cheshire on 20.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;

@end

