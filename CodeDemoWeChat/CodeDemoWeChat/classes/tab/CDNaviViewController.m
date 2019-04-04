//
//  CDNaviViewController.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDNaviViewController.h"
#import "UIViewController+CDNavigationExtension.h"

#define kDefaultBackImageName @"backImage"

#pragma mark - JTWrapNavigationController

@interface JTWrapNavigationController : UINavigationController

@end

@implementation JTWrapNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //解决部分页面侧滑返回不受控制问题
    self.interactivePopGestureRecognizer.delegate = nil;
    self.interactivePopGestureRecognizer.enabled = NO;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    CDNaviViewController *jt_navigationController = viewController.jt_navigationController;
    NSInteger index = [jt_navigationController.jt_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:jt_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.jt_navigationController = (CDNaviViewController *)self.navigationController;
    viewController.jt_fullScreenPopGestureEnabled = viewController.jt_navigationController.fullScreenPopGestureEnabled;
    
    
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:[JTWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.jt_navigationController = nil;
}

@end

#pragma mark - JTWrapViewController

static NSValue *jt_tabBarRectValue;

@implementation JTWrapViewController

+ (JTWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    JTWrapNavigationController *wrapNavController = [[JTWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    JTWrapViewController *wrapViewController = [[JTWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    } else if (self.tabBarController && !jt_tabBarRectValue) {
        jt_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    } else if (self.tabBarController && jt_tabBarRectValue) {
        //if判断中去除 !self.tabBarController.tabBar.hidden 该条件,
        //防止首页扫登机牌后切换到地空联运，底部tabbar消失
        self.tabBarController.tabBar.frame = jt_tabBarRectValue.CGRectValue;
    }
    //    self.tabBarController.tabBar.translucent = YES;
    //    if (self.tabBarController && !self.tabBarController.tabBar.hidden && jt_tabBarRectValue) {
    //        self.tabBarController.tabBar.frame = jt_tabBarRectValue.CGRectValue;
    //    }
}

- (BOOL)jt_fullScreenPopGestureEnabled {
    //    return YES;
    return [self rootViewController].jt_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    JTWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end
@interface CDNaviViewController () <UINavigationControllerDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;
@end

@implementation CDNaviViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.jt_navigationController = self;
        self.viewControllers = @[[JTWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    
    //全屏滑动返回
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithSolidColor:Nav_BG_Color size:CGSizeMake(ScreenWidth, NavHeight)] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setShadowImage:[UIImage imageWithSolidColor:App_Line_Color size:CGSizeMake(ScreenWidth, 1)]];
    
    [UINavigationBar appearance].tintColor = Nav_Title_Color;
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName: Nav_Title_Color,
                                                         NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
                                                         };
}

//- (BOOL)prefersStatusBarHidden {
//    return NO;
//}
//
- (UIStatusBarStyle)preferredStatusBarStyle {
    //    return self.isShowBlackStatus ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.jt_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
    
    if (self.disabledEdgePopGesture) {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)jt_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (JTWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}
#pragma mark - getter and setter
- (void)setIsShowBlackStatus:(BOOL)isShowBlackStatus {
    _isShowBlackStatus = isShowBlackStatus;
    
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
