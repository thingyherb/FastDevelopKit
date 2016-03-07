//
//  NSAttributedString+Extend.m
//  FastDevelopKit
//
//  Created by zhao on 3/7/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "NSAttributedString+Extend.h"
#import <UIKit/UIKit.h>

@implementation NSAttributedString (Extend)


#pragma mark - 高亮文字
+ (NSMutableAttributedString *)highlightedKeyword:(NSArray *)keywordArray
                                        inContent:(NSString *)content
                                            color:(UIColor *)color
                                             font:(UIFont *)font {
    
    // 设置高亮文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:content];
    for (NSString *keyword in keywordArray) {
        
        NSRange range = [content rangeOfString:keyword];
        [attrituteString setAttributes:@{NSForegroundColorAttributeName : color,   NSFontAttributeName : font} range:range];
    }
    
    return attrituteString;
}


@end




