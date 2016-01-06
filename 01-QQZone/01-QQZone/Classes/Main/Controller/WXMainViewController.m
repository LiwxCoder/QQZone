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
#import "WXTabBar.h"
#import "WXIconButton.h"
#import "WXAllStatusViewController.h"

@interface WXMainViewController () <WXBottomMenuDelegate, WXTabBarDelegate>

/** dockView */
@property (nonatomic, weak) WXDockView *dockView;
/** 内容的View*/
@property (nonatomic ,weak)UIView *contentView;
/** 之前控制器的下标*/
@property (nonatomic ,assign)NSInteger previousIndex;

@end

@implementation WXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置背景
    self.view.backgroundColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:1];
    
    // 2.初始化DockView
    [self setupDock];
    
    // 3.初始化控制器
    [self setupControllers];
    
    // 4.初始化弹出内容的view
    [self setupContentView];
    
    // 5.默认选中个人中心
    [self iconButtonClick];
    
}

#pragma mark - setup

/** 初始化弹出内容的view */
- (void)setupContentView {
    // 状态栏高度
    const float statusBarHeight = 20;
    
    // 创建内容view,并添加到控制器的view
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    [self.view addSubview:contentView];
    contentView.x = self.dockView.width;
    contentView.y = statusBarHeight;
    contentView.height = self.view.height - statusBarHeight;
    
    // 设置contentView的高度跟随父控件拉伸而拉伸
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    // 最终确定获得的宽度不管是在横屏情况下还是在竖屏情况下都是相等 = 竖屏情况下的宽度(768) - 竖屏情况下的dock的宽度 70
    // 获取最小值,横屏情况下获取到的是高度,竖屏情况下获取到的是宽度
    CGFloat protraitWidth = MIN(self.view.width, self.view.height);
    contentView.width = protraitWidth - kDockProtraitWidth;
    
}

/** 初始化控制器 */
- (void)setupControllers {
    // 1.添加子控制器
    WXAllStatusViewController *vc1 = [[WXAllStatusViewController alloc] init];
//    vc1.view.backgroundColor = [UIColor redColor];
    [self setNav:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor orangeColor];
    [self setNav:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor yellowColor];
    [self setNav:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = [UIColor greenColor];
    [self setNav:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    vc5.view.backgroundColor = [UIColor purpleColor];
    [self setNav:vc5];
    
    UIViewController *vc6 = [[UIViewController alloc] init];
    vc6.view.backgroundColor = [UIColor blueColor];
    [self setNav:vc6];
    
    UIViewController *vc7 = [[UIViewController alloc] init];
    vc7.title = @"个人中心";
    vc7.view.backgroundColor = [UIColor whiteColor];
    [self setNav:vc7];
}
/** 将传递过来的控制器包装导航控制器,并将导航控制器添加到当前控制器*/
- (void)setNav:(UIViewController *)vc {
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
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
    
    // 5.设置自定义tabBar代理
    self.dockView.tabBar.delegate = self;
    
    // 6.添加iconButton的监听
    [self.dockView.iconButton addTarget:self action:@selector(iconButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
        // 屏幕旋转时,重新设置contentView的x值,设置为当前dockView的宽度
        self.contentView.x = self.dockView.width;
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

#pragma mark - WXTabBarDelegate
- (void)tabBar:(WXTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to
{
    // 1.取出之前控制器的view并移除
    UIViewController *previousVC = self.childViewControllers[from];
    [previousVC.view removeFromSuperview];
    
    // 2.添加下一个控制器view
    UIViewController *nextVc = self.childViewControllers[to];
    [self.contentView addSubview:nextVc.view];
    
    // 3.设置nextVc的view的frame
    nextVc.view.frame = self.contentView.bounds;
    
    // 4.记录下标值,切换个人中心和其他控制器的时候取消tabBar选中的时候会用到
    self.previousIndex = to;
}

#pragma mark - Event
- (void)iconButtonClick
{
    // 1.切换到个人中心
    [self tabBar:nil from:self.previousIndex to:self.childViewControllers.count - 1];
    
    // 2.取消tabbar子控件的选中状态
    [self.dockView.tabBar unSeleted];
}


@end
