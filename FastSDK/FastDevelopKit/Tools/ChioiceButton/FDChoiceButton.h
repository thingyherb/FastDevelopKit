//
//  FDChoiceButton.h
//  shanhuweidian
//
//  Created by zmy on 7/8/14.
//  Copyright (c) 2014 zmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    FDChoiceButtonStatusTypeUnselected = 0,
    FDChoiceButtonStatusTypeSelected   = 1,
    
}FDChoiceButtonStatusType;

typedef enum {
    
    FDChoiceTypeRadio = 0,
    FDChoiceTypeCheck = 1,
    
}FDChoiceType;

@protocol FDChoiceButtonDelegate <NSObject>

@optional
-(void)FDChoiceButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId;
//-(void)FDChoiceButtonCancelAtIndex:(NSUInteger)index inGroup:(NSString*)groupId;

@end

@interface FDChoiceButton : UIButton

@property (nonatomic, strong) NSString                 *groupId;
@property (nonatomic, assign) NSUInteger               index;
@property (nonatomic, assign) id<FDChoiceButtonDelegate  > delegate;
@property (nonatomic, assign) FDChoiceButtonStatusType statusType;
@property (nonatomic, assign) FDChoiceType             choiceType;

@property (nonatomic, copy) NSString    *nTitle;
@property (nonatomic, strong) UIColor   *nTitleColor;
@property (nonatomic, copy) NSString    *sTitle;
@property (nonatomic, strong) UIColor   *sTitleColor;

@property (nonatomic, strong) UILabel   *tLabel;

+ (instancetype)buttonWithFrame:(CGRect)frame
                  andChoiceType:(FDChoiceType)choiceType
                      withIndex:(NSUInteger)index
                        inGroup:(NSString*)groupId
              withSelectedImage:(UIImage*)selectedImage
                 andNormalImage:(UIImage*)normalImage;

+ (void)removedChoiceButtonFromMemoryInGroup:(NSString *)groupId;


- (void)setTitle:(NSString *)title
      titleColor:(UIColor *)titleColor
        forState:(UIControlState)state;


@end





