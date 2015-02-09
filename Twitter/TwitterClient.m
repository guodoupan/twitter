//
//  TwitterClient.m
//  Twitter
//
//  Created by Doupan Guo on 2/5/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"Z5dYd6OkVCLICJrXRCdXWVXui";
NSString * const kTwitterConsumerSecret = @"t7oFXgdObZUyttwy1LrEFd9NhX6sLAc5Vyoqo6rVOwv5suOkCZ";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()
@property (nonatomic, strong) void(^loginCompletion)(User *user, NSError *error);
@end

@implementation TwitterClient

+ (TwitterClient *)shareInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
   
    return instance;
}

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"guodoupan://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"got request token");
        
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
    }failure:^(NSError *error) {
        NSLog(@"get request token failed");
        self.loginCompletion(nil, error);
    }];
}

- (void)openUrl:(NSURL *)url {
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuth1Credential credentialWithQueryString:url.query] success:^(BDBOAuth1Credential *accessToken){
        NSLog(@"got access token:%@", accessToken);
        [[TwitterClient shareInstance].requestSerializer saveAccessToken:accessToken];
        
        [[TwitterClient shareInstance] GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            self.loginCompletion(user, nil);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"verify user error %@", error);
            self.loginCompletion(nil, error);
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"get access token error:%@", error);
        self.loginCompletion(nil, error);
    }];

}

- (void)homeLineWithParams: (NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion {
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        NSLog(@"respnse:%@", responseObject);
        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
}

- (void)updateStatus: (NSString *)status completion:(void (^)(Tweet *tweet, NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:status forKey:@"status"];
    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet =[[Tweet alloc] initWithDictionary:responseObject];
        NSLog(@"respnse:%@", tweet);
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"update status error:%@", error);
        completion(nil, error);
    }];
}

- (void)toggleFavorites: (NSString *)tweetId isFavorited:(BOOL)favorited completion:(void (^)(Tweet *tweet, NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:tweetId forKey:@"id"];
    NSString *url = favorited ? @"1.1/favorites/destroy.json" : @"1.1/favorites/create.json";
    [self POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet =[[Tweet alloc] initWithDictionary:responseObject];
        NSLog(@"respnse:%@", tweet);
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"update status error:%@", error);
        completion(nil, error);
    }];
}

- (void)retweet: (NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *url = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tweetId];
    [self POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Tweet *tweet =[[Tweet alloc] initWithDictionary:responseObject];
        NSLog(@"respnse:%@", tweet);
        completion(tweet, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"update status error:%@", error);
        completion(nil, error);
    }];
}

@end
