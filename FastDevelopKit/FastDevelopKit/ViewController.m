//
//  ViewController.m
//  FastDevelopKit
//
//  Created by zhao on 2/2/16.
//  Copyright © 2016 zmy. All rights reserved.
//

#import "ViewController.h"
#import "FastDevelopKit.h"

@interface ViewController ()

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
