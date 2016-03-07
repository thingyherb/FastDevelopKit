//
//  NSString+Extend.h
//  FastDevelopKit
//
//  Created by zhao on 3/7/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIFont;
@class UIColor;
typedef struct CGSize CGSize;

@interface NSString (Extend)

// 是否包含字符串string
- (BOOL)containsStringExtend:(NSString *)string;


// 计算string的size
- (CGSize)sizeWithFont:(UIFont *)font
                  size:(CGSize)maxSize
                 color:(UIColor *)color;


@end


