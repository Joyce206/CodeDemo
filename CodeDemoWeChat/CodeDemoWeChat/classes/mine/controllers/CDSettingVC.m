
//
//  CDSettingVC.m
//  CodeDemoWeChat
//
//  Created by Joyce on 4/8/19.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDSettingVC.h"

@interface CDSettingVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CDBaseTableView *tableView;
@property (nonatomic, strong) CDUserInfoModel *userInfo;

@end

@implementation CDSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"登录";
    
    self.userInfo = [CDUserInfoModel getUserInfo] ;
    
    [self refreshUI];
    [self refreshUIConstraints];
    [self.tableView reloadData];
}
- (void)refreshUI {
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
- ( CDBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[CDBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Table_footer_Color;
        _tableView.bounces = NO;
        //        _tableView.allowsSelection = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
#pragma mark  UI
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    if (section == 2) {
        return 2;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.f)];
    footerView.backgroundColor = Table_footer_Color;
    return footerView;
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
    
    UILabel *tileLab = [[UILabel alloc] init];
    
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.image = [UIImage imageNamed:@"more_default"];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = App_Line_Color;
    
    [cell.contentView addSubview:tileLab];
    [cell.contentView addSubview:rightImg];
    [cell.contentView addSubview:lineView];
    lineView.hidden = YES;
    
    [tileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(15);
    }];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(-15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.bottom.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(15);
    }];
    NSArray *titleArray = @[@[@"账号与安全"] , @[@"新消息通知",@"隐私",@"通用"] ,@[@"帮助与反馈",@"关于微信"], @[@"插件"], @[@"切换账号"], @[@"退出登录"]];
    NSString *titleStr = [NSString stringWithFormat:@"%@",titleArray[indexPath.section][indexPath.row]];

    tileLab.text =  titleStr;
    if (indexPath.section == 1 && indexPath.row < 2) {
        lineView.hidden = NO;
    }
    if (indexPath.section == 2 && indexPath.row < 1) {
        lineView.hidden = NO;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        CDSettingVC *controller = [[CDSettingVC alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark  UITableViewDelegate, UITableViewDataSource

#pragma mark  - action
- (void)btnLoginClick:(UIButton *)sender {
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    app.window.rootViewController = [[CDNaviViewController alloc] initWithRootViewController:[[CDTabbarViewController alloc] init]];
}
@end
