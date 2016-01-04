//
//  WXIconButton.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXIconButton.h"

@interface WXIconButton ()

/** 记录当前是横屏还是竖屏状态 */
@property (nonatomic, assign) BOOL isLandscape;

@end

@implementation WXIconButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 1.设置图标
        [self setImage:[UIImage imageNamed:@"Easy"] forState:UIControlStateNormal];
        // 2.设置文字,并设置居中对齐, imageView的图片大,会填充整个button,需重新设置imageView和titleLabel的frame
        [self setTitle:@"灌篮高手" forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

/** 通过传递过来的饿横竖屏参数,设置frame */
- (void)rotateToLandscape:(BOOL)isLandscape
{
    self.isLandscape = isLandscape;
    
    self.width = isLandscape ? kIconButtonLandscapeWidth : kIconButtonProtraitWH;
    self.height = isLandscape ? kIconButtonLandscapeHeight : kIconButtonProtraitWH;
    self.x = (self.superview.width - self.width) * 0.5;
    self.y = kIconButtonY;
}


#pragma mark - 设置iconButton子控件的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    if (!self.isLandscape) { // 竖屏
        return self.bounds;
    } else { // 横屏
        CGFloat width = self.width;
        CGFloat height = width;
        CGFloat x = 0;
        CGFloat y = 0;
        return CGRectMake(x, y, width, height);
    }
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    if (!self.isLandscape) { // 竖屏
        return CGRectZero;
    } else { // 横屏
        CGFloat width = self.width;
        CGFloat height = kIconButtonLandscapeTitleH;
        CGFloat x = 0;
        CGFloat y = width;
        return CGRectMake(x, y, width, height);
    }
}

@end
