//
//  BurgerViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/16/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "BurgerViewController.h"
#import "MenuViewController.h"
#import "ContentViewController.h"

@interface BurgerViewController () <MenuViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) MenuViewController *menuVC;
@property (nonatomic, strong) ContentViewController *contentVC;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat screenWidth;

@end

@implementation BurgerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuVC = [[MenuViewController alloc] init];
    self.contentVC = [[ContentViewController alloc] init];
    
    [self.contentView addSubview: self.menuVC.view];
    [self.contentView addSubview:self.contentVC.view];
    
    self.menuVC.delegate = self;
    self.contentVC.user = self.user;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    self.screenWidth = [[UIScreen mainScreen] bounds].size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPan:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.origin = self.contentVC.view.center;
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [sender translationInView:sender.view];
        NSLog(@"translation: %f", translation.x);
        self.contentVC.view.center = CGPointMake(self.origin.x + translation.x, self.origin.y);
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [sender velocityInView:sender.view];
        if (velocity.x > 0) {
            [self openMenu];
        } else {
            [self closeMenu];
        }
    }
}

- (void) closeMenu {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentVC.view.center = CGPointMake(self.screenWidth / 2, self.origin.y);
    }];
}

- (void) openMenu {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentVC.view.center = CGPointMake(self.screenWidth * 3 / 2 - 50, self.origin.y);
    }];
}

- (void)onHome {
   [UIView animateWithDuration:0.3 animations:^{
       self.contentVC.view.center = CGPointMake(self.screenWidth / 2, self.origin.y);
   } completion:^(BOOL finished) {
       [self.contentVC showHome];
   }];
}

- (void)onMention {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentVC.view.center = CGPointMake(self.screenWidth / 2, self.origin.y);
    } completion:^(BOOL finished) {
        [self.contentVC showMention];
    }];
}

- (void)onProfile {
    [UIView animateWithDuration:0.3 animations:^{
        self.contentVC.view.center = CGPointMake(self.screenWidth / 2, self.origin.y);
    } completion:^(BOOL finished) {
        [self.contentVC showProfile];
    }];
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
