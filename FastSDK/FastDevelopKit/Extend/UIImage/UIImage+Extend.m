//
//  UIImage+URL.m
//  CoalForDriver
//
//  Created by zhao on 9/13/15.
//  Copyright (c) 2015 zhao. All rights reserved.
//

#import "UIImage+Extend.h"
#import "DebugConfig.h"
#import "NSString+Extend.h"

@implementation UIImage (Extend)


#pragma mark - 生成纯色图片

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - 图片裁剪、压缩

+ (UIImage *)cutImage:(UIImage *)image frame:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    
    $try
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, image.size.width, image.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [image drawInRect:drawRect];
    $catch
    
    // grab image
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return croppedImage;
    
}

+ (UIImage *)scaleImage:(UIImage *)image ToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat height = CGImageGetHeight(image.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1) {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }else {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

// 等比压缩
+ (UIImage *)compressImage:(UIImage *)image size:(CGSize)size
{
    size = CGSizeMake(size.width/2, size.height/2);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

// 压缩到指定大小
+ (UIImage *)compressedToLessThan200K:(UIImage *)image {
    
    return [self compress:image toByte:200 * 1024];
}

+ (UIImage *)compress:(UIImage *)image toByte:(NSUInteger)byte {
    
    NSData *data      = UIImageJPEGRepresentation(image, 1.0);
    UIImage *newImage = nil;
    
    if (data.length > byte) {
        
        double scale = (double)byte/data.length;
        
        data = UIImageJPEGRepresentation(image, scale);
        
        newImage = [UIImage imageWithData:data];
        
        if (data.length > byte) {
            
            newImage = [self compressImage:newImage size:newImage.size];
            
            data = UIImageJPEGRepresentation(image, scale);
            
            if (data.length > byte) {
                
                [self compress:newImage toByte:byte];
            }
        }
        
    } else {
        
        newImage = image;
    }
    
    return newImage;
}

#pragma mark - 图片处理

// 往图片上添加文字 会改变等比放大原有图片的大小 高清
+ (UIImage *)addTextChange:(NSString *)text
                  withFont:(UIFont *)font
                  fontSize:(int)fontSize
                     color:(UIColor *)color
                     point:(CGPoint)point
                   toImage:(UIImage *)image
{
    if (!text
        ||!font
        || !color
        || !text
        || text.length == 0
        || [text containsStringExtend:@"null"]) {
        
        return image;
    }
    
    $try
    int scale = 4;
    CGSize size             = CGSizeMake(image.size.width*scale, image.size.height*scale);// 设置上下文（画布）大小
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale); // 创建一个基于位图的上下文(context)，并将其设置为当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();// 获取当前上下文
    CGContextSetAllowsAntialiasing(contextRef, YES);// 开启抗锯齿
    CGContextTranslateCTM(contextRef, 0, size.height); // 画布的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0); // 画布翻转
    CGContextDrawImage(contextRef, CGRectMake(0, 0, size.width, size.height), image.CGImage); // 在上下文种画当前图片
    if (!color) {
        color = [UIColor clearColor];
    }
    [color set]; // 上下文种的文字颜色
    CGContextTranslateCTM(contextRef, 0, size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    UIFont *font_new = [UIFont fontWithName:font.fontName size:fontSize*scale];
    
    NSDictionary *atdic = @{NSForegroundColorAttributeName : color,
                            NSFontAttributeName : font_new};
    
    [text drawAtPoint:CGPointMake(point.x*scale, point.y*scale) withAttributes:atdic];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext(); // 从当前上下文种获取图片
    UIGraphicsEndImageContext(); // 移除栈顶的基于当前位图的图形上下文。
    
    return resultImage;
    $catch
    
    return nil;
}

// 往图片上添加文字 不会改变原有图片的大小
+ (UIImage *)addText:(NSString *)text
            withFont:(UIFont *)font
            fontSize:(int)fontSize
               color:(UIColor *)color
               point:(CGPoint)point
             toImage:(UIImage *)image
{
    if (!text
        ||!font
        || !color
        || text.length == 0
        || [text containsStringExtend:@"null"]) {
        
        return image;
    }
    
    $try
    CGSize size             = CGSizeMake(image.size.width, image.size.height);// 设置上下文（画布）大小
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale); // 创建一个基于位图的上下文(context)，并将其设置为当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();// 获取当前上下文
    CGContextTranslateCTM(contextRef, 0, size.height); // 画布的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0); // 画布翻转
    CGContextDrawImage(contextRef, CGRectMake(0, 0, size.width, size.height), image.CGImage); // 在上下文种画当前图片
    if (!color) {
        color = [UIColor clearColor];
    }
    [color set]; // 上下文种的文字颜色
    CGContextTranslateCTM(contextRef, 0, size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    UIFont *font_new = [UIFont fontWithName:font.fontName size:fontSize];
    
    NSDictionary *atdic = @{NSForegroundColorAttributeName : color,
                            NSFontAttributeName : font_new};
    
    [text drawAtPoint:CGPointMake(point.x, point.y) withAttributes:atdic];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext(); // 从当前上下文种获取图片
    UIGraphicsEndImageContext(); // 移除栈顶的基于当前位图的图形上下文。
    
    return resultImage;
    $catch
    
    return nil;
}

// 将view转为图片
+ (UIImage *)imageCreateFromView:(UIView *)view
{
    $try
    CGSize s = view.bounds.size;
    // 第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    $catch
    
    return nil;
}



@end




