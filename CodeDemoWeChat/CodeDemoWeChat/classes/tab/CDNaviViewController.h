//
//  CDNaviViewController.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JTWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface CDNaviViewController : UINavigationController
/**
 *  是否需要将状态条颜色变为黑色
 */
@property (nonatomic, assign) BOOL isShowBlackStatus;

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *jt_viewControllers;

@property (nonatomic, assign) BOOL disabledEdgePopGesture;
@end

NS_ASSUME_NONNULL_END
