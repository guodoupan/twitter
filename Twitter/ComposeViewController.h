//
//  ComposeViewController.h
//  Twitter
//
//  Created by Doupan Guo on 2/8/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Tweet.h"

@class ComposeViewController;

@protocol ComposeViewControllerDelegate <NSObject>

- (void)composeViewController:(ComposeViewController *) composeViewControlller didNewTweet:(Tweet *) tweet;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, strong) User *user;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@end
