//
//  CDTabbarViewController.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDTabbarViewController.h"
#import "CDNaviViewController.h"
#import "CDMineVC.h"
#import "CDFindVC.h"
#import "CDConnectVC.h"
#import "CDMessageVC.h"

@interface CDTabbarViewController ()<UITabBarControllerDelegate>

@end

@implementation CDTabbarViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    ((CDNaviViewController *)self.navigationController.navigationController).disabledEdgePopGesture = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((CDNaviViewController *)self.navigationController.navigationController).disabledEdgePopGesture = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    self.delegate = self;
    NSArray *barItemTitles = @[ firstTabBarItemTitle,
                                secondTabBarItemTitle,
                                thirdTabBarItemTitle,
                                fourthTabBarItemTitle];
    
    NSArray *tabBarClasses = @[
                               [CDMessageVC class],
                               [CDConnectVC class],
                               [CDFindVC class],
                               [CDMineVC class]
                               ];
    NSArray *barItemNormalImages = @[ @"chat_default",
                                      @"contacts_default",
                                      @"find_default",
                                      @"mine_default"
                                      ];
    NSArray *barItemSelectImages = @[ @"chat_selected",
                                      @"contacts_selected",
                                      @"find_selected",
                                      @"mine_selected"
                                      ];
    __block NSMutableArray *navigations = @[].mutableCopy;
    
    [tabBarClasses enumerateObjectsUsingBlock:^(Class _Nonnull class, NSUInteger idx, BOOL * _Nonnull stop) {
        UITabBarItem *tabBarItem = [self createItemWithName:barItemTitles[idx]
                                                normalImage:barItemNormalImages[idx]
                                                selectImage:barItemSelectImages[idx]];
        
        UIViewController *vc = [[class alloc] init];
        //        vc.title = barItemTitles[idx];
        vc.tabBarItem = tabBarItem;
        CDNaviViewController *nav = [[CDNaviViewController alloc] initWithRootViewController:vc];
        [navigations addObject:nav];
    }];
    
    self.viewControllers = navigations;
    
    self.selectedIndex = 0;
}

- (UITabBarItem *)createItemWithName:(NSString *)itemTitle
                         normalImage:(NSString *)normalImageName
                         selectImage:(NSString *)selectImageName {
    UIImage *normalImage = [kImgName(normalImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [kImgName(selectImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:itemTitle image:normalImage selectedImage:selectImage];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : Import_Text_Color }
                        forState:UIControlStateSelected];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : Normal_Text_Color,
                                    NSFontAttributeName : Font(12) }
                        forState:UIControlStateNormal];
    
    return item;
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

@end
