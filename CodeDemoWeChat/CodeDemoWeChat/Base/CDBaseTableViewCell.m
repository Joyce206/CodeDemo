//
//  CDBaseTableViewCell.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDBaseTableViewCell.h"

@implementation CDBaseTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
}


//自定义cell重写该方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.exclusiveTouch = YES;
        self.exclusiveTouch = YES;
        
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithSolidColor:Hlight_Text_Color size:self.contentView.frame.size]];
    }
    return self;
}

@end
