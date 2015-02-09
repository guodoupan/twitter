//
//  Twitter.h
//  Twitter
//
//  Created by Doupan Guo on 2/6/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *nsid;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) User *user;
@property (nonatomic, assign) NSInteger favoriteCount;
@property (nonatomic, assign) NSInteger retweetCount;
@property (nonatomic, assign) NSInteger favorited;
@property (nonatomic, assign) NSInteger retweeted;
- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;
+ (NSString *)dateDiff:(NSDate *)origDate;
@end
