//
//  WXDockView.h
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXTabBar, WXBottomMenu, WXIconButton;

@interface WXDockView : UIView

/** dockView底部的View */
@property (nonatomic, weak, readonly) WXBottomMenu *bottomMenu;
/** dockView中间的TabBar */
@property (nonatomic, weak, readonly) WXTabBar *tabBar;
/** dockView顶部的的IconButton */
@property (nonatomic, weak, readonly) WXIconButton *iconButton;

/** 获取当前屏幕方向 */
- (void)rotateToLandscape:(BOOL)isLandscape;
@end
