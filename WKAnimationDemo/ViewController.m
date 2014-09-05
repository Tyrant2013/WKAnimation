//
//  ViewController.m
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CapatureImage.h"

@interface ViewController ()<
  UITableViewDataSource,
  UITableViewDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.backgroundColor = UIColor.lightGrayColor;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    UIImage *srcImage = [cell captureImage];
    UIImageView *srcIV = [[UIImageView alloc] initWithImage:srcImage];
    CGRect srcFrame = [cell.superview.superview convertRect:cell.frame fromView:cell.superview];
    srcIV.frame = srcFrame;
    srcIV.layer.zPosition = 1024;//重要，否则只能看到一半
    [self.view addSubview:srcIV];
    cell.hidden = YES;
    
    UIViewController *destViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DestViewController"];
    UIImage *dstImage = [destViewController.view captureImage];
    UIImageView *dstImageView = [[UIImageView alloc] initWithImage:dstImage];
    dstImageView.layer.zPosition = 1024;//重要，否则只能看到一半
    CGRect dstFrame = dstImageView.frame;
    [self.view addSubview:dstImageView];
    dstImageView.hidden = YES;
    
    CGRect centerFrame = CGRectZero;
    centerFrame.origin.x = (CGRectGetMinX(srcFrame) + CGRectGetMinX(dstFrame)) / 2;
    centerFrame.origin.y = (CGRectGetMinY(srcFrame) + CGRectGetMinY(dstFrame)) / 2;
    centerFrame.size.width = (CGRectGetWidth(srcFrame) + CGRectGetWidth(dstFrame)) / 2;
    centerFrame.size.height = (CGRectGetHeight(srcFrame) + CGRectGetHeight(dstFrame)) / 2;
    CATransform3D preTrans = CATransform3DMakeRotation(-M_PI/2, 0, 1, 0);
    preTrans.m34 = 1.0f/-500;
    dstImageView.layer.transform = preTrans;
    dstImageView.frame = centerFrame;
    
    CATransform3D srcTransform = CATransform3DMakeRotation(M_PI/2, 0, 1, 0);
    srcTransform.m34 = 1.0f/-500;
    
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        srcIV.frame = centerFrame;
        srcIV.layer.transform = srcTransform;
        
    } completion:^(BOOL finished) {
        [srcIV removeFromSuperview];
        dstImageView.hidden = NO;
        CATransform3D dstTranstorm = CATransform3DMakeRotation(0, 0, 1, 0);
        dstTranstorm.m34 = 1.0f/-500;
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            dstImageView.layer.transform = dstTranstorm;
            dstImageView.frame = dstFrame;
        } completion:^(BOOL finished) {
            tableView.hidden = NO;
            [dstImageView removeFromSuperview];
            [self presentViewController:destViewController animated:NO completion:nil];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }];
    }];
}

@end
