//
//  ProfileViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/16/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetTableViewCell.h"

@interface ProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateViews];
    
    self.tweetsTableView.dataSource = self;
    self.tweetsTableView.delegate = self;
    self.tweetsTableView.estimatedRowHeight = 100.0;
    self.tweetsTableView.rowHeight = UITableViewAutomaticDimension;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.user.handle forKey:@"screen_name"];
    [[TwitterClient sharedInstance] userTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        NSLog(@"\n\n\n USER TWEETS \n\n\n");
        for (Tweet *tweet in tweets) {
            NSLog(@"text: %@", tweet.body);
        }
        [self.tweetsTableView reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tweetsTableView reloadData];
        });
    }];
    [self.tweetsTableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil]forCellReuseIdentifier:@"tweetCell"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"number of rows %ld", self.tweets.count);
    return self.tweets.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (id)initWithUser:(User *)user {
    self = [super init];
    _user = user;
    if (user) {
        [self updateViews];
        [self.tweetsTableView reloadData];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateViews {
    if (self.user) {
        self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.user.handle];;
        self.nameLabel.text = self.user.name;
        self.tweetsLabel.text = [NSString stringWithFormat:@"%ld", self.user.tweets];
        self.followersLabel.text = [NSString stringWithFormat:@"%ld", self.user.followers];
        self.followingLabel.text = [NSString stringWithFormat:@"%ld", self.user.following];
        [self.backgroundImageView setImageWithURL:[NSURL URLWithString:self.user.coverPhotoImageUrl]];
        [self.profileImageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
        self.profileImageView.layer.cornerRadius = 5;
        self.profileImageView.clipsToBounds = YES;
    }
//    [self.view updateConstraintsIfNeeded];
}

- (void)setUser:(User *)user {
    _user = user;
    [self updateViews];
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
