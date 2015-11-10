//
//  ComposeViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/8/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import "User.h"
#import "Tweet.h"
#import "MBProgressHUD.h"

@interface ComposeViewController () <UITextViewDelegate>

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"Compose";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelTweet:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleDone target:self action:@selector(postTweet:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    self.composeBox.delegate = self;
    [self.composeBox becomeFirstResponder];
}
     
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"text field length is %ld", textView.text.length);
    return textView.text.length < 140;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postTweet:(id)sender {
    //start spinner
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"posting tweet: %@", self.composeBox.text);
    //post request
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.composeBox.text forKey:@"status"];
    [[TwitterClient sharedInstance] postTweet:params completion:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if (error != nil) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Post Failed"
                                                                           message:@"Could not post tweet. Check your network connection and try again."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    //stop spinner
    //pop view controller
}

- (IBAction)cancelTweet:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
