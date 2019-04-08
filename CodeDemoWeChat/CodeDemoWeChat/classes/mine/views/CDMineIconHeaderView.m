//
//  CDMineIconHeaderView.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDMineIconHeaderView.h"


@interface CDMineIconHeaderView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UIButton *photoBtn;

@property (nonatomic, strong) UIImageView *headerImg;
@property (nonatomic, strong) UILabel *namelab;
@property (nonatomic, strong) UILabel *idLab;
@property (nonatomic, strong) UIImageView *qrImg;
@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIView *botttomLine;

@property (nonatomic, strong) UIButton *userInfoBtn;

@end
@implementation CDMineIconHeaderView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self topView];
        [self addSubview:self.topView];
        
        [self centerView];
        [self addSubview:self.centerView];
        
        [self photoBtn];
        [self addSubview:self.photoBtn];
        
        [self headerImg];
        [self.centerView addSubview:self.headerImg];
        
        [self namelab];
        [self.centerView addSubview:self.namelab];
        
        [self idLab];
        [self.centerView addSubview:self.idLab];
        [self qrImg];
        [self.centerView addSubview:self.qrImg];
        [self rightImg];
        [self.centerView addSubview:self.rightImg];
        
        [self userInfoBtn];
        [self.centerView addSubview:self.userInfoBtn];

        [self botttomLine];
        [self addSubview:self.botttomLine];
    }
    return self;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = UIColor.whiteColor;
    }
    return _topView;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = UIColor.whiteColor;
    }
    return _centerView;
}
- (UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.layer.cornerRadius = 8;
        _headerImg.clipsToBounds = YES;
        //        _headerImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headerImg;
}
- (UILabel *)namelab {
    if (!_namelab) {
        _namelab = [[UILabel alloc] init];
        _namelab.font = Font(20);
        _namelab.textColor = UIColor.blackColor;
    }
    return _namelab;
}
- (UILabel *)idLab {
    if (!_idLab) {
        _idLab = [[UILabel alloc] init];
        _idLab.font = Font(16);
        _idLab.textColor = Import_Text_Color;
    }
    return _idLab;
}
- (UIImageView *)qrImg {
    if (!_qrImg) {
        _qrImg = [[UIImageView alloc] init];
        _qrImg.image = [UIImage imageNamed:@"mine_qrimg"];
    }
    return _qrImg;
}
- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"more_default"];
    }
    return _rightImg;
}
- (UIButton *)photoBtn {
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoBtn setImage:[UIImage imageNamed:@"mine_photo"] forState:UIControlStateNormal];
        _photoBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;//按钮居右显示
        [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _photoBtn;
}
- (UIButton *)userInfoBtn {
    if (!_userInfoBtn) {
        _userInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_userInfoBtn addTarget:self action:@selector(userInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userInfoBtn;
}

- (UIView *)botttomLine {
    if (!_botttomLine) {
        _botttomLine = [[UIView alloc] init];
        _botttomLine.backgroundColor = Table_footer_Color;
    }
    return _botttomLine;
}
- (void)userInfoBtnClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}
- (void)photoBtnClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}


#pragma mark - 用户信息
- (void)setUserInfo:(CDUserInfoModel *)userInfo {
    _userInfo = userInfo;
    [self.photoBtn setImage:[UIImage imageNamed:@"mine_photo"] forState:UIControlStateNormal];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user_phone] placeholderImage:[UIImage imageNamed:@"user_icon"]];
    self.namelab.text = self.userInfo.user_nickname;
    self.idLab.text = [NSString stringWithFormat:@"微信号：%@",self.userInfo.user_id];
    self.qrImg.image = [UIImage imageNamed:@"mine_qrimg"];
    self.rightImg.image = [UIImage imageNamed:@"more_default"];
    [self refreshUIConstraints];
    [self needsUpdateConstraints];
}

- (void)refreshUIConstraints {
    [self.botttomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(MarginTop);
    }];
    [self.photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.top.mas_equalTo(MarginTop);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.photoBtn.mas_bottom);
        make.bottom.mas_equalTo(self.botttomLine.mas_top);
    }];

    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(self.centerView);
        make.right.mas_equalTo(-15);
    }];
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(CGSizeMake(80, 80));
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.rightImg.mas_bottom ).offset(20);
    }];
    [self.idLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightImg);
        make.left.mas_equalTo(self.headerImg.mas_right).offset(10);
    }];
    [self.qrImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.rightImg);
        make.right.mas_equalTo(self.rightImg.mas_left).offset(-10);
        make.width.height.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.centerView);
        make.top.mas_equalTo(self.headerImg.mas_top);
    }];
    [self.namelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerImg.mas_top);
        make.left.mas_equalTo(self.headerImg.mas_right).offset(10);
        make.right.mas_equalTo(-15);
    }];
}
@end
