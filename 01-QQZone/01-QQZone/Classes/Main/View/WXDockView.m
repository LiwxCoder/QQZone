//
//  WXDockView.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXDockView.h"
#import "WXBottomMenu.h"
#import "WXTabBar.h"
#import "WXIconButton.h"

@interface WXDockView ()

@end

@implementation WXDockView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.初始化bottomMenu
        [self setupBottomMenu];
        
        // 2.初始化TabBar
        [self setupTabbar];
        
        // 3.初始化IconButton
        [self setupIconButton];
    }
    return self;
}

/** 初始化IconButton */
- (void)setupIconButton
{
    // 创建dockView顶部的IconButton,并添加到dockView
    WXIconButton *iconButton = [[WXIconButton alloc] init];
    iconButton.backgroundColor = [UIColor blueColor];
    [self addSubview:iconButton];
    _iconButton = iconButton;
}

/** 初始化TabBar */
- (void)setupTabbar
{
    // 创建dockView中间的tabBar,并添加到dockView
    WXTabBar *tabBar = [[WXTabBar alloc] init];
    tabBar.backgroundColor = [UIColor orangeColor];
    [self addSubview:tabBar];
    _tabBar = tabBar;
    
    // 设置中间的TabBar的autoresizingMask, 设置顶部可拉伸
    tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

/** 初始化bottomMenu */
- (void)setupBottomMenu
{
    // 创建bottomMenu,并添加到dockView
    WXBottomMenu *bottomMenu = [[WXBottomMenu alloc] init];
    bottomMenu.backgroundColor = [UIColor purpleColor];
    [self addSubview:bottomMenu];
    _bottomMenu = bottomMenu;
    
    // 设置底部View的autoresizingMask, 设置顶部可拉伸
    bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
}

/** 通过当前处于横竖屏来设置宽度 */
- (void)rotateToLandscape:(BOOL)isLandscape
{
    // 设置dockView自身宽度
    self.width = isLandscape ? kDockLandscapeWidth : kDockProtraitWidth;
    
    // 设置底部bottomMenu的frame
    [self.bottomMenu rotateToLandscape:isLandscape];
    
    // 设置中间TabBar的frame
    [self.tabBar rotateToLandscape:isLandscape];
    self.tabBar.y = self.height - self.bottomMenu.height - self.tabBar.height;
    
    // 设置顶部的IconButton的frame
    [self.iconButton rotateToLandscape:isLandscape];
}

@end
