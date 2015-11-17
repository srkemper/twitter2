//
//  HamburgerViewController.h
//  Twitter
//
//  Created by Sean Kemper on 11/11/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@class MenuViewController;

@interface HamburgerViewController : UIViewController

@property (strong, nonatomic) UIViewController *contentViewController;
- (void)setMenuViewController:(MenuViewController *)menuViewController;

@end
