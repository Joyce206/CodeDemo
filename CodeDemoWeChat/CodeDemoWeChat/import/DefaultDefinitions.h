//
//  DefaultDefinitions.h
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#ifndef DefaultDefinitions_h
#define DefaultDefinitions_h

//Image
#define kImgName(name) [UIImage imageNamed:name]

#define kResourcePath(name, type) ([[NSBundle mainBundle] pathForResource:name ofType:type])
#define kImgFromFile(name, type) [[UIImage alloc] initWithContentsOfFile:kResourcePath(name, type)]

//Frame
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height
#define ScreenScale         [UIScreen mainScreen].scale
#define ScreenRatio         ScreenWidth / 375.0
#define NavBarHeight        self.navigationController.navigationBar.bounds.size.height
#define StatusBarHeight     20
#define TabBarHeight        self.tabBarController.tabBar.bounds.size.height
#define ViewBounds          CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - StatusBarHeight - NavBarHeight - TabBarHeight)
#define MarginTop           (ScreenHeight == 812 ? 44 : 0)
#define MarginBottom        (ScreenHeight == 812 ? 34 : 0)
#define NavHeight           (ScreenHeight == 812 ? 88 : 64)
#define TabHeight           (ScreenHeight == 812 ? 83 : 49)
#define ChoiceSize(a, b)    (ScreenWidth == 320 ? a : b)

//Colorc
#define RGB(R, G, B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define RGBA(R, G, B, A)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define HEXColor(c)         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]

#define Nav_BG_Color        RGB(255, 255, 255)
#define App_BG_Color        RGB(175,238,238)
#define App_Line_Color      RGB(225, 225, 225)
#define App_View_BG_Color   RGB(245, 245, 245)
#define Import_Text_Color   RGB(65, 65, 65)
#define Normal_Text_Color   RGB(170, 170, 170)
#define Hlight_Text_Color   HEXColor(0xF0F0F0)
#define OnePixelLineWidth   1.0 / ScreenScale
#define kGreen_Color        RGB(82, 208, 110)

#define Nav_Title_Color     RGB(0, 0, 0)
#define APP_Main_Color      RGB(255,234,0)
#define Text_Sub_Color      RGB(136, 136, 136)
#define APP_Button_Color    RGB(255,180,0)
#define APP_BtnMain_Color    RGB(250, 225, 76)


//system Version
#define iOS(version)        [[[UIDevice currentDevice] systemVersion] floatValue] >= version

//App info
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppName             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

//others
#define Format(string, args...)     [NSString stringWithFormat:string, args]
#define UserDefaults                [NSUserDefaults standardUserDefaults]
#define Font(font)                  [UIFont systemFontOfSize:font]
#define BoldFont(font)              [UIFont boldSystemFontOfSize:font]



//dispatch
#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}
#endif

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000  // 当前Xcode支持iOS8及以上
#else
#endif

#endif /* DefaultDefinitions_h */
