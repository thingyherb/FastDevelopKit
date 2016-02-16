//
//  UIImage+URL.m
//  CoalForDriver
//
//  Created by zhao on 9/13/15.
//  Copyright (c) 2015 zhao. All rights reserved.
//

#import "UIImage+Extend.h"
#import "DebugConfig.h"

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
    
    $Try
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, image.size.width, image.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [image drawInRect:drawRect];
    $Catch
    
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
        
        data = UIImageJPEGRepresentation(newImage, 0.5);

        newImage = [UIImage imageWithData:data];
        
        if (data.length > byte) {
            
            newImage = [self compress:newImage toByte:byte];
        }
        
    } else {
        
        newImage = image;
    }
    
    return newImage;
}


@end




