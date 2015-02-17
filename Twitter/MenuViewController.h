//
//  MenuViewController.h
//  Twitter
//
//  Created by Doupan Guo on 2/16/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuViewController;

@protocol MenuViewDelegate <NSObject>

- (void)onProfile;
- (void)onHome;
- (void)onMention;
@end

@interface MenuViewController : UIViewController

@property (nonatomic, weak) id<MenuViewDelegate> delegate;

@end
