//
//  FDChoiceButton.m
//
//
//  Created by zmy on 7/8/14.
//  Copyright (c) 2014 zmy. All rights reserved.
//

#import "FDChoiceButton.h"
#import "FontConfig.h"
#import <Masonry.h>

@implementation FDChoiceButton

static NSMutableDictionary *normalImageDict;
static NSMutableDictionary *selectedImageDict;
static NSMutableArray      *selectedArray;
static NSMutableArray      *unSelectedArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.tLabel.textAlignment = NSTextAlignmentCenter;
        self.tLabel.font = Font_16;
        [self addSubview:self.tLabel];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title
      titleColor:(UIColor *)titleColor
        forState:(UIControlState)state {
    
    if (state == UIControlStateNormal) {
        
        self.nTitle = title;
        self.nTitleColor = titleColor;
        
        self.tLabel.text = self.nTitle;
        self.tLabel.textColor = self.nTitleColor;
        
    } else {
        
        self.sTitle = title;
        self.sTitleColor = titleColor;
    }
    
    [self.tLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
}

- (void)setBorderWidth:(CGFloat)borderWidth
           borderColor:(UIColor *)borderColor
              forState:(UIControlState)state {
    
    self.layer.masksToBounds = true;
    
    if (state == UIControlStateNormal) {
        
        self.nBorderWidth = borderWidth;
        self.nBorderColor = borderColor;
        
        self.layer.borderWidth = self.nBorderWidth;
        self.layer.borderColor = self.nBorderColor.CGColor;

    } else {
        
        self.sBorderWidth = borderWidth;
        self.sBorderColor = borderColor;
    }
}

+ (instancetype)buttonWithFrame:(CGRect)frame
                  andChoiceType:(FDChoiceType)choiceType
                      withIndex:(NSUInteger)index
                        inGroup:(NSString *)groupId
              withSelectedImage:(UIImage *)selectedImage
                 andNormalImage:(UIImage *)normalImage {
    
    if (!normalImageDict) {
        normalImageDict    = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    if (!selectedImageDict) {
        selectedImageDict  = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    if (!selectedArray) {
        selectedArray      = [[NSMutableArray alloc] initWithCapacity:0];
    }
    if (!unSelectedArray) {
        unSelectedArray    = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    FDChoiceButton *button = [[FDChoiceButton alloc] initWithFrame:frame];
    button.choiceType      = choiceType;
    button.index           = index;
    button.groupId         = groupId;
    button.statusType      = FDChoiceButtonStatusTypeUnselected;
    
    NSString *imageKey = [NSString stringWithFormat:@"%@_%lu",groupId,(unsigned long)index];
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
        [normalImageDict   setObject:normalImage forKey:imageKey];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateHighlighted];
        [selectedImageDict setObject:selectedImage forKey:imageKey];
    }
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    if (button.statusType == FDChoiceButtonStatusTypeUnselected) {
        [unSelectedArray addObject:button];
    }else {
        [selectedArray addObject:button];
    }
    
    return button;
}

#pragma mark - buttonAction

+ (void)buttonAction:(FDChoiceButton *)FDChoiceButton {
    
    if (FDChoiceButton.statusType == FDChoiceButtonStatusTypeSelected) {
        //如果是选中状态，不执行任何操作
        return;
    }
    FDChoiceButton.statusType = FDChoiceButtonStatusTypeSelected;
}

#pragma mark - setMethod

- (void)setStatusType:(FDChoiceButtonStatusType)statusType {
    
    if (self.groupId) {
        NSString *imageKey = [NSString stringWithFormat:@"%@_%lu",self.groupId,(unsigned long)self.index];
        if (statusType == FDChoiceButtonStatusTypeSelected) {
            
            if (selectedImageDict[imageKey]) {
                
                [self setImage:selectedImageDict[imageKey] forState:UIControlStateNormal];
            }
            
            if (self.sBorderWidth && self.sBorderColor) {
                
                self.layer.borderWidth = self.sBorderWidth;
                self.layer.borderColor = self.sBorderColor.CGColor;
                
            } else {
                
                if (self.nBorderWidth && self.nBorderColor) {
                    
                    self.layer.borderWidth = self.nBorderWidth;
                    self.layer.borderColor = self.nBorderColor.CGColor;
                }
            }
            
            
        } else {
            
            if (normalImageDict[imageKey]) {
                
                [self setImage:normalImageDict[imageKey] forState:UIControlStateNormal];
            }
            
            if (self.nBorderWidth && self.nBorderColor) {
                
                self.layer.borderWidth = self.nBorderWidth;
                self.layer.borderColor = self.nBorderColor.CGColor;
            }
        }
    }
    _statusType = statusType;

    if (_statusType == FDChoiceButtonStatusTypeSelected) {

        for (int i = 0; i < selectedArray.count; i ++) {
            FDChoiceButton *button = selectedArray[i];
            if ([button.groupId isEqual:self.groupId]) {
                
                button.statusType = FDChoiceButtonStatusTypeUnselected;
                button.selected   = NO;
            }
        }
        
        self.selected   = YES;
        [unSelectedArray removeObject:self];
        [selectedArray addObject:self];

        if ([self.delegate respondsToSelector:
             @selector(FDChoiceButtonSelectedAtIndex:inGroup:)]) {
            
            [self.delegate FDChoiceButtonSelectedAtIndex:self.index inGroup:self.groupId];
        }
        
    } else if (_statusType == FDChoiceButtonStatusTypeUnselected){
        
        self.selected   = NO;
        [unSelectedArray addObject:self];
        [selectedArray removeObject:self];
    }
    
    if (statusType == FDChoiceButtonStatusTypeSelected) {
        
        self.tLabel.text = self.sTitle;
        self.tLabel.textColor = self.sTitleColor;
        
    } else {
        
        self.tLabel.text = self.nTitle;
        self.tLabel.textColor = self.nTitleColor;
        
    }
}

+ (void)removedChoiceButtonFromMemoryInGroup:(NSString *)groupId {
    
    for (int i = 0; i < selectedArray.count; i ++) {
        FDChoiceButton *button = selectedArray[i];
        if ([button.groupId isEqual:groupId]) {
            
            [selectedArray removeObject:button];
        }
    }
    
    for (int i = 0; i < unSelectedArray.count; i ++) {
        FDChoiceButton *button = unSelectedArray[i];
        if ([button.groupId isEqual:groupId]) {
            
            [unSelectedArray removeObject:button];
        }
    }
    
}

- (void)dealloc {
    //NSLog(@"FDChoiceButton dealloc");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
