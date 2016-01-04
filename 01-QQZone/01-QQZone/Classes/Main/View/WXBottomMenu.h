//
//  WXBottomMenu.h
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BottomMenuType) {
    BottomMenuTypeMood,
    BottomMenuTypePhoto,
    BottomMenuTypeBlog
};

@class WXBottomMenu;
@protocol WXBottomMenuDelegate <NSObject>

@optional
- (void)bottomMenu:(WXBottomMenu *)bottomMenu didClickItemType:(BottomMenuType)type;

@end

@interface WXBottomMenu : UIView

/** 代理属性 */
@property (weak, nonatomic) id<WXBottomMenuDelegate> delegate;

/** 获取当前屏幕方向 */
- (void)rotateToLandscape:(BOOL)isLandscape;
@end
