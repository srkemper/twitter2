//
//  DetailsViewController.h
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetBody;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *retweetCount;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCount;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *likeImage;

@property (nonatomic, strong) Tweet *tweet;

@end
