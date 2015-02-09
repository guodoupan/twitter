//
//  TweetCell.h
//  Twitter
//
//  Created by Doupan Guo on 2/8/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetCell;

@protocol TweetCellDelegate <NSObject>

- (void)tweetCellDidReply: (TweetCell *)cell;
- (void)tweetCell: (TweetCell *)cell didFavorite:(BOOL)favorited;
- (void)tweetCell: (TweetCell *)cell didRetweet:(BOOL)retweeted;

@end

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet *tweet;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;

- (void)setFavorite:(BOOL)selected;
- (void)setRetweet:(BOOL)selected;

@end
