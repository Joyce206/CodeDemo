
//
//  CDUserInfoModel.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDUserInfoModel.h"
#import <objc/runtime.h>

@interface CDUserInfoModel ()<NSCopying>

@end
@implementation CDUserInfoModel

static id _instance;


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self getUserInfo];
    });
    return _instance;
}
- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}



#pragma mark -- NSCopying -------------


//归档
- (void)encodeWithCoder:(NSCoder *)coder
{
    //属性的个数
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([CDUserInfoModel class], &count);
    for (int i = 0; i < count; i++) {
        //取出对应的Ivar
        Ivar ivar = ivars[i];
        //拿到名称
        const char * name = ivar_getName(ivar);
        //OC 字符串
        NSString * key = [NSString stringWithUTF8String:name];
        //归档
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
}


//解档
- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        //属性的个数
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([CDUserInfoModel class], &count);
        for (int i = 0; i < count; i++) {
            //取出对应的Ivar
            Ivar ivar = ivars[i];
            //拿到名称
            const char * name = ivar_getName(ivar);
            //OC 字符串
            NSString * key = [NSString stringWithUTF8String:name];
            //解档
            id value = [coder decodeObjectForKey:key];
            //KVC--设置值到属性上面!!!
            [self setValue:value forKey:key];
        }
    }
    return self;
}


/**
 *  保存用户信息
 */
-(void)saveUserInfo
{
    //沙盒
    NSString * temp = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:@"userInfo.wfz"];
    
    //归档
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
}


+(instancetype)getUserInfo
{
    //沙盒
    NSString * temp = NSTemporaryDirectory();
    NSString * filePath = [temp stringByAppendingPathComponent:@"userInfo.wfz"];
    //解档
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath]?[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]:[[CDUserInfoModel alloc]init];
}

/**
 *  清空用户信息
 */
-(void)clearUserInfo
{
    //属性的个数
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([CDUserInfoModel class], &count);
    for (int i = 0; i < count; i++) {
        //取出对应的Ivar
        Ivar ivar = ivars[i];
        //拿到名称
        const char * name = ivar_getName(ivar);
        //OC 字符串
        NSString * key = [NSString stringWithUTF8String:name];
        
        //清空置零
        [self setValue:nil forKey:key];
        //存档
        [self saveUserInfo];
    }
}

@end
