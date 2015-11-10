//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@end
