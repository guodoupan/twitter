//
//  TwitterClient.m
//  Twitter
//
//  Created by Doupan Guo on 2/5/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"Z5dYd6OkVCLICJrXRCdXWVXui";
NSString * const kTwitterConsumerSecret = @"t7oFXgdObZUyttwy1LrEFd9NhX6sLAc5Vyoqo6rVOwv5suOkCZ";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

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
@end
