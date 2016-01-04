//
//  WXTabBar.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXTabBar.h"

@interface WXTabBar ()

/** 当前选中的tabBarItem */
@property (nonatomic, weak) WXTabBarItem *selectedItem;

@end

@implementation WXTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.初始化子控件
        [self setupItemsWithImageName:@"tab_bar_feed_icon" title:@"全部动态"];
        [self setupItemsWithImageName:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupItemsWithImageName:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupItemsWithImageName:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupItemsWithImageName:@"tab_bar_friend_icon" title:@"好友"];
        [self setupItemsWithImageName:@"tab_bar_e_more_icon" title:@"其他"];
    }
    return self;
}

#pragma mark - 初始化子控件
/** 初始化子控件方法 */
- (void)setupItemsWithImageName:(NSString *)imageName title:(NSString *)title
{
    // 创建tabBarItem,设置其属性并添加到TabBar
    WXTabBarItem *tabBarItem = [WXTabBarItem buttonWithType:UIButtonTypeCustom];
    [tabBarItem setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [tabBarItem setTitle:title forState:UIControlStateNormal];
    [tabBarItem setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    
    [tabBarItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabBarItem];
}

/** 切换TabBarItem的选中状态 */
- (void)itemClick:(WXTabBarItem *)tabBarItem
{
    self.selectedItem.selected = NO;
    self.selectedItem = tabBarItem;
    self.selectedItem.selected = YES;
}

/** 通过过传递过来的横竖屏参数,布局tabBarItem */
- (void)rotateToLandscape:(BOOL)isLandscape
{
    // 设置TabBar的宽高
    self.width = self.superview.width;
    self.height = kDockItemHeight * 6;
    
    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i < count; i++) {
        WXTabBarItem *tabBarItem = self.subviews[i];
        tabBarItem.width = self.width;
        tabBarItem.height = self.height / count;
        tabBarItem.x = 0;
        tabBarItem.y = tabBarItem.height * i;
    }
}

@end

#pragma mark - WXTabBarItem实现

// 图片所占的比例
const CGFloat kRatio = 0.4;
@implementation WXTabBarItem

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 设置TabBarItem的imageView的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

/** 设置TabBarItem横竖屏imageView的frame */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    // 通过TabBarItem的宽高来判断横竖屏
    if (self.width == self.height) {
        // 竖屏
        return self.bounds;
    }else {
        // 横屏
        CGFloat width = self.width * kRatio;
        CGFloat height = self.height;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}

/** 设置TabBarItem横竖屏titleLabel的frame */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    // 通过TabBarItem的宽高来判断横竖屏
    if (self.width == self.height) {
        // 竖屏,不显示文字
        return CGRectZero;
    }else {
        // 横屏
        CGFloat width = self.width * (1 - kRatio);
        CGFloat height = self.height;
        CGFloat x = self.width * kRatio;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
}

/** 取消高亮 */
- (void)setHighlighted:(BOOL)highlighted
{}

@end
