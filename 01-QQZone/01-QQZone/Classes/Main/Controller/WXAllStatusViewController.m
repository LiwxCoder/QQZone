//
//  WXAllStatusViewController.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/7.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXAllStatusViewController.h"

@interface WXAllStatusViewController ()

@end

@implementation WXAllStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 2.设置titleView为UISegmentedControl
    [self setTitleView];
}

- (void)setTitleView
{
    // 1.创建UISegmentedControl
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"全部",@"特别关心",@"好友动态",@"认证空间"]];
    
    // 2.设置UISegmentedControl主题颜色
    seg.tintColor = [UIColor lightGrayColor];
    
    // 3.设置默认选中
    seg.selectedSegmentIndex = 0;
    
    // SINGLE: 4.设置未选中的文字颜色
    NSDictionary *dict = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [seg setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    // 5.监听UISegmentedControl
    [seg addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    
    // 设置UISegmentedControl为titleView
    self.navigationItem.titleView = seg;
}

- (void)segClick:(UISegmentedControl *)seg
{
    NSLog(@"%ld", seg.selectedSegmentIndex);
}

@end
