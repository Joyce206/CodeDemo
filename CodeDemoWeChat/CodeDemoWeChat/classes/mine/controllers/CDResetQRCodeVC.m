//
//  CDResetQRCodeVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDResetQRCodeVC.h"

@interface CDResetQRCodeVC ()
@property (nonatomic, strong) CDUserInfoModel *userInfo;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIImageView *codeImg;

@end

@implementation CDResetQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setUpNavUI {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSolidColor:App_Line_Color size:CGSizeMake(ScreenWidth, NavHeight)]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithSolidColor:App_Line_Color size:CGSizeMake(ScreenWidth, 1)]];
    
    self.navigationController.navigationBar.tintColor = Nav_Title_Color;
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: Nav_Title_Color,
                                                                    NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
                                                                    };
}
- (void)setupUI {
    self.view.backgroundColor = App_Line_Color;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    __weak __typeof(self) weakSelf= self;
    [self showLeftButtonWithImage:[UIImage imageNamed:@"nav_back"] action:nil];

//    [self showLeftButtonWithTitle:@"取消" titleColor:Text_Sub_Color action:^{
//        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//    }];
//
//    [self showRightButtonWithTitle:@"完成" titleColor:RGB(175,238,238) action:nil];
    
    self.title = @"我的二维码";
    self.userInfo = [CDUserInfoModel getUserInfo] ;

    
    [self refreshUI];
    [self refreshUIConstraints];
    
    self.codeImg.image = [UIImage imageNamed:@"mine_QQ_QR"];
}
- (void)refreshUI {
    [self centerView];
    [self.view addSubview:self.centerView];
    
    [self codeImg];
    [self.centerView addSubview:self.codeImg];
}
- (void)refreshUIConstraints {
    CGFloat viewWidth = ScreenWidth - 20*2;
    CGFloat viewHeight = viewWidth * 5/4;
    CGFloat imgHeight = (viewWidth - 30*2) * 7/5;
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(viewHeight);
    }];
    [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.centerView);
        make.left.mas_equalTo(30);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(imgHeight);
    }];
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = UIColor.whiteColor;
        _centerView.layer.cornerRadius = 20;
        _centerView.clipsToBounds = YES;
    }
    return _centerView;
}
- (UIImageView *)codeImg {
    if (!_codeImg) {
        _codeImg = [[UIImageView alloc] init];
    }
    return _codeImg;
}

@end
