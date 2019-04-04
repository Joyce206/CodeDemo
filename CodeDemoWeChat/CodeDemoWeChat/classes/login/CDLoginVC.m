//
//  CDLoginVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDLoginVC.h"
#import "CDTabbarViewController.h"

@interface CDLoginVC ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITextField *phoneTextF;
@property (nonatomic, strong) UITextField *pwdTextF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) CDBaseTableView *tableView;
@end

@implementation CDLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";

}
#pragma mark - UI
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    self.title = @"登录";
    
    [self refreshUI];
    [self refreshUIConstraints];
}
- (void)refreshUI {
    [self phoneTextF];
    [self pwdTextF];
    [self loginBtn];
    
    [self tableView];
    [self.view addSubview:self.tableView];
}
- (void)refreshUIConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.bottom.mas_equalTo(self.view);
        }
    }];
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.layer.cornerRadius = 4.f;
        _loginBtn.clipsToBounds = YES;
        [_loginBtn setBackgroundColor:APP_Main_Color];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:Nav_Title_Color forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(btnLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}
- ( CDBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CDBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Main_BG_Color;
        _tableView.bounces = NO;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
#pragma mark  UI
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        //密码登录
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    return 200;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil){
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
    for (UIView *subview in subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            [subview removeFromSuperview];
        }
        if ([subview isKindOfClass:[UIImageView class]]) {
            [subview removeFromSuperview];
        }
    }
    UIImageView *imageview = [[UIImageView alloc] init];
    [imageview setImage:[UIImage imageNamed:@"logo"]];
    
    UITextField *textFlied = [[UITextField alloc] init];
    textFlied.borderStyle = UITextBorderStyleNone;
    textFlied.tintColor = Normal_Text_Color; //输入框光标
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = App_Line_Color;
    
    if (indexPath.section ==  0) {
        //输入框
        [cell.contentView addSubview:textFlied];
        [cell.contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16.5);
            make.centerX.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(.5);
            make.bottom.mas_equalTo(-.5);
        }];
        [textFlied mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16.5);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(-135);
            make.bottom.mas_equalTo(-4);
        }];
        if (indexPath.row == 0) {
            textFlied.placeholder = @"请输入账号";
            self.phoneTextF = textFlied;
            self.phoneTextF.delegate = self;
            self.phoneTextF.keyboardType = UIKeyboardTypeDecimalPad;

            return cell;
        }
        if (indexPath.row == 1) {
            textFlied.placeholder = @"请输入密码";
            self.pwdTextF = textFlied;
            self.pwdTextF.delegate = self;
            self.pwdTextF.secureTextEntry = YES;
            return cell;
        }
    }
    if (indexPath.section == 1) {
        //登录
        [cell.contentView addSubview:self.loginBtn];
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.contentView);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(15.5);
            make.bottom.mas_equalTo(-10);
        }];
        return cell;
    }
    return nil;
}
#pragma mark  UITableViewDelegate, UITableViewDataSource

#pragma mark  - action
- (void)btnLoginClick:(UIButton *)sender {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.window.rootViewController = [[CDNaviViewController alloc] initWithRootViewController:[[CDTabbarViewController alloc] init]];
}
@end
