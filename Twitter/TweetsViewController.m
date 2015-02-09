//
//  TweetsViewController.m
//  Twitter
//
//  Created by Doupan Guo on 2/6/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "TweetViewController.h"

@interface TweetsViewController () <UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (void)onLogout;
- (void)onNewTweet;
@end

@implementation TweetsViewController

- (TweetCell *)protoTypeCell {
    if (!_protoTypeCell) {
        _protoTypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    }
    return _protoTypeCell;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.title = @"Home";
        
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
        leftButton.tintColor = [UIColor blueColor];
        self.navigationItem.leftBarButtonItem = leftButton;
        
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
        rightButton.tintColor = [UIColor blueColor];
        self.navigationItem.rightBarButtonItem = rightButton;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.tableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [[TwitterClient shareInstance] homeLineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        if (error == nil) {
            self.dataArray = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"load home error:%@", error);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.protoTypeCell.tweet = self.dataArray[indexPath.row];
    [self.protoTypeCell layoutIfNeeded];
    
    CGSize size = [self.protoTypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.dataArray[indexPath.row];
    cell.tweet = tweet;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TweetViewController *vc = [[TweetViewController alloc] init];
    vc.tweet = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
- (void)onLogout {
    [User logout];
}

- (void)onNewTweet {
    NSLog(@"new tweet");
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    vc.user = self.user;
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)composeViewController:(ComposeViewController *)composeViewControlller didNewTweet:(Tweet *)tweet {
    NSMutableArray *array = [self.dataArray mutableCopy];
    [array insertObject:tweet atIndex:0];
    self.dataArray = array;
    [self.tableView reloadData];
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
