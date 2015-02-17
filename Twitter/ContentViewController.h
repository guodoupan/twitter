//
//  ContentViewController.h
//  Twitter
//
//  Created by Doupan Guo on 2/16/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "TweetsViewController.h"
#import "MentionViewController.h"
#import "ProfileViewController.h"
#import "HomeViewController.h"

@interface ContentViewController : UIViewController

@property (nonatomic, strong) User *user;

- (void)showProfile;
- (void)showHome;
- (void)showMention;

@end
