//
//  CDUserInfoVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDUserInfoVC.h"
#import "CDUserInfoMoreVC.h"
#import "CDResetHeaderVC.h"
#import "CDResetNameVC.h"
#import "CDResetQRCodeVC.h"
#import "CDMyAdressesVC.h"
#import "CDResetAddressesVC.h"

@interface CDUserInfoVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CDBaseTableView *tableView;
@property (nonatomic, strong) CDUserInfoModel *userInfo;

@end

@implementation CDUserInfoVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showBackButtonWithAction:nil];
    self.title = @"个人信息";

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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0){
        return 0.000001;
    }
    return 10;
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
    [cell.contentView addSubview:contentImg];
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
    
    NSArray *titleArray = @[@[@"头像" ,@"名字",@"微信号",@"我的二维码",@"更多"] , @[@"我的地址"]];
    NSString *titleStr = [NSString stringWithFormat:@"%@",titleArray[indexPath.section][indexPath.row]];
    tileLab.text =  titleStr;
    
    rightImg.image = [UIImage imageNamed:@"more_default"];
    
    NSArray *rightTitle = @[@[@"" ,self.userInfo.user_nickname,self.userInfo.user_id,@"",@""] , @[@""]];
    NSString *rightStr = [NSString stringWithFormat:@"%@",rightTitle[indexPath.section][indexPath.row]];
    rightLab.text =  rightStr;

    if (indexPath.section == 0 && indexPath.row < 4) {
        lineView.hidden = NO;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        contentImg.hidden = NO;
        contentImg.layer.cornerRadius = 10;
        contentImg.clipsToBounds = YES;
        [contentImg sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user_phone] placeholderImage:[UIImage imageNamed:@"user_icon"]];
        [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(80, 80));
            make.right.mas_equalTo(rightImg.mas_left).offset(-10);
            make.centerY.mas_equalTo(rightImg);
        }];
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row == 2) {
        rightImg.hidden = YES;
        [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(cell.contentView);
        }];
        return cell;
    }
    if (indexPath.section == 0 && indexPath.row == 3) {
        contentImg.hidden = NO;
        contentImg.image = [UIImage imageNamed:@"mine_qrimg"];
        [contentImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.right.mas_equalTo(rightImg.mas_left).offset(-10);
            make.centerY.mas_equalTo(rightImg);
        }];
        return cell;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CDResetHeaderVC *controller = [[CDResetHeaderVC alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 1) {
            CDResetNameVC *controller = [[CDResetNameVC alloc] init];
            CDNaviViewController *nav = [[CDNaviViewController alloc] initWithRootViewController:controller];
            [self presentViewController:nav animated:YES completion:nil];
            
//            CDResetNameVC *controller = [[CDResetNameVC alloc] init];
//            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 3) {
            CDResetQRCodeVC *controller = [[CDResetQRCodeVC alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if (indexPath.row == 4) {
            CDUserInfoMoreVC *controller = [[CDUserInfoMoreVC alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
    if (indexPath.section == 1) {
        CDMyAdressesVC *controller = [[CDMyAdressesVC alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
#pragma mark  UITableViewDelegate, UITableViewDataSource


@end
