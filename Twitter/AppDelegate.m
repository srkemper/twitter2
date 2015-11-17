//
//  AppDelegate.m
//  Twitter
//
//  Created by Sean Kemper on 11/4/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    HamburgerViewController *hamburgerViewController = [[HamburgerViewController alloc] initWithNibName:@"HamburgerViewController" bundle:nil];
    [self.window setRootViewController:hamburgerViewController];
    [self.window makeKeyAndVisible];
    
    MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    [hamburgerViewController setMenuViewController:menuViewController];
    menuViewController.hamburgerViewController = hamburgerViewController;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:userDidLogoutNotification object:nil];

    TweetsViewController *homeTimelineController = [[TweetsViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    [homeTimelineController setMentions:NO];

    menuViewController.homeTimelineController = homeTimelineController;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeTimelineController];
    
    NSLog(@"%@", homeTimelineController.navigationController);
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    hamburgerViewController.contentViewController = navigationController;
    
    User *user = [User currentUser];
    if (user != nil) {
        NSLog(@"Welcome %@", user.name);
    } else {
        NSLog(@"Not logged in");
        [hamburgerViewController presentViewController:[[LoginViewController alloc] init] animated:NO completion:nil];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [[TwitterClient sharedInstance] openURL:url];
    
    return YES;
}

- (void)userDidLogout {
//    self.window.rootViewController = [[LoginViewController alloc] init];
    [self.window.rootViewController presentViewController:[[LoginViewController alloc] init] animated:YES completion:nil];
}

@end
