//
//  Const.m
//  QQZone
//
//  Created by xmg on 16/1/4.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "Const.h"

#pragma mark - DockView的横竖屏宽度
/** 横屏时dockView宽度 */
const CGFloat kDockLandscapeWidth = 270;
/** 竖屏时dockView宽度 */
const CGFloat kDockProtraitWidth = 70;

#pragma mark - BottomView中每个Button的宽度
/** 横屏时dockView中的BottomView的每个Button的宽度 */
const CGFloat kDockItemHeight = 70;

#pragma mark - IconButton横竖屏的宽高
/** 横屏时dockView中的IconButton的宽度 */
const CGFloat kIconButtonLandscapeWidth = 90;
/** 横屏时dockView中的IconButton的Title文字所占据的宽度 */
const CGFloat kIconButtonLandscapeTitleH = 30;
/** 横屏时dockView中的IconButton的高度 */
const CGFloat kIconButtonLandscapeHeight = kIconButtonLandscapeWidth + kIconButtonLandscapeTitleH;
/** 横屏时dockView中的IconButton的Y值 */
const CGFloat kIconButtonY = 40;
/** 竖屏时dockView中的IconButton的宽高度 */
const CGFloat kIconButtonProtraitWH = 60;