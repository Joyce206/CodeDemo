//
//  CDMineVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDMineVC.h"
#import "CDMineIconHeaderView.h"
#import "CDUserInfoVC.h"

@interface CDMineVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CDBaseTableView *tableView;
@property (nonatomic, strong) CDUserInfoModel *userInfo;

@end

@implementation CDMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
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
        [_tableView registerClass:NSClassFromString(@"CDMineIconHeaderView") forHeaderFooterViewReuseIdentifier:@"CDMineIconHeaderView"];
    }
    return _tableView;
}
#pragma mark  UI
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 4;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 150 + NavHeight;
    }
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        __weak __typeof(self) weakSelf= self;
        
        CDMineIconHeaderView *headerView = (CDMineIconHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CDMineIconHeaderView"];
        headerView.userInfo = self.userInfo;
        headerView.clickBlock = ^(NSInteger index) {
            [weakSelf.navigationController pushViewController:[[CDUserInfoVC alloc] init] animated:YES];
        };
        return headerView;
    }
    return nil;
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
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    UILabel *tileLab = [[UILabel alloc] init];
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.image = [UIImage imageNamed:@"more_default"];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = App_Line_Color;
    
    [cell.contentView addSubview:iconImg];
    [cell.contentView addSubview:tileLab];
    [cell.contentView addSubview:rightImg];
    [cell.contentView addSubview:lineView];
    lineView.hidden = YES;
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(15);
    }];
    [tileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(70);
    }];
    [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(cell.contentView);
        make.right.mas_equalTo(-15);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.bottom.mas_equalTo(cell.contentView);
        make.left.mas_equalTo(70);
    }];
    NSArray *leftImfArray = @[@[@"mine_pay"] , @[@"mine_collection",@"mine_album",@"mine_cards",@"mine_faces"] , @[@"mine_setting"]];
    NSArray *titleArray = @[@[@"支付"] , @[@"收藏",@"相册",@"卡包",@"表情"] , @[@"设置"]];
    
    NSString *imageName = [NSString stringWithFormat:@"%@",leftImfArray[indexPath.section][indexPath.row]];
    NSString *titleStr = [NSString stringWithFormat:@"%@",titleArray[indexPath.section][indexPath.row]];
    iconImg.image = [UIImage imageNamed:imageName];
    tileLab.text =  titleStr;
    if (indexPath.section == 1 && indexPath.row < 3) {
        lineView.hidden = NO;
    }
    return cell;
}
#pragma mark  UITableViewDelegate, UITableViewDataSource

#pragma mark  - action
- (void)btnLoginClick:(UIButton *)sender {
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = [[CDNaviViewController alloc] initWithRootViewController:[[CDTabbarViewController alloc] init]];
}
@end
