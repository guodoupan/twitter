//
//  MenuViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/16/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)onMention:(id)sender {
    [self.delegate onMention];
}
- (IBAction)onHome:(id)sender {
    [self.delegate onHome];
}
- (IBAction)onProfile:(id)sender {
    [self.delegate onProfile];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
