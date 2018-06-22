//
//  UIButton+Badge.h
//  YjyxParent
//
//  Created by 刘少昌 on 2017/10/18.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Badge)

@property (strong, nonatomic) UILabel *badge;

/**
 *  角标显示的信息，可以为数字和文字
 */
@property (copy, nonatomic) NSString *badgeValue;
/**
 *  角标背景颜色，默认为红色
 */
@property (strong, nonatomic) UIColor *badgeBGColor;
/**
 *  角标文字的颜色
 */
@property (strong, nonatomic) UIColor *badgeTextColor;
/**
 *  角标字号
 */
@property (strong, nonatomic) UIFont *badgeFont;
/**
 *  角标的气泡水平边界
 */
@property (assign, nonatomic) CGFloat badgeHorizonPadding;
/**
 *  角标的气泡竖直边界
 */
@property (assign, nonatomic) CGFloat badgeVerticalPadding;
/**
 *  角标的最小高度
 */
@property (assign, nonatomic) CGFloat badgeMinHeight;
/**
 *  角标的最小宽度
 */
@property (assign, nonatomic) CGFloat badgeMinWidth;

/**
 *  角标的x值
 */
@property (assign, nonatomic) CGFloat badgeOriginX;
/**
 *  角标的y值
 */
@property (assign, nonatomic) CGFloat badgeOriginY;
/**
 *  当角标为0时，自动去除角标
 */
@property (assign, nonatomic) BOOL shouldHideBadgeAtZero;
/**
 *  当角标的值发生变化，角标的动画是否显示
 */
@property (assign, nonatomic) BOOL shouldAnimateBadge;




@end
