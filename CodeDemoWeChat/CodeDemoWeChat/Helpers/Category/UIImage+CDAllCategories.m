//
//  UIImage+CDAllCategories.m
//  CodeDemoWeChat
//
//  Created by wangJS on 2019/4/4.
//  Copyright © 2019 Joyce. All rights reserved.
//

#import "UIImage+CDAllCategories.h"

@implementation UIImage (CDAllCategories)

+ (UIImage *)imageWithSolidColor:(UIColor *)color size:(CGSize)size {
    NSParameterAssert(color);
    NSAssert(!CGSizeEqualToSize(size, CGSizeZero), @"Size cannot be CGSizeZero");
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    // Create a context depending on given size
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    // Fill it with your color
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [self resizedImageWithName:imageName left:0.5 * image.size.width top:0.5 * image.size.height];
}

+ (UIImage *)resizedImageWithName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}

+ (UIImage *)resizedImageUseInsetWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat resizableFloat = 2;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(resizableFloat, resizableFloat, resizableFloat, resizableFloat)
                                 resizingMode:UIImageResizingModeStretch];
}

+ (UIImage *)imageByDashedView:(CGSize)drawSize
                     lineWidth:(CGFloat)lineWidth
                     lineColor:(UIColor *)lineColor {
    UIGraphicsBeginImageContextWithOptions(drawSize, NO, 0);
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = { lineWidth, lineWidth };
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, lineColor.CGColor);
    CGContextSetLineDash(line, 0, lengths, 2);
    CGContextMoveToPoint(line, 0.0, 0);
    CGContextAddLineToPoint(line, drawSize.width, 0);
    CGContextStrokePath(line);
    
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return drawImage;
}

@end
