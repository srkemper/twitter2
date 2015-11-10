//
//  Tweet.h
//  Twitter
//
//  Created by Sean Kemper on 11/4/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSDate *createdAt;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSNumber *retweets;
@property (strong, nonatomic) NSNumber *favorites;
@property (strong, nonatomic) NSString *tweetId;
@property (nonatomic) BOOL favorited;
@property (nonatomic) BOOL retweeted;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
