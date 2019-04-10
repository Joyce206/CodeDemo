

//
//  CDVideoPlayVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/10.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDVideoPlayVC.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
@interface CDVideoPlayVC ()
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UIView *playView; //播放区域
@property (nonatomic,strong) NSURL *url; //流媒体播放地址
@property (nonatomic, retain) id<IJKMediaPlayback> ijkPlayer;//播放器
@end

@implementation CDVideoPlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setupUI {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showBackButtonWithAction:nil];
    
    self.title = @"播放";
    
    [self refreshUI];
    [self refreshUIConstraints];
    NSString *urlString = @"";
    self.url = [NSURL URLWithString:urlString];
    //调整参数
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:30  forKey:@"max-fps"];
    [options setPlayerOptionIntValue:30 forKey:@"r"];
    //跳帧开关
    [options setPlayerOptionIntValue:1  forKey:@"framedrop"];
    [options setPlayerOptionIntValue:0  forKey:@"start-on-prepared"];
    [options setPlayerOptionIntValue:0  forKey:@"http-detect-range-support"];
    [options setPlayerOptionIntValue:48  forKey:@"skip_loop_filter"];
    [options setPlayerOptionIntValue:0  forKey:@"packet-buffering"];
    [options setPlayerOptionIntValue:2000000 forKey:@"analyzeduration"];
    [options setPlayerOptionIntValue:25  forKey:@"min-frames"];
    [options setPlayerOptionIntValue:1  forKey:@"start-on-prepared"];
    [options setCodecOptionIntValue:8 forKey:@"skip_frame"];
    [options setFormatOptionValue:@"nobuffer" forKey:@"fflags"];
    [options setFormatOptionValue:@"8192" forKey:@"probsize"];
    //自动转屏开关
    [options setFormatOptionIntValue:0 forKey:@"auto_convert"];
    //重连次数
    [options setFormatOptionIntValue:1 forKey:@"reconnect"];
    //开启硬解码
    [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
    
    
    self.ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:options];
    self.ijkPlayer.view.frame = CGRectMake(0, 0, ScreenWidth, 260);
    [self.playView addSubview:self.ijkPlayer.view];
    
    [self.ijkPlayer setScalingMode:IJKMPMovieScalingModeAspectFit];
    [self installMovieNotificationObservers];
    if(![self.ijkPlayer isPlaying]){
        [self.ijkPlayer prepareToPlay];
    }
    
}
- (void)refreshUI {
    [self playView];
    [self.view addSubview:self.playView];
    [self playBtn];
    [self.view addSubview:self.playBtn];
}
- (void)refreshUIConstraints {
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(260);
    }];
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(self.playView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(80, 50));
    }];
}
- (UIView *)playView {
    if (!_playView) {
        _playView = [[UIView alloc] init];
        _playView.backgroundColor = UIColor.blackColor;
    }
    return _playView;
}
- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.layer.cornerRadius = 4.f;
        _playBtn.clipsToBounds = YES;
        [_playBtn setBackgroundColor:APP_Main_Color];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitle:@"暂停" forState:UIControlStateSelected];
        [_playBtn setTitleColor:Nav_Title_Color forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (void)playBtnClick:(UIButton *)sender {
    self.playBtn.selected = !self.playBtn.selected;
    if (self.playBtn.selected == YES) {
        //开始播放
        [self.ijkPlayer play];
    }else {
        //暂停播放
        [self.ijkPlayer pause];
    }
    
}
#pragma mark Install Movie Notifications//network load state changes
- (void)loadStateDidChange:(NSNotification *)notification{
    IJKMPMovieLoadState loadState = self.ijkPlayer.loadState;
    NSLog(@"LoadStateDidChange : %d",(int)loadState);
}

//when movie playback ends or a user exits playback.
- (void)moviePlayBackFinish:(NSNotification *)notification{
    int reason = [[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    NSLog(@"playBackFinish : %d",reason);
}

//
- (void)mediaIsPreparedToPlayDidChange:(NSNotification *)notification{
    NSLog(@"mediaIsPrepareToPlayDidChange");
}

// when the playback state changes, either programatically or by the user
- (void)moviePlayBackStateDidChange:(NSNotification *)notification{
    switch (_ijkPlayer.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"playBackState %d: stoped", (int)self.ijkPlayer.playbackState);
            break;
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"playBackState %d: playing", (int)self.ijkPlayer.playbackState);
            break;
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"playBackState %d: paused", (int)self.ijkPlayer.playbackState);
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"playBackState %d: interrupted", (int)self.ijkPlayer.playbackState);
            break;
        case IJKMPMoviePlaybackStateSeekingForward:
            break;
        case IJKMPMoviePlaybackStateSeekingBackward:
            break;
        default:
            break;
    }
}


- (void)installMovieNotificationObservers{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:self.ijkPlayer];
}

- (void)removeMovieNotificationObservers{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:self.ijkPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:self.ijkPlayer];
}
@end
