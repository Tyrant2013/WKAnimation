//
//  DestViewController.h
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-5.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestViewController : UIViewController

- (IBAction)goBack:(UIButton *)sender;

@property (nonatomic, copy) void (^returnAnimationBlock)();

@end
