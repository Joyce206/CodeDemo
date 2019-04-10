//
//  CDFindVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDFindVC.h"
#import "CDVideoPlayVC.h"
@interface CDFindVC ()
@property (nonatomic, strong) UIButton *playBtn;
@end

@implementation CDFindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.title = @"发现";
    
    [self refreshUI];
    [self refreshUIConstraints];
}
- (void)refreshUI {
    
    [self playBtn];
    [self.view addSubview:self.playBtn];
}
- (void)refreshUIConstraints {
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.layer.cornerRadius = 4.f;
        _playBtn.clipsToBounds = YES;
        [_playBtn setBackgroundColor:APP_Main_Color];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitleColor:Nav_Title_Color forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (void)playBtnClick:(UIButton *)sender {
    CDVideoPlayVC *controller = [[CDVideoPlayVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
