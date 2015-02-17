//
//  ContentViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/16/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()
@property (nonatomic, strong) HomeViewController *homeVC;
@property (nonatomic, strong) MentionViewController *mentionVC;
@property (nonatomic, strong) ProfileViewController *profileVC;

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeVC = [[HomeViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    self.mentionVC = [[MentionViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    self.profileVC = [[ProfileViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    
    [self showHome];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showHome {
    self.homeVC.user = self.user;
    self.homeVC.view.frame = self.view.frame;
    [self.view addSubview:self.homeVC.view];
    [self.homeVC viewDidLoad];
}

- (void)showMention {
    self.mentionVC.view.frame = self.view.frame;
    [self.view addSubview:self.mentionVC.view];
    [self.mentionVC viewDidLoad];
}

- (void)showProfile {
    self.profileVC.view.frame = self.view.frame;
    [self.view addSubview:self.profileVC.view];
    [self.profileVC viewDidLoad];
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
