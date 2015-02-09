//
//  ComposeViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/8/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "ComposeViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

- (void)onNewTweet;
- (void)onCancel;
@end

@implementation ComposeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
       
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
        leftButton.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItem = leftButton;
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
        rightButton.tintColor = [UIColor blueColor];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.user = [User currentUser];
    [self.imageView setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    self.nameLabel.text = self.user.name;
    self.screenNameLabel.text = self.user.screenName;
    if (self.replyName != nil) {
        self.textField.text = [NSString stringWithFormat:@"@%@ ", self.replyName];
    }
    [self.textField becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onCancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onNewTweet {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.replyId != nil) {
        [params setObject:self.replyId forKey:@"in_reply_to_status_id"];
    }
    [[TwitterClient shareInstance] updateStatus:self.textField.text withParams:params completion:^(Tweet *tweet, NSError *error) {
        if (error == nil) {
            NSLog(@"update:%@", tweet.text);
            [self.delegate composeViewController:self didNewTweet:tweet];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            NSLog(@"new tweet error:%@", error);
        }
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
