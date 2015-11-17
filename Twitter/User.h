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
@property (strong, nonatomic) NSString *tagline;

//@property (strong, nonatomic) NSInteger tweets;
//@property (strong, nonatomic) NSInteger following;
//@property (strong, nonatomic) NSInteger followers;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;
+ (void)setCurrentUser:(User *)currentUser;
+ (void)logout;

@end
