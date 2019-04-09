//
//  CDAlertSheetView.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDAlertSheetView : NSObject
/**
 *  alertView
 *
 *  @param vc              显示该alertView的VC
 *  @param title           alertView的title
 *  @param message         alertView的message
 *  @param buttonTitles    alertView的buttonTitles数组，从做到右显示
 *  @param completionBlock 点击按钮的回调
 */
+ (void)alertSheetViewShowInViewController:(UIViewController *)vc
                                title:(NSString *)title
                              message:(NSString *)message
                         buttonTitles:(NSArray *)buttonTitles
                      completionBlock:(void (^)(NSInteger buttonIndex))completionBlock;
@end

NS_ASSUME_NONNULL_END
