//
//  TweetsViewController.h
//  Twitter
//
//  Created by Doupan Guo on 2/6/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetCell.h"

@interface TweetsViewController : UIViewController

@property (nonatomic, strong) TweetCell *protoTypeCell;
@property (nonatomic, strong) User *user;
@end
