//
//  WXMainViewController.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXMainViewController.h"
#import "WXDockView.h"
#import "WXBottomMenu.h"
#import "WXMoodViewController.h"

@interface WXMainViewController () <WXBottomMenuDelegate>

@property (nonatomic, weak) WXDockView *dockView;

@end

@implementation WXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置背景
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:1];
    
    // 2.初始化DockView
    [self setupDock];
    
}

/** 初始化DockView */
- (void)setupDock
{
    // 1.创建DockView
    WXDockView *dockView = [[WXDockView alloc] init];
    dockView.backgroundColor = [UIColor redColor];
    [self.view addSubview:dockView];
    self.dockView = dockView;
    
    // 设置dockView高度跟随父控件拉伸
    dockView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    // 2.设置dockView的frame
    dockView.height = self.view.height;
    
    // 3.获取屏幕方向,设置dockView的宽度
    // SINGLE: 判断横竖屏的方法: 宽度和高度比较,宽度如果大于高度,表示横屏
    // iPad iPad mini 1024 * 768
    // iPad pro 1366 * 1024
    BOOL isLandscape = self.view.width > self.view.height;
    [dockView rotateToLandscape:isLandscape];
    
    // 4.设置bottomMenu的代理
    self.dockView.bottomMenu.delegate = self;
    
}

/**
 *  监听屏幕旋转(过期)
 *
 *  @param toInterfaceOrientation 即将旋转到的屏幕方向
 *  @param duration               屏幕方向的旋转的时间
 */
//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration

/**
 *  监听屏幕旋转
 *
 *  @param size        即将旋转到的屏幕尺寸
 *  @param coordinator 协议参数
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    BOOL isLandscape = size.width > size.height;
    
    NSTimeInterval duration = [coordinator transitionDuration];
    [UIView animateWithDuration:duration animations:^{
        [self.dockView rotateToLandscape:isLandscape];
    }];
}

#pragma mark - WXBottomMenuDelegate
- (void)bottomMenu:(WXBottomMenu *)bottomMenu didClickItemType:(BottomMenuType)type
{
    switch (type) {
        case BottomMenuTypeMood:
        {
            WXMoodViewController *moodVc = [[WXMoodViewController alloc] init];
            UINavigationController *moodNav = [[UINavigationController alloc] initWithRootViewController:moodVc];
            
            // SINGLE: 设置moodNav导航控制器的Modal的样式为局部显示
            moodNav.modalPresentationStyle = UIModalPresentationFormSheet;
            // SINGLE: 设置moodNav导航控制器的Modal动画 UIModalTransitionStylePartialCurl: 仅在modalPresentationStyle为UIModalPresentationFullScreen的时候才能用,否则程序奔溃
//            moodNav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            
            [self presentViewController:moodNav animated:YES completion:nil];
        }
            break;
            
        case BottomMenuTypePhoto:
            NSLog(@"点击了发表图片");
            break;
            
        case BottomMenuTypeBlog:
            NSLog(@"点击了发表日志");
            break;
        default:
            break;
    }
}


@end
