//
//  CDAlertView.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDAlertView : NSObject

/**
 *  alertView
 *
 *  @param vc              显示该alertView的VC
 *  @param title           alertView的title
 *  @param message         alertView的message
 *  @param buttonTitles    alertView的buttonTitles数组，从做到右显示
 *  @param completionBlock 点击按钮的回调
 */
+ (void)alertViewShowInViewController:(UIViewController *)vc
                                title:(NSString *)title
                              message:(NSString *)message
                         buttonTitles:(NSArray *)buttonTitles
                      completionBlock:(void (^)(NSInteger buttonIndex))completionBlock;
@end

