//
//  UIViewController+CDNavigationExtension.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDNaviViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CDNavigationExtension)
@property (nonatomic, assign) BOOL jt_fullScreenPopGestureEnabled;

@property (nonatomic, weak) CDNaviViewController *jt_navigationController;
@end

NS_ASSUME_NONNULL_END
