//
//  ViewController.m
//  WKAnimationDemo
//
//  Created by ZhuangXiaowei on 14-9-4.
//  Copyright (c) 2014年 Tyrant. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CapatureImage.h"
#import "WKAnimation.h"
#import "DestViewController.h"

@interface ViewController ()<
  UITableViewDataSource
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
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    cell.backgroundColor = UIColor.lightGrayColor;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender;
    DestViewController *destViewController = (DestViewController *)segue.destinationViewController;
    DestViewController *tmpView = destViewController;
    destViewController.returnAnimationBlock = ^(){
        [WKAnimation animateReverseFlipFromView:cell fromViewController:self toViewController:tmpView];
    };
    [WKAnimation animateFlipFromView:cell fromViewController:self toViewController:destViewController];
}

@end
