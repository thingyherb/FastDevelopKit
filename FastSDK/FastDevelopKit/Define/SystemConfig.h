//
//  SystemConfig.h
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#ifndef SystemConfig_h
#define SystemConfig_h

/** 获取屏幕物理高度 */
#define Screen_W  [UIScreen mainScreen].bounds.size.width
#define Screen_H  [UIScreen mainScreen].bounds.size.height
#define App_W     [UIScreen mainScreen].applicationFrame.size.width
#define App_H     [UIScreen mainScreen].applicationFrame.size.height


/** 设备 */
#define IsIphone6p  (Screen_W == 414.0 && Screen_H == 736.0)
#define IsIphone6   (Screen_W == 375.0 && Screen_H == 667.0)
#define IsIphone5   (Screen_W == 320.0 && Screen_H == 568.0)
#define IsIphone4   (Screen_W == 320.0 && Screen_H == 480.0)

#define isRetina  ([UIScreen mainScreen].scale == 2.0)


/** 屏幕比例 */
#define Screen_W_Percent  (Screen_W / CGFloat(320))
#define Screen_H_Percent  (Screen_H / CGFloat(480))


/** app版本号 */
#define App_infoDictionary [NSDictionary dictionaryWithDictionary:[NSBundle mainBundle].infoDictionary]

#define App_Version        [NSString stringWithFormat:@"%@", App_infoDictionary[@"CFBundleShortVersionString"]]
#define App_BundleVersion  [NSString stringWithFormat:@"%@", App_infoDictionary[@"CFBundleVersion"]]


/** iOS系统版本号 */
#define IOS_Version  [UIDevice currentDevice].systemVersion

#define IOS_11_Or_Later  ([IOS_Version doubleValue] >= 11)
#define IOS_10_Or_Later  ([IOS_Version doubleValue] >= 10)
#define IOS_9_Or_Later   (IOS_Version >= @"9")
#define IOS_8_Or_Later   (IOS_Version >= @"8")
#define IOS_7_Or_Later   (IOS_Version >= @"7")
#define IOS_6_Or_Later   (IOS_Version >= @"6")
#define IOS_5_Or_Later   (IOS_Version >= @"5")

#endif /* SystemConfig_h */









