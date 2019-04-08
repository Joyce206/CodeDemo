//
//  CDResetHeaderVC.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDResetHeaderVC.h"

@interface CDResetHeaderVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) CDUserInfoModel *userInfo;
@property (nonatomic, strong) UIImageView *iconImgView;
//图片
@property (nonatomic, strong) UIImagePickerController *pickerController;
@property (nonatomic, strong) UIImage *image;
@end

@implementation CDResetHeaderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - UI
- (void)setUpNavUI {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithSolidColor:UIColor.blackColor size:CGSizeMake(ScreenWidth, NavHeight)]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithSolidColor:UIColor.blackColor size:CGSizeMake(ScreenWidth, 1)]];
    
    self.navigationController.navigationBar.tintColor = UIColor.whiteColor;
    self.navigationController.navigationBar.titleTextAttributes = @{
                                                                    NSForegroundColorAttributeName: UIColor.whiteColor,
                                                                    NSFontAttributeName: [UIFont boldSystemFontOfSize:18]
                                                                    };
}
- (void)setupUI {
    self.view.backgroundColor = UIColor.blackColor;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self showLeftButtonWithImage:[UIImage imageNamed:@"nav_back_white"] action:nil];
    __weak __typeof(self) weakSelf= self;
    [self showRightButtonWithImage:[UIImage imageNamed:@"more_right"] action:^{
        [weakSelf loadActionsheetsView];
    }];
    [self showBackButtonWithAction:nil];
    self.title = @"个人头像";
    self.image = nil;
    self.userInfo = [CDUserInfoModel getUserInfo] ;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user_phone] placeholderImage:[UIImage imageNamed:@"user_icon"]];

    [self refreshUI];
    [self refreshUIConstraints];
}
- (void)refreshUI {
    [self iconImgView];
    [self.view addSubview:self.iconImgView];
}
- (void)refreshUIConstraints {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth - 40);
        make.height.mas_equalTo(ScreenWidth - 40);
    }];
}
- (UIImageView *)iconImgView {
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
        _iconImgView.backgroundColor = UIColor.blackColor;
    }
    return _iconImgView;
}
- (UIImagePickerController *)pickerController {
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc] init];
        // 导航栏改为白色
        _pickerController.navigationBar.barTintColor = UIColor.whiteColor;
        // 其它文字/icon颜色改为黑色
        _pickerController.navigationBar.tintColor = UIColor.blackColor;
        [_pickerController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}];
    }
    return _pickerController;
}
- (void)loadActionsheetsView {
    __weak typeof(self) weakSelf = self;
    [CDAlertSheetView alertSheetViewShowInViewController:self title:NULL message:nil buttonTitles:@[@"拍照" , @"从手机相册选择" , @"取消"] completionBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 0 || buttonIndex == 1) {
            if (@available(iOS 11, *)) {
                UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
            }
            UIImagePickerControllerSourceType sourceType = buttonIndex == 0 ? UIImagePickerControllerSourceTypeCamera :UIImagePickerControllerSourceTypePhotoLibrary;
            if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
            weakSelf.pickerController.sourceType = sourceType;
            weakSelf.pickerController.delegate = self;
            weakSelf.pickerController.allowsEditing = YES;
            [weakSelf presentViewController:self.pickerController animated:YES completion:nil];
        }
    }];
    
}
#pragma mark - UIImagePickerControllerDelegate,UINavigationControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        UIImage *editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        if (@available(iOS 11, *)) {
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever; //iOS11 解决SafeArea的问题，同时能解决pop时上级页面scrollView抖动的问题
        }
        CGFloat fixelW = editedImage.size.width;
        CGFloat fixelH = editedImage.size.height;
        
        NSLog(@"像素大小:%.0f %.0f",fixelW ,fixelH);
        UIImage *scaleImage = editedImage;
        if (fixelW >= ScreenWidth || fixelH >= ScreenWidth) {
            if (fixelW >= fixelH) {
                //长大于等于宽
                float scaleSize = ScreenWidth / fixelW;
                
                UIGraphicsBeginImageContext(CGSizeMake(editedImage.size.width * scaleSize, editedImage.size.height * scaleSize));
                [editedImage drawInRect:CGRectMake(0, 0, editedImage.size.width * scaleSize, editedImage.size.height * scaleSize)];
                scaleImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                //            NSLog(@"像素大小:%.0f %.0f",fixelW ,fixelH);
            } if (fixelW < fixelH)  {
                //长小于宽
                float scaleSize =ScreenWidth / fixelH;
                
                UIGraphicsBeginImageContext(CGSizeMake(editedImage.size.width * scaleSize, editedImage.size.height * scaleSize));
                [editedImage drawInRect:CGRectMake(0, 0, editedImage.size.width * scaleSize, editedImage.size.height * scaleSize)];
                scaleImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                //            NSLog(@"像素大小:%.0f %.0f",fixelW ,fixelH);
            }
        }
        __weak typeof(self) weakSelf = self;
        [picker dismissViewControllerAnimated:YES completion:^{
            [self.iconImgView setImage:editedImage];
        }];
    }
}
@end
