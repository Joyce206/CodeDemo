//
//  CDBaseViewController.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDBaseViewController : UIViewController

@property (nonatomic, strong, readonly) UIWindow *keyWindow;


/**
 *  判断是否登录，若未登录弹出去登录，成功后回调actionEvent;若已登录则直接执行actionEvent
 *
 *  @param actionEvent 登录后的回调
 */
- (void)loginAfterAction:(void (^)(void))actionEvent;

- (UIBarButtonItem *)showBackButtonWithAction:(void (^)(void))buttonAction;

/**
 显示左上角返回按钮
 
 @param imageName 返回按钮图片名称
 @param buttonAction 返回按钮点击事件，默认为返回前一页
 */
- (UIBarButtonItem *)showBackButtonWithImage:(NSString *)imageName action:(void (^)(void))buttonAction;

/**
 *  通过图片显示左上角按钮
 *
 *  @param image        图片
 *  @param buttonAction 按钮点击触发事件
 */
- (UIBarButtonItem *)showLeftButtonWithImage:(UIImage *)image action:(void (^)(void))buttonAction;

/**
 *  通过图片显示右上角按钮
 *
 *  @param image        图片
 *  @param buttonAction 按钮点击触发事件
 */
- (UIBarButtonItem *)showRightButtonWithImage:(UIImage *)image action:(void (^)(void))buttonAction;

/*
 通过文字显示左上角按钮
 
 @param title 按钮title
 @param titleColor 按钮title颜色
 @param font 按钮title字体大小
 @param buttonAction 按钮点击事件
 */
- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title font:(UIFont *)font action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font action:(void (^)(void))buttonAction;

/*
 通过文字显示右上角按钮
 
 @param title 按钮title
 @param titleColor 按钮title颜色
 @param font 按钮title字体大小
 @param buttonAction 按钮点击事件
 */
- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title font:(UIFont *)font action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(void (^)(void))buttonAction;
- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font action:(void (^)(void))buttonAction;

@end

