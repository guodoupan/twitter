//
//  TwitterClient.h
//  Twitter
//
//  Created by Doupan Guo on 2/5/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
#import "Tweet.h"
@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)shareInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;

- (void)homeLineWithParams: (NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;

- (void)updateStatus: (NSString *)status withParams: (NSDictionary *)params completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)toggleFavorites: (NSString *)tweetId isFavorited:(BOOL)favorited completion:(void (^)(Tweet *tweet, NSError *error))completion;

- (void)retweet: (NSString *)tweetId completion:(void (^)(Tweet *tweet, NSError *error))completion;
@end
