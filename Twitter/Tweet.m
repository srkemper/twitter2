//
//  Tweet.m
//  Twitter
//
//  Created by Sean Kemper on 11/4/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.body = dictionary[@"text"];
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdAtString];
        self.retweets = dictionary[@"retweet_count"];
        self.favorites = dictionary[@"favorite_count"];
        self.tweetId = dictionary[@"id_str"];
        self.retweeted = [[dictionary[@"retweeted"] stringValue] isEqualToString:@"0"] ? NO : YES;
        self.favorited = [[dictionary[@"favorited"] stringValue] isEqualToString:@"0"] ? NO : YES;
    }
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
//        NSLog(@"%@", dictionary);
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

@end
