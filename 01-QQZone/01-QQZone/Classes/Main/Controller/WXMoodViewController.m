//
//  WXMoodViewController.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/5.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXMoodViewController.h"

@interface WXMoodViewController ()

@end

@implementation WXMoodViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"发表说说";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closeBarButtonClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)closeBarButtonClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
