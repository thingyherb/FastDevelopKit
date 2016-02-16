//
//  UIImage+URL.h
//  CoalForDriver
//
//  Created by zhao on 9/13/15.
//  Copyright (c) 2015 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)


#pragma mark - 生成纯色图片

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


#pragma mark - 图片裁剪、压缩

+ (UIImage *)cutImage:(UIImage *)image frame:(CGRect)rect;

+ (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size; // 改变图片大小

+ (UIImage *)compressedToLessThan200K:(UIImage *)image; // 不改变图片大小

+ (UIImage *)compress:(UIImage *)image toByte:(NSUInteger)byte; // 不改变图片大小


@end
