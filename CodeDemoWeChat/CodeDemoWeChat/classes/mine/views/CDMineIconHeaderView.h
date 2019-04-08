//
//  CDMineIconHeaderView.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDMineIconHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) CDUserInfoModel *userInfo;
//点击view的block 0拍摄动态视频 1个人信息
@property (nonatomic, copy) void (^clickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
