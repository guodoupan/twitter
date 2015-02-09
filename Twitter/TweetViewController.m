//
//  TweetViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/8/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;

- (void)onReply;
@end

@implementation TweetViewController
- (IBAction)onReply:(id)sender {
    NSLog(@"onReply");
}
- (IBAction)onRetweet:(id)sender {
    NSLog(@"onRetweet");
    if ([sender isSelected]) {
        NSLog(@"remove retweet");
    } else {
        NSString *nsid = self.tweet.nsid;
        [[TwitterClient shareInstance] retweet:nsid completion:^(Tweet *tweet, NSError *error) {
            if (error == nil) {
                [self.retweetButton setSelected:YES];
            } else {
                NSLog(@"retweet error %@", error);
            }
        }];
    }
}

- (IBAction)onFavorite:(id)sender {
    NSLog(@"onFavorite");
    
    [[TwitterClient shareInstance] toggleFavorites:self.tweet.nsid isFavorited:[sender isSelected] completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            [self.favoriteButton setSelected:!self.favoriteButton.isSelected];
        } else {
            NSLog(@"favorite failed:%@", error);
        }
    }];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Tweet";
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target:self action:@selector(onReply)];
        rightButton.tintColor = [UIColor blueColor];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageUrl]];
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.contentLabel.text = self.tweet.text;
    NSString *count = [NSString stringWithFormat:@"%d FAVORITES %d RETWEETS", self.tweet.favoriteCount, self.tweet.retweetCount];
    self.countLabel.text = count;
    [self.favoriteButton setSelected:self.tweet.favorited == 1];
    [self.retweetButton setSelected:self.tweet.retweeted == 1];
 
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onReply {
    
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
