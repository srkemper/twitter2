//
//  DetailsViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"
#import "MBProgressHUD.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Tweet";
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.handle];
    self.tweetBody.text = self.tweet.body;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MM/d/YYYY HH:mm:ss";
    self.timestamp.text = [formatter stringFromDate:self.tweet.createdAt];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.retweetCount.text = [self.tweet.retweets stringValue];
    self.favoriteCount.text = [self.tweet.favorites stringValue];
    
    UITapGestureRecognizer *retweetTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(retweetClicked:)];
    retweetTap.numberOfTapsRequired = 1;
    [self.retweetImage setUserInteractionEnabled:YES];
    [self.retweetImage addGestureRecognizer:retweetTap];
    
    UITapGestureRecognizer *favoriteTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoriteClicked:)];
    favoriteTap.numberOfTapsRequired = 1;
    [self.likeImage setUserInteractionEnabled:YES];
    [self.likeImage addGestureRecognizer:favoriteTap];
    
    self.likeImage.alpha = self.tweet.favorited ? 1 : .5;
    self.retweetImage.alpha = self.tweet.retweeted ? 1 : .5;
}

- (IBAction)retweetClicked:(id)sender {
    if (self.retweetImage.alpha == 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"retweet");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.tweet.tweetId forKey:@"id"];
    [[TwitterClient sharedInstance] retweet:params completion:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error != nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Retweet Failed"
                                                                           message:@"Could not post retweet. Check your network connection and try again."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
//            [self.navigationController popViewControllerAnimated:YES];
            NSInteger incrementedRetweets = [self.tweet.retweets intValue] + 1;
            self.retweetCount.text = [NSString stringWithFormat:@"%ld", incrementedRetweets];
            self.retweetImage.alpha = 1;
        }
    }];
}

- (IBAction)favoriteClicked:(id)sender {
    if (self.likeImage.alpha == 1) {
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"favorite");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.tweet.tweetId forKey:@"id"];
    [[TwitterClient sharedInstance] favorite:params completion:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error != nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Favorite Failed"
                                                                           message:@"Could not post favorite. Check your network connection and try again."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
//            [self.navigationController popViewControllerAnimated:YES];
            NSInteger incrementedFavorites = [self.tweet.favorites intValue] + 1;
            self.favoriteCount.text = [NSString stringWithFormat:@"%ld", incrementedFavorites];
            self.likeImage.alpha = 1;
        }
    }];
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
