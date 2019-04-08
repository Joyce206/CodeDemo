//
//  CDResetNameVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDResetNameVC.h"

@interface CDResetNameVC ()
@property (nonatomic, strong) CDUserInfoModel *userInfo;
@property (nonatomic, strong) UITextField *nameTFD;
@property (nonatomic, strong) NSString *nameString;
@end

@implementation CDResetNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    self.view.backgroundColor = App_Line_Color;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    __weak __typeof(self) weakSelf= self;
    [self showLeftButtonWithTitle:@"取消" titleColor:Text_Sub_Color action:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self showRightButtonWithTitle:@"完成" titleColor:RGB(175,238,238) action:nil];
    
    self.title = @"设置名字";
    self.userInfo = [CDUserInfoModel getUserInfo] ;
    self.nameString = self.userInfo.user_nickname;
    
    [self refreshUI];
    [self refreshUIConstraints];
    self.nameTFD.text = self.nameString;
    
    CGRect frame = self.nameTFD.frame;
    frame.size.width = 10;
    // 距离左侧的距离
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.nameTFD.leftViewMode = UITextFieldViewModeAlways;
    self.nameTFD.leftView = leftview;
}
- (void)refreshUI {
    [self nameTFD];
    [self.view addSubview:self.nameTFD];
}
- (void)refreshUIConstraints {
    [self.nameTFD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
}
- (UITextField *)nameTFD {
    if (!_nameTFD) {
        _nameTFD = [[UITextField alloc] init];
        _nameTFD.borderStyle = UITextBorderStyleNone;
        _nameTFD.backgroundColor = UIColor.whiteColor;
        _nameTFD.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _nameTFD;
}
@end
