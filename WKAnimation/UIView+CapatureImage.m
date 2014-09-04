//
//  UIView+CapatureImage.m
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "UIView+CapatureImage.h"

@implementation UIView (CapatureImage)

- (UIImage *)captureImage
{
    return [self captureImageWithFrame:CGRectNull];
}

- (UIImage *)captureImageWithFrame:(CGRect)frame
{
    if (CGRectEqualToRect(frame, CGRectNull))
    {
        frame = self.bounds;
    }
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef contex = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(contex, frame.origin.x, frame.origin.y);
    [self.layer renderInContext:contex];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
