//
//  WXTabBar.h
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXTabBar : UIView
/** 获取当前屏幕方向 */
- (void)rotateToLandscape:(BOOL)isLandscape;
@end

@interface WXTabBarItem : UIButton

@end
