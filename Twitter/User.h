//
//  User.h
//  Twitter
//
//  Created by Sean Kemper on 11/4/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const userDidLoginNotification;
extern NSString * const userDidLogoutNotification;

@interface User : NSObject

@property (strong, nonatomic) NSString *handle;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *profileImageUrl;
@property (strong, nonatomic) NSString *coverPhotoImageUrl;
@property (strong, nonatomic) NSString *tagline;

@property (assign, nonatomic) NSInteger tweets;
@property (assign, nonatomic) NSInteger following;
@property (assign, nonatomic) NSInteger followers;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logout;

@end
