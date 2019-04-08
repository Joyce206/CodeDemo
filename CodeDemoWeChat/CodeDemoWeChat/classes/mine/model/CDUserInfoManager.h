//
//  CDUserInfoManager.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDUserInfoManager : NSObject

@property (nonatomic, strong) CDUserInfoModel *userInfo;
@property (nonatomic, assign) BOOL isLogin;//是否登录状态

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
