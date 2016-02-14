//
//  ColorConfig.h
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#ifndef ColorConfig_h
#define ColorConfig_h

/** 生成颜色 */
#define Color_16_A(RGB_Value, Alpha)     [UIColor colorWithRed:((float)((RGB_Value & 0xFF0000) >> 16))/255.0 green:((float)((RGB_Value & 0xFF00) >> 8))/255.0 blue:((float)(RGB_Value & 0xFF))/255.0 alpha:Alpha]

#define Color_16(RGB_Value)              [UIColor colorWithRed:((float)((RGB_Value & 0xFF0000) >> 16))/255.0 green:((float)((RGB_Value & 0xFF00) >> 8))/255.0 blue:((float)(RGB_Value & 0xFF))/255.0 alpha:1.0]


/** system颜色 */
#define Color_Clear      [UIColor clearColor]
#define Color_Red        [UIColor redColor]
#define Color_Yellow     [UIColor yellowColor]
#define Color_Green      [UIColor greenColor]
#define Color_White      [UIColor whiteColor]
#define Color_Black      [UIColor blackColor]
#define Color_Purple     [UIColor purpleColor]
#define Color_DarkGray   [UIColor darkGrayColor]
#define Color_LightGray  [UIColor lightGrayColor]

/** custom颜色 */
#define Color_C_Blue          Color_16(0x08b5f4)

#define Color_C_LightGrey     Color_16(0xeeedf2)

#define Color_C_Orange        Color_16(0xff9933)


#endif /* ColorConfig_h */







