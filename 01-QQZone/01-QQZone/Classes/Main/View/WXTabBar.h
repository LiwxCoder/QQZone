//
//  WXTabBar.h
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXTabBar;
@protocol WXTabBarDelegate <NSObject>

@optional
/** 监听tabBar的选中切换,从from切换到to */
- (void)tabBar:(WXTabBar *)tabBar from:(NSInteger)from to:(NSInteger)to;
@end

@interface WXTabBar : UIView
/** 代理属性 */
@property (weak, nonatomic) id<WXTabBarDelegate> delegate;

/** 获取当前屏幕方向 */
- (void)rotateToLandscape:(BOOL)isLandscape;

/** 取消选中 */
- (void)unSeleted;
@end

@interface WXTabBarItem : UIButton

@end
