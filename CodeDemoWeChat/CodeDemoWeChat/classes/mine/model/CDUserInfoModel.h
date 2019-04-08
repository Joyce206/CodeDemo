//
//  CDUserInfoModel.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDUserInfoModel : NSObject

@property (nonatomic, copy) NSString *_Nullable user_id;
@property (nonatomic, copy) NSString *_Nullable user_barth; //生日
@property (nonatomic, copy) NSString *_Nullable user_mail; //邮箱
@property (nonatomic, copy) NSString *_Nullable user_phone;
@property (nonatomic, copy) NSString *_Nullable user_nickname;
@property (nonatomic, copy) NSString *_Nullable user_autograph; //签名
@property (nonatomic, copy) NSString *_Nullable user_pic;//头像
@property (nonatomic, copy) NSString *_Nullable user_sex;//性别
@property (nonatomic, copy) NSString *_Nullable user_address;//性别


+ (instancetype)sharedInstance;

/**
 *  解档用户信息
 */
//+(instancetype)decodeUserInfo;

/**
 *  保存用户信息
 */
-(void)saveUserInfo;


/**
 *  清空用户信息
 */
-(void)clearUserInfo;

@end

NS_ASSUME_NONNULL_END
