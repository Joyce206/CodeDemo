//
//  CDBaseViewController.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDBaseViewController.h"

static NSInteger offset = 10;
@interface CDBaseViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong, readwrite) UIWindow *keyWindow;

@end

@implementation CDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = Nav_BG_Color;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self setUpNavUI];
    [self setupUI];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)setUpNavUI {
    //子类重写该方法，导航栏样式UI
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSolidColor:Nav_BG_Color size:CGSizeMake(ScreenWidth, NavHeight)]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithSolidColor:Nav_BG_Color size:CGSizeMake(ScreenWidth, 1)]];
    
    self.navigationController.navigationBar.tintColor = Nav_Title_Color;
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: Nav_Title_Color,
                                                                    NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
                                                                    };
}
- (void)setupUI {
    //子类重写该方法，布局UI
}
- (void)loginAfterAction:(void (^)(void))actionEvent {
    //子类重写该方法，退出登录处理
}
- (UIBarButtonItem *)showBackButtonWithAction:(void (^)(void))buttonAction {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:kImgName(@"nav_back") forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    leftBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)showBackButtonWithImage:(NSString *)imageName action:(void (^)(void))buttonAction {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBtn setImage:kImgName(imageName) forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    leftBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        } else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)showLeftButtonWithImage:(UIImage *)image action:(void (^)(void))buttonAction {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, - offset, 0, offset);
    [leftBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    leftBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)showRightButtonWithImage:(UIImage *)image action:(void (^)(void))buttonAction {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 44, 44);
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(0, offset, 0, - offset);
    [rightBtn setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    
    rightBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title action:(void (^)(void))buttonAction {
    return [self showLeftButtonWithTitle:title titleColor:nil font:nil action:buttonAction];
}

- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title font:(UIFont *)font action:(void (^)(void))buttonAction {
    return [self showLeftButtonWithTitle:title titleColor:nil font:font action:buttonAction];
}

- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(void (^)(void))buttonAction {
    return [self showLeftButtonWithTitle:title titleColor:titleColor font:nil action:buttonAction];
}

- (UIBarButtonItem *)showLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font action:(void (^)(void))buttonAction {
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) attributes:@{ NSFontAttributeName : font ?: Font(14) }];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftBtn.frame = CGRectMake(0, 0, titleRect.size.width > 44 ? titleRect.size.width : 44, 44);
    leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - offset, 0, offset);
    [leftBtn setTitle:title forState:UIControlStateNormal];
    leftBtn.titleLabel.font = font ?: Font(14);
    [leftBtn setTitleColor:titleColor ?: [UIColor whiteColor] forState:UIControlStateNormal];
    
    leftBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    return item;
}

- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title action:(void (^)(void))buttonAction {
    return [self showRightButtonWithTitle:title titleColor:nil font:nil action:buttonAction];
}

- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title font:(UIFont *)font action:(void (^)(void))buttonAction {
    return [self showRightButtonWithTitle:title titleColor:nil font:font action:buttonAction];
}

- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(void (^)(void))buttonAction {
    return [self showRightButtonWithTitle:title titleColor:titleColor font:nil action:buttonAction];
}

- (UIBarButtonItem *)showRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font action:(void (^)(void))buttonAction {
    CGRect titleRect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) attributes:@{ NSFontAttributeName : font ?: Font(14) }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, titleRect.size.width > 44 ? titleRect.size.width : 44, 44);
    //    rightBtn.titleEdgeInsets = UIEdgeInsetsMake(0, offset, 0, - offset);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn setTitleColor:titleColor ?: [UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = font ?: Font(14);
    rightBtn.titleLabel.backgroundColor = [UIColor clearColor];
    
    rightBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        if (buttonAction) {
            buttonAction();
        }
        return [RACSignal empty];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = item;
    return item;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UIGestureRecognizerDelegate
//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

- (void)dealloc {
    NSLog(@"%@ -- dealloc", self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - getter
- (UIWindow *)keyWindow {
    if (!_keyWindow) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    return _keyWindow;
}

@end
