//
//  ViewController.m
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "ViewController.h"
#import "FastDevelopKit.h"

#define FDChoiceButtonDemo  @"FDChoiceButtonDemo"

@interface ViewController () <FDChoiceButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DLog(@"%@", Color_16(0xffffff));
    
    DLog(@"%@", IOS_Version);

    DLog(@"%d", IOS_10_Or_Later);
    
    NSArray * array = @[@"1", @"2"];
    
    $Try
    DLog(@"%@", array[10]);
    $Catch
    
    NSArray *titleArray = @[@"First", @"Second", @"Third"];
    CGFloat width = 100;
    CGFloat spacing = 10;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        NSString *title = titleArray[i];
        
        UIImage *nImage = [UIImage imageWithColor:Color_16_A(0x008800, 0.5) size:CGSizeMake(width, 34)];
        UIImage *sImage = [UIImage imageWithColor:Color_16_A(0x880000,0.5) size:CGSizeMake(width, 34)];
        
        CGFloat x = (Screen_W - (width + spacing) * titleArray.count + spacing) / 2.0;
        
        FDChoiceButton * choiceButton = [FDChoiceButton buttonWithFrame:CGRectMake(x + i * (width + spacing), 125, width, 34)
                                                          andChoiceType:FDChoiceTypeRadio
                                                              withIndex:i
                                                                inGroup:FDChoiceButtonDemo
                                                      withSelectedImage:sImage
                                                         andNormalImage:nImage];
        choiceButton.delegate            = self;
        choiceButton.layer.cornerRadius  = 5.0f;
        
        // set border
        [choiceButton setBorderWidth:1.0
                         borderColor:Color_16(0xb9b9b9)
                            forState:UIControlStateNormal];
        [choiceButton setBorderWidth:1.0
                         borderColor:Color_16(0x08b5f4)
                            forState:UIControlStateSelected];
        
        // set title
        choiceButton.tLabel.font = IsIphone4 || IsIphone5 ? Font_13 : Font_15;
        [choiceButton setTitle:title
                    titleColor:Color_16(0x666666)
                      forState:UIControlStateNormal];
        [choiceButton setTitle:title
                    titleColor:Color_16(0x08b5f4)
                      forState:UIControlStateSelected];
        
        [self.view addSubview:choiceButton];
        
        if (i == 0) {
            
            choiceButton.statusType = FDChoiceButtonStatusTypeSelected;
        }
    }
    
}


#pragma mark - FDChoiceButtonDelegate

- (void)fdChoiceButton:(FDChoiceButton *)fdChoiceButton
       selectedAtIndex:(NSUInteger)index
               inGroup:(NSString *)groupId {
    
    if ([groupId isEqualToString:FDChoiceButtonDemo]) {
        
        DLog(@"%@ say : MY groupId is %@, And my title is %@ ", fdChoiceButton, fdChoiceButton.groupId, fdChoiceButton.nTitle);
    }
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

