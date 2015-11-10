//
//  TwitterClient.h
//  Twitter
//
//  Created by Sean Kemper on 11/4/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openURL:(NSURL *)url;

- (void)homeTimelineWithParams:(NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
- (void)postTweet:(NSDictionary *)params completion:(void (^)(NSError *error))completion;
- (void)retweet:(NSDictionary *)params completion:(void (^)(NSError *error))completion;
- (void)favorite:(NSDictionary *)params completion:(void (^)(NSError *error))completion;

@end
