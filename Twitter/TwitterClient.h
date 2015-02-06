//
//  TwitterClient.h
//  Twitter
//
//  Created by Doupan Guo on 2/5/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"
@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *)shareInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;
- (void)openUrl:(NSURL *)url;

- (void)homeLineWithParams: (NSDictionary *)params completion:(void (^)(NSArray *tweets, NSError *error))completion;
@end
