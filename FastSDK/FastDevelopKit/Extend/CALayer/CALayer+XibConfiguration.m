//
//  CALayer+XibConfiguration.m
//  FastDevelopKit
//
//  Created by zhao on 2/17/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)


- (UIColor*)borderUIColor {
    
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setBorderUIColor:(UIColor *)borderUIColor {
    
    self.borderColor = borderUIColor.CGColor;
}

@end



