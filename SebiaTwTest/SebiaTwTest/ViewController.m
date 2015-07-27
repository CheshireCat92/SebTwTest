//
//  ViewController.m
//  SebiaTwTest
//
//  Created by Cheshire on 20.07.15.
//  Copyright (c) 2015 Cheshire. All rights reserved.
//
#import "ParseHelper.h"
#import "TwitterManager.h"
#import "ViewController.h"
#import "Tweet.h"
#import "TweetAuthorDetails.h"
#import "TweetCell.h"
#import "UserInfoViewController.h"

@interface ViewController ()
{
    NSMutableArray *tweetMap;
}

@end

@implementation ViewController
@synthesize searchTextField, loadIndicator;

-(void)viewWillAppear:(BOOL)animated {
    
    [self fetchAllTweets];
    [self.tweetTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[TwitterManager sharedManager] twAuthorize];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTwMapGetting:) name:TW_MAP_GETTING object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFindTwButtonTouch:(id)sender {
    NSString *searchText = [NSString new];
    if ([searchTextField.text isEqualToString:@""]) {
        return;
    }
    searchText  = searchTextField.text;
    [self.loadIndicator startAnimating];
    [[TwitterManager sharedManager] searchTweetsForHashTag:searchText];
   
}

-(void)onTwMapGetting:(NSNotification*)notification
{
    [[NSManagedObjectContext MR_defaultContext] performBlockAndWait:^{
        [self clearTweets];
        NSDictionary *json = [notification.object objectAtIndex:0];
        NSString *tag = [notification.object objectAtIndex:1];
        [ParseHelper parseJSONToTweetObjectsMapFromJson:json  withTag:tag];
        [self fetchAllTweets];
        [self.tweetTableView reloadData];
        [self.loadIndicator stopAnimating];
    }];
    
}

-(void)fetchAllTweets
{
//    tweetMap = [[Tweet MR_findAll] copy];
    tweetMap = [[Tweet MR_findAllSortedBy:@"tag,date" ascending:NO]copy];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

-(void)clearTweets
{
    [tweetMap enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [Tweet MR_truncateAll];
        [TweetAuthorDetails MR_truncateAll];
    }];
}

#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tweetMap.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_REUSE_ID];
    if (!cell) {
        cell = [[TweetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_REUSE_ID];
    }
    Tweet *newTweet = tweetMap[indexPath.row];
    [cell.tweetTextField setText:newTweet.text];
    [cell.tweetPostingDateLabel setText:newTweet.date];
    [cell.tweetUserImage setImage:[UIImage imageWithData:newTweet.tweetAuthorDetails.profile_image] ];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Seg");
    UserInfoViewController *upcomingView = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tweetTableView indexPathForSelectedRow];
    Tweet *tweet = tweetMap[indexPath.row];
    upcomingView.tweet = tweet;
}



@end
