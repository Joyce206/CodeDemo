//
//  CDUserInfoMoreVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDUserInfoMoreVC.h"
#import "CDResetSexVC.h"
#import "CDResetAddressVC.h"
#import "CDRestAutographVC.h"


@interface CDUserInfoMoreVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CDBaseTableView *tableView;
@property (nonatomic, strong) CDUserInfoModel *userInfo;

@end

@implementation CDUserInfoMoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showBackButtonWithAction:nil];
    self.userInfo = [CDUserInfoModel getUserInfo] ;

    [self refreshUI];
    [self refreshUIConstraints];
    [self.tableView reloadData];
}
- (void)refreshUI {
    [self tableView];
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
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
        _tableView = [[CDBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = Table_footer_Color;
        _tableView.bounces = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
#pragma mark  UI
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section  {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.f)];
    headerView.backgroundColor = Table_footer_Color;
    return headerView;
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
    UILabel *rightLab = [[UILabel alloc] init];
    rightLab.textColor = Text_Sub_Color;
    rightLab.font = Font(16);
    
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.image = [UIImage imageNamed:@"more_default"];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = App_Line_Color;
    
    UIImageView *contentImg = [[UIImageView alloc] init];
    contentImg.hidden = YES;
    
    [cell.contentView addSubview:tileLab];
    [cell.contentView addSubview:rightImg];
    [cell.contentView addSubview:rightLab];
    [cell.contentView addSubview:lineView];
    
    lineView.hidden = YES;
    
    [tileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(30);
    }];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(-15);
    }];
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(rightImg.mas_left).offset(-10);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.bottom.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(30);
    }];
    
    NSArray *titleArray = @[@"性别" ,@"地区",@"个性签名"];
    NSString *titleStr = [NSString stringWithFormat:@"%@",titleArray[indexPath.row]];
    tileLab.text =  titleStr;
    
    NSArray *rightTitle = @[self.userInfo.user_sex,self.userInfo.user_address,self.userInfo.user_autograph];
    NSString *rightStr = [NSString stringWithFormat:@"%@",rightTitle[indexPath.row]];
    rightLab.text =  rightStr;
    
    if (indexPath.section == 0 && indexPath.row < 2) {
        lineView.hidden = NO;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CDResetSexVC *controller = [[CDResetSexVC alloc] init];
            [self presentViewController:controller animated:YES completion:nil];
        }
        if (indexPath.row == 2) {
            CDRestAutographVC *controller = [[CDRestAutographVC alloc] init];
            [self presentViewController:controller animated:YES completion:nil];
        }
        if (indexPath.row == 1) {
            CDResetAddressVC *controller = [[CDResetAddressVC alloc] init];
            CDNaviViewController *nav = [[CDNaviViewController alloc] initWithRootViewController:controller];

//            [self.navigationController pushViewController:controller animated:YES];
            [self presentViewController:nav animated:YES completion:nil];

        }

    }
}
#pragma mark  UITableViewDelegate, UITableViewDataSource

#pragma mark  - action
- (void)btnLoginClick:(UIButton *)sender {
    //    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //    app.window.rootViewController = [[CDNaviViewController alloc] initWithRootViewController:[[CDTabbarViewController alloc] init]];
}

@end
