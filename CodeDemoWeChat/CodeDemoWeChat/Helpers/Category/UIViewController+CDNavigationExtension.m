//
//  UIViewController+CDNavigationExtension.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "UIViewController+CDNavigationExtension.h"
#import <objc/runtime.h>
@implementation UIViewController (CDNavigationExtension)

- (BOOL)jt_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setJt_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(jt_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (CDNaviViewController *)jt_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setJt_navigationController:(CDNaviViewController *)navigationController {
    objc_setAssociatedObject(self, @selector(jt_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}
@end
