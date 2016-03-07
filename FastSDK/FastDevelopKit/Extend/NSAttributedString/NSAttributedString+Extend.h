//
//  NSAttributedString+Extend.h
//  FastDevelopKit
//
//  Created by zhao on 3/7/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIColor;
@class UIFont;

@interface NSAttributedString (Extend)


#pragma mark - 高亮文字
+ (NSMutableAttributedString *)highlightedKeyword:(NSArray *)keywordArray
                                        inContent:(NSString *)content
                                            color:(UIColor *)color
                                             font:(UIFont *)font;

@end




