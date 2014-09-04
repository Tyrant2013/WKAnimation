//
//  UIView+CapatureImage.h
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CapatureImage)

- (UIImage *)captureImage;

- (UIImage *)captureImageWithFrame:(CGRect)frame;

@end
