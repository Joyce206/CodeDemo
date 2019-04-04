//
//  NSString+AllCategories.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (AllCategories)

/**
 *  Documents文件夹地址
 */
+ (NSString *)documentFolder;

/**
 *  Caches文件夹地址
 */
+ (NSString *)cacheFolder;

/**
 *  验证字符串是否有效  NSNull/@""/nil
 */
- (BOOL)isValidString;

/**
 *  判断是否为空格
 */
- (BOOL)isBlankString;

/**
 *  验证手机号是否正确
 */
- (BOOL)isValidatePhoneNumber;

/**
 *  验证是否包含非法字符(除数字和字母外的其他字符)
 */
- (BOOL)isValidateStringIsExistForbiddenCharacter;

/**
 *  用户身份证验证
 */
- (BOOL)isValidateIDCardNumber;

/**
 *  是否是中文
 */
- (BOOL)isChinese;

/**
 计算文字宽高
 */
- (CGRect)boundingRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;

/**
 *  MD5加密
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 */
- (NSString *)SHA1;

/**
 *  SHA256加密
 */
- (NSString *)SHA256;

/**
 *  将姓名第二位用星号替代
 */
- (NSString *)nameToAsterisk;

/**
 *  将手机号第4-7个数字用星号替代
 */
- (NSString *)phoneNumToAsterisk;

/**
 *  将身份证中间数字用星号替代
 */
- (NSString *)CreditCardToAsterisk;

/**
 url拼接时间戳
 */
- (NSString *)addTimeStamp;

@end
