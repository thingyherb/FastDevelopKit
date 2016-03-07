//
//  NSString+Extend.m
//  FastDevelopKit
//
//  Created by zhao on 3/7/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "NSString+Extend.h"
#import <UIKit/UIKit.h>
#import "DebugConfig.h"

@implementation NSString (Extend)

// 是否包含字符串string
- (BOOL)containsStringExtend:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    
    if (range.location != NSNotFound) {
        
        return YES;
        
    } else {
        
        return NO;
    }
}

// 计算string的size
- (CGSize)sizeWithFont:(UIFont *)font
                  size:(CGSize)maxSize
                 color:(UIColor *)color {
    
    CGSize size = CGSizeMake(0, 0);
    $try
    if (!font
        || !color
        || !self
        || self.length == 0
        || [self containsStringExtend:@"null"]) {
        
        return maxSize;
    }
    $catch
    
    $try
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_7_0
    size = [content sizeWithFont:font constrainedToSize:maxSize lineBreakMode:0];
#endif
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_0
    if (!color) {
        color = [UIColor clearColor];
    }
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *atdic = @{NSParagraphStyleAttributeName : paragraphStyle,
                            NSForegroundColorAttributeName : color,
                            NSFontAttributeName : font};
    
    size                = [self boundingRectWithSize:maxSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:atdic
                                             context:nil].size;
    
    
#endif
    
    $catch
    
    return size;
}

@end
