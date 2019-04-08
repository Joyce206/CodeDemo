//
//  CDUserInfoManager.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDUserInfoManager.h"

@implementation CDUserInfoManager


+ (instancetype)sharedInstance {
    static CDUserInfoManager *userInfoManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfoManager = [[CDUserInfoManager alloc] init];
    });
    return userInfoManager;
}

- (void)setIsLogin:(BOOL)isLogin {
    if (!isLogin) {
        self.userInfo = nil;
    }
    
    [UserDefaults setBool:isLogin forKey:@"isLogin"];
    [UserDefaults synchronize];
}

- (BOOL)isLogin {
    return [UserDefaults boolForKey:@"isLogin"];
}
@end
