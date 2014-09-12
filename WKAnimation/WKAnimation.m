//
//  WKAnimation.m
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "WKAnimation.h"
#import "UIView+CapatureImage.h"

@implementation WKAnimation

#pragma mark - private method

+ (CGRect)rectInScreen:(UIView *)view
{
    CGRect realFrame = CGRectZero;
    Class transitionView = NSClassFromString(@"UITransitionView");
    Class layoutContrainerView = NSClassFromString(@"UILayoutContainerView");
    UIView *superView = view.superview;
    while (superView && ![superView isKindOfClass:transitionView] && ![superView isKindOfClass:layoutContrainerView])
    {
        CGRect newFrame = [superView.superview convertRect:view.frame fromView:superView];
        if (CGRectEqualToRect(newFrame, CGRectZero)){
            break;
        }
        realFrame = newFrame;
        
        superView = superView.superview;
    }
    
    return realFrame;
}

+ (CGRect)middleFrameWithBeginFrame:(CGRect)begin end:(CGRect)end
{
    CGRect middle = CGRectZero;
    
    middle.origin.x = (CGRectGetMinX(begin) + CGRectGetMinX(end)) / 2;
    middle.origin.y = (CGRectGetMinY(begin) + CGRectGetMinY(end)) / 2;
    middle.size.width = (CGRectGetWidth(begin) + CGRectGetWidth(end)) / 2;
    middle.size.height = (CGRectGetHeight(begin) + CGRectGetHeight(end)) / 2;
    
    return middle;
}

+ (void)animateFlipFromView:(UIView *)srcView
         fromViewController:(UIViewController *)srcViewController
           toViewController:(UIViewController *)dstViewController
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    //create src imageview that the current view
    UIImage *srcImage = [srcView captureImage];
    UIImageView *srcImageView = [[UIImageView alloc] initWithImage:srcImage];
//    CGRect srcFrame = [self rectInScreen:srcView];
    CGRect srcFrame = [srcView.superview convertRect:srcView.frame toView:srcViewController.view];
    srcImageView.layer.zPosition = 1024;
    srcImageView.frame = srcFrame;
    [srcViewController.view addSubview:srcImageView];
    
    //create dst imageview that will go to
    UIImage *dstImage = [dstViewController.view captureImage];
    UIImageView *dstImageView = [[UIImageView alloc] initWithImage:dstImage];
    CGRect dstFrame = dstImageView.frame;
    dstImageView.layer.zPosition = 1024;
    dstImageView.hidden = YES;
    [srcViewController.view addSubview:dstImageView];
    
    CGRect middle = [self middleFrameWithBeginFrame:srcFrame end:dstFrame];
    
    CATransform3D dstBeginTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    dstImageView.layer.transform = dstBeginTransform;
    dstImageView.frame = middle;
    
    CGFloat duration = 0.3f;
    
    CATransform3D srcTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         srcImageView.layer.transform = srcTransform;
                         srcImageView.frame = middle;
                     }
                     completion:^(BOOL finished) {
                         [srcImageView removeFromSuperview];
                         dstImageView.hidden = NO;
                         CATransform3D dstTransform = CATransform3DMakeRotation(0, 0, 1, 0);
                         [UIView animateWithDuration:duration
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseOut
                                          animations:^{
                                              dstImageView.layer.transform = dstTransform;
                                              dstImageView.frame = dstFrame;
                                          }
                                          completion:^(BOOL finished) {
                                              [dstImageView removeFromSuperview];
                                              [srcViewController presentViewController:dstViewController
                                                                              animated:NO
                                                                            completion:nil];
                                              [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                          }];
                     }];
}

+ (void)animateReverseFlipFromView:(UIView *)srcView
                fromViewController:(UIViewController *)srcViewController
                  toViewController:(UIViewController *)dstViewController
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    //the transition animation will run between two  image-view
    
    //creat src imageview that will return to
    UIImage *srcImage = [srcView captureImage];
    UIImageView *srcImageView = [[UIImageView alloc] initWithImage:srcImage];
//    CGRect srcFrame = [self rectInScreen:srcView];//this is alright,but in animateFlipFromView:fromViewController:toViewController: is wrong
    CGRect srcFrame = [srcViewController.view convertRect:srcView.frame fromView:srcView.superview];
    srcImageView.layer.zPosition = 1024;
    srcImageView.frame = srcFrame;
    srcImageView.hidden = YES;
    [srcViewController.view addSubview:srcImageView];
    
    //create dst imageview that the current view
    UIImage *dstImage = [dstViewController.view captureImage];
    UIImageView *dstImageView = [[UIImageView alloc] initWithImage:dstImage];
    CGRect dstFrame = dstImageView.frame;
    dstImageView.layer.zPosition = 1024;
    [srcViewController.view addSubview:dstImageView];
    
    CGRect middle = [self middleFrameWithBeginFrame:srcFrame end:dstFrame];
    
    CATransform3D srcBeginTransform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
    srcImageView.layer.transform = srcBeginTransform;
    srcImageView.frame = middle;
    
    CGFloat duration = 0.3f;
    CATransform3D dstTransform = CATransform3DMakeRotation(-M_PI_2, 0, 1, 0);
    
    [dstViewController dismissViewControllerAnimated:NO completion:nil];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         dstImageView.layer.transform = dstTransform;
                         dstImageView.frame = middle;
                     }
                     completion:^(BOOL finished) {
                         [dstImageView removeFromSuperview];
                         srcImageView.hidden = NO;
                         CATransform3D srcTransform = CATransform3DMakeRotation(0, 0, 1, 0);
                         [UIView animateWithDuration:duration
                                               delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              srcImageView.layer.transform = srcTransform;
                                              srcImageView.frame = srcFrame;
                                          }
                                          completion:^(BOOL finished) {
                                              [srcImageView removeFromSuperview];
                                              [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                                          }];
                     }];
}

@end
