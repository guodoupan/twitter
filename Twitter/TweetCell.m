//
//  TweetCell.m
//  Twitter
//
//  Created by Doupan Guo on 2/8/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

@interface TweetCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweenButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation TweetCell

- (void)awakeFromNib {
    // Initialization code
    self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width;
    self.iconImage.layer.cornerRadius = 3;
    self.iconImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentLabel layoutIfNeeded];
     self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.frame.size.width;
}

- (void)setTweet:(Tweet *)tweet {
    if (tweet != nil) {
        self.nameLabel.text = tweet.user.name;
        self.displayNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
        self.createdAtLabel.text = [Tweet dateDiff:tweet.createdAt];
        self.contentLabel.text = tweet.text;
        [self.iconImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
        self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
        self.retweetLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
        
        [self.favoriteButton setSelected:tweet.favorited == 1];
        [self.retweenButton setSelected:tweet.retweeted == 1];
    }
}

@end
