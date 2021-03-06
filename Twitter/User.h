//
//  User.h
//  Twitter
//
//  Created by Doupan Guo on 2/6/15.
//  Copyright (c) 2015 Doupan Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const UserDidLoginNotificaton;
extern NSString * const UserDidLogoutNotificaton;

@interface User : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImageUrl;
@property (nonatomic, strong) NSString *tagline;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+  (User *)currentUser;
+ (void)setCurrentUser:(User *)user;
+ (void)logout;
@end
