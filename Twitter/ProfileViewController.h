//
//  ProfileViewController.h
//  Twitter
//
//  Created by Sean Kemper on 11/16/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) User *user;

- (id)initWithUser:(User *)user;

@end
