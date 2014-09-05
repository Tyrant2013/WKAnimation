//
//  DestViewController.m
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-5.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "DestViewController.h"

@implementation DestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = UIColor.redColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(UIButton *)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
