//
//  WXBottomMenu.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXBottomMenu.h"

@implementation WXBottomMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 初始化子控件
        [self setupItemsWithImageName:@"tabbar_mood" type:BottomMenuTypeMood];
        [self setupItemsWithImageName:@"tabbar_photo" type:BottomMenuTypePhoto];
        [self setupItemsWithImageName:@"tabbar_blog" type:BottomMenuTypeBlog];
    }
    return self;
}

#pragma mark - 初始化bottomMenu子控件
/** 初始化bottomMenu子控件,添加子控件 */
- (void)setupItemsWithImageName:(NSString *)imageName type:(BottomMenuType)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = type;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
}

/** 监听item按钮点击 */
- (void)itemClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(bottomMenu:didClickItemType:)]) {
        [self.delegate bottomMenu:self didClickItemType:button.tag];
    }
}

- (void)rotateToLandscape:(BOOL)isLandscape
{
    // 设置bottomMenu的frame, x为0,可以不用设置
    self.width = self.superview.width;
    self.height = isLandscape ? kDockItemHeight : kDockItemHeight * 3;
    self.y = self.superview.height - self.height;
    
    // 设置子控件frame
    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *button = self.subviews[i];
        
        button.width = isLandscape ? self.width / count : self.width;
        button.height = kDockItemHeight;
        button.x = isLandscape ? button.width * i : 0;
        button.y = isLandscape ? 0 : button.height * i;
    }
}

@end
