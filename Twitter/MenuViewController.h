//
//  MenuViewController.h
//  Twitter
//
//  Created by Sean Kemper on 11/11/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerViewController.h"
#import "TweetsViewController.h"

@class HamburgerViewController;

@interface MenuViewController : UIViewController

@property (strong, nonatomic) TweetsViewController *homeTimelineController;
@property (strong, nonatomic) HamburgerViewController *hamburgerViewController;

@end
