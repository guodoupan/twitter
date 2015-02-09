//
//  Twitter.m
//  Twitter
//
//  Created by Doupan Guo on 2/6/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.nsid = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        
        NSString *createdString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [formatter dateFromString:createdString];
        self.favoriteCount = [dictionary[@"favorite_count"] integerValue];
        self.retweetCount = [dictionary[@"retweet_count"] integerValue];
        self.favorited = [dictionary[@"favorited"] integerValue];
        self.retweeted = [dictionary[@"retweeted"] integerValue];
    }
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary: dictionary] ];
    }
    return tweets;
}

+ (NSString *)dateDiff:(NSDate *)origDate {
    NSDate *todayDate = [NSDate date];
    double ti = [origDate timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        return @"0s";
    } else 	if (ti < 60) {
        return [NSString stringWithFormat:@"%ds", (int)ti];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%dm", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%dh", diff];
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%dd", diff];
    } else {
        return @"never";
    }	
}

@end
