//
//  TweetsViewController.h
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tweetsTableView;
@property (nonatomic, assign) BOOL mentions;

@end
