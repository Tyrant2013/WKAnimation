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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    UIImage *image = [cell captureImage];
    CGRect frame = cell.frame;
    frame = [tableView.superview convertRect:frame fromView:tableView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = frame;
    [self.view addSubview:imageView];
    self.tableView.hidden = YES;
    
//    self.tableView.hidden = YES;
//    UIImage *image = [self.view captureImage];
//    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
//    [self.view addSubview:iv];
    
}

@end
