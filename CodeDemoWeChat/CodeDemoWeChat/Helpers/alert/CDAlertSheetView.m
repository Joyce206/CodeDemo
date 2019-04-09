//
//  CDAlertSheetView.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/8.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "CDAlertSheetView.h"
#import <ReactiveCocoa.h>
@interface CDAlertView ()
@end

@implementation CDAlertSheetView

+ (void)alertSheetViewShowInViewController:(UIViewController *)vc
                                title:(NSString *)title
                              message:(NSString *)message
                         buttonTitles:(NSArray *)buttonTitles
                      completionBlock:(void (^)(NSInteger buttonIndex))completionBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        UIAlertAction* action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            if (completionBlock) {
                completionBlock(i);
            }
        }];
        [alertController addAction:action];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertController animated:YES completion:nil];
    });
}
@end
