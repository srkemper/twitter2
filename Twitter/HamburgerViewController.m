//
//  HamburgerViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/11/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "HamburgerViewController.h"
#import "MenuViewController.h"

@interface HamburgerViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMarginConstraint;

@property (nonatomic, assign) CGFloat originalLeftMargin;
@property (strong, nonatomic) MenuViewController *menuViewController;

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation HamburgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTapGesture:(id)sender {
    NSLog(@"tap gesture");
    [self closeMenu];
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.originalLeftMargin = self.leftMarginConstraint.constant;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.leftMarginConstraint.constant = self.originalLeftMargin + translation.x;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            if (velocity.x > 0) {
                self.leftMarginConstraint.constant = self.view.frame.size.width - 50;
                [self.contentView addGestureRecognizer:self.tapRecognizer];
            } else {
                [self.contentView removeGestureRecognizer:self.tapRecognizer];
                self.leftMarginConstraint.constant = 0;
            }
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)closeMenu {
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView removeGestureRecognizer:self.tapRecognizer];
        self.leftMarginConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)setMenuViewController:(MenuViewController *)menuViewController {
    _menuViewController = menuViewController;
    [self.menuView addSubview:menuViewController.view];
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    NSLog(@"set content view controller from %@ to %@",_contentViewController, contentViewController);
    [self removeInactiveViewController:_contentViewController];
    [self updateActiveViewController:contentViewController];
    [self closeMenu];
}

- (void)removeInactiveViewController:(UIViewController *)inactiveViewController {
    if (inactiveViewController != nil) {
        NSLog(@"removing inactive view controller %@", inactiveViewController);
        [inactiveViewController willMoveToParentViewController:nil];
        [inactiveViewController.view removeFromSuperview];
        [inactiveViewController removeFromParentViewController];
    }
}

- (void)updateActiveViewController:(UIViewController *)activeViewController {
    if (activeViewController != nil) {
        NSLog(@"setting active view controller %@", activeViewController);
        [self.contentViewController addChildViewController:activeViewController];
        activeViewController.view.frame = self.contentView.bounds;
        [self.contentView addSubview:activeViewController.view];
        [activeViewController didMoveToParentViewController:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
