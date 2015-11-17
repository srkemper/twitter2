//
//  TweetsViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "LoginViewController.h"
#import "TweetTableViewCell.h"
#import "DetailsViewController.h"
#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

#define blueColor [UIColor colorWithRed:97.0/255 green:163.0/255 blue:226.0/255 alpha:1.0];

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([User currentUser] == nil) {
        [self presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
    }
    
    self.navigationItem.title = @"Home";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(composeTweet:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = blueColor;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTableView addSubview:self.refreshControl];
    
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.dataSource = self;
    self.tweetsTableView.estimatedRowHeight = 100.0;
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@20 forKey:@"count"];
    if (self.mentions) {
        [[TwitterClient sharedInstance] mentionsWithParams:params completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
        }];
    }
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil]forCellReuseIdentifier:@"tweetCell"];
}

- (void)onRefresh {
    if (self.mentions) {
        [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
            [self.refreshControl endRefreshing];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *ttvc = [self.tweetsTableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    ttvc.tweetLabel.text = tweet.body;
    ttvc.nameLabel.text = tweet.user.name;
    ttvc.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.handle];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/d/YYYY";
    ttvc.timestampLabel.text = [formatter stringFromDate:tweet.createdAt];
    [ttvc.image setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    ttvc.image.layer.cornerRadius = 5;
    ttvc.image.clipsToBounds = YES;
    ttvc.retweetImage.alpha = tweet.retweeted ? 1 : .5;
    ttvc.favoriteImage.alpha = tweet.favorited ? 1 : .5;
    return ttvc;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSLog(@"selected row %ld", indexPath.row);
    [self.tweetsTableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailsViewController *dvc = [[DetailsViewController alloc] init];
    dvc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
}

- (void)setMentions:(BOOL)mentions {
    _mentions = mentions;
    if (mentions) {
        [[TwitterClient sharedInstance] mentionsWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
        }];
    } else {
        [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
            self.tweets = tweets;
            for (Tweet *tweet in tweets) {
                NSLog(@"text: %@", tweet.body);
            }
            [self.tweetsTableView reloadData];
        }];
    }
}

- (IBAction)onLogout:(id)sender {
    [User logout];
}

- (IBAction)composeTweet:(id)sender {
    NSLog(@"compose tweet");
    NSLog(@"%@", self.navigationController);
    [self.navigationController pushViewController:[[ComposeViewController alloc] init] animated:YES];
//    [self transitionFromViewController:self toViewController:[[ComposeViewController alloc] init] duration:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
//        NSLog(@"swithced to compose");
//    }];
//    [self presentViewController:[[ComposeViewController alloc] init] animated:YES completion:nil];
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
