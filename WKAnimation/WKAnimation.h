//
//  WKAnimation.h
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKAnimation : NSObject

+ (void)animateFlipFromView:(UIView *)srcView fromViewController:(UIViewController *)srcViewController toViewController:(UIViewController *)dstViewController;
+ (void)animateReverseFlipFromView:(UIView *)srcView fromViewController:(UIViewController *)srcViewController toViewController:(UIViewController *)dstViewController;

+ (void)animateExternFromView:(UIView *)srcView fromViewController:(UIViewController *)srcViewController toViewController:(UIViewController *)dstViewController;
+ (void)animateReverseExternFromView:(UIView *)srcView fromViewController:(UIViewController *)srcViewController toViewController:(UIViewController *)dstViewController;

@end
