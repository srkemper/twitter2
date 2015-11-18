//
//  MenuViewController.m
//  Twitter
//
//  Created by Sean Kemper on 11/11/15.
//  Copyright © 2015 Sean Kemper. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"
#import "TweetsViewController.h"
#import "HamburgerViewController.h"
#import "ProfileViewController.h"

@interface MenuViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;

@property (strong, nonatomic) ProfileViewController *profileViewController;

@property (nonatomic, strong) NSArray *views;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.views = @[@"Home Timeline", @"Profile", @"Mentions", @"Sign Out"];
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil]forCellReuseIdentifier:@"menuCell"];
    
    self.profileViewController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.views.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *mtvc = [self.menuTableView dequeueReusableCellWithIdentifier:@"menuCell"];
    mtvc.menuLabel.text = self.views[indexPath.row];
    return mtvc;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            [self.homeTimelineController setMentions:NO];
            self.hamburgerViewController.contentViewController = [self.homeTimelineController navigationController];
            break;
        }
        case 1:
        {
            //set user here first
            self.profileViewController = [[ProfileViewController alloc] initWithUser:[User currentUser]];
//            [self.hamburgerViewController.contentViewController.navigationController pushViewController:pvc animated:YES];
            self.hamburgerViewController.contentViewController = self.profileViewController;
            break;
        }
        case 2:
        {
            [self.homeTimelineController setMentions:YES];
            self.hamburgerViewController.contentViewController = [self.homeTimelineController navigationController];
            break;
        }
        case 3:
        {
            [User logout];
            break;
        }
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
