//
//  UIButton+Badge.m
//  YjyxParent
//
//  Created by 刘少昌 on 2017/10/18.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "UIButton+Badge.h"
#import <objc/runtime.h>

NSString const *badgeKey                 = @"badgeKey";

NSString const *badgeBGColorKey          = @"badgeBGColorKey";
NSString const *badgeTextColorKey        = @"badgeTextColorKey";
NSString const *badgeFontKey             = @"badgeFontKey";
NSString const *badgeHorizonPaddingKey   = @"badgeHorizonPaddingKey";
NSString const *badgeVerticalPaddingKey  = @"badgeVerticalPaddingKey";
NSString const *badgeMinHeightKey        = @"badgeMinHeightKey";
NSString const *badgeMinWidthKey         = @"badgeMinWidthKey";
NSString const *badgeOriginXKey          = @"badgeOriginXKey";
NSString const *badgeOriginYKey          = @"badgeOriginYKey";
NSString const *shouldHideBadgeAtZeroKey = @"shouldHideBadgeAtZeroKey";
NSString const *shouldAnimateBadgeKey    = @"shouldAnimateBadgeKey";
NSString const *badgeValueKey            = @"badgeValueKey";

@implementation UIButton (Badge)

#pragma mark - Utility methods

// 当角标的属性改变时，调用此方法
- (void)refreshBadge
{
    // 更新属性
    self.badge.textColor        = self.badgeTextColor;
    self.badge.backgroundColor  = self.badgeBGColor;
    self.badge.font             = self.badgeFont;
}

- (CGSize) badgeExpectedSize
{
    // 自适应角标
    UILabel *frameLabel = [self duplicateLabel:self.badge];
    [frameLabel sizeToFit];
    
    CGSize expectedLabelSize = frameLabel.frame.size;
    return expectedLabelSize;
}
/**
 *  更新角标的frame
 */
- (void)updateBadgeFrame
{
    
    CGSize expectedLabelSize = [self badgeExpectedSize];
    
    CGFloat minHeight = expectedLabelSize.height;
    CGFloat minWidth = expectedLabelSize.width;
    // 判断如果小于最小size，则为最小size
    minHeight = (minHeight < self.badgeMinHeight) ? self.badgeMinHeight : expectedLabelSize.height;
    minWidth = (minWidth < self.badgeMinWidth) ? self.badgeMinWidth : expectedLabelSize.width;
    CGFloat horizonPadding = self.badgeHorizonPadding;
    CGFloat verticalPadding = self.badgeVerticalPadding;
    
    // 填充边界
    self.badge.frame = CGRectMake(self.badgeOriginX, self.badgeOriginY, minWidth + horizonPadding, minHeight + verticalPadding);
    self.badge.layer.cornerRadius = (minHeight + verticalPadding) / 2;
    
}

// 角标值变化
- (void)updateBadgeValueAnimated:(BOOL)animated
{
    // 动画效果
    if (animated && self.shouldAnimateBadge && ![self.badge.text isEqualToString:self.badgeValue]) {
        CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        [animation setFromValue:[NSNumber numberWithFloat:1.5]];
        [animation setToValue:[NSNumber numberWithFloat:1]];
        [animation setDuration:0.2];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithControlPoints:.4f :1.3f :1.f :1.f]];
        [self.badge.layer addAnimation:animation forKey:@"bounceAnimation"];
    }
    self.badge.text = self.badgeValue;
    
    // 动画时间
    NSTimeInterval duration = animated ? 0.2 : 0;
    [UIView animateWithDuration:duration animations:^{
        [self updateBadgeFrame];
    }];
}

- (UILabel *)duplicateLabel:(UILabel *)labelToCopy
{
    UILabel *duplicateLabel = [[UILabel alloc] initWithFrame:labelToCopy.frame];
    duplicateLabel.text = labelToCopy.text;
    duplicateLabel.font = labelToCopy.font;
    return duplicateLabel;
}

- (void)removeBadge
{
    // 移除角标
    [UIView animateWithDuration:0.2 animations:^{
        self.badge.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL finished) {
        [self.badge removeFromSuperview];
        self.badge = nil;
    }];
}

#pragma mark - getters/setters
- (UILabel*)badge {
    return objc_getAssociatedObject(self, &badgeKey);
}
- (void)setBadge:(UILabel *)badgeLabel
{
    objc_setAssociatedObject(self, &badgeKey, badgeLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 显示角标
- (NSString *)badgeValue {
    return objc_getAssociatedObject(self, &badgeValueKey);
}

- (void)setBadgeValue:(NSString *)badgeValue {
    objc_setAssociatedObject(self, &badgeValueKey, badgeValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 当角标信息不存在，或者为空，则移除
    if (!badgeValue || [badgeValue isEqualToString:@""] || ([badgeValue isEqualToString:@"0"] && self.shouldHideBadgeAtZero)) {
        [self removeBadge];
    } else if (!self.badge) {
        //当又有值时，重新设置角标
        self.badge = [[UILabel alloc] initWithFrame:CGRectMake(self.badgeOriginX, self.badgeOriginY, 20, 20)];
        
        self.badge.textColor = self.badgeTextColor;
        self.badge.backgroundColor = self.badgeBGColor;
        self.badge.font = self.badgeFont;
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.clipsToBounds = YES;
        self.clipsToBounds = NO;
        [self addSubview:self.badge];
        [self updateBadgeValueAnimated:NO];
    } else {
        [self updateBadgeValueAnimated:YES];
    }
}

//进行关联
- (UIColor *)badgeBGColor {
    UIColor *bgColor = objc_getAssociatedObject(self, &badgeBGColorKey);
    if (!bgColor) {
        bgColor = [UIColor redColor];
    }
    return bgColor;
}
//获取关联
- (void)setBadgeBGColor:(UIColor *)badgeBGColor {
    objc_setAssociatedObject(self, &badgeBGColorKey, badgeBGColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeTextColor {
    UIColor *textColor = objc_getAssociatedObject(self, &badgeTextColorKey);
    if (!textColor) {
        textColor = [UIColor whiteColor];
    }
    return textColor;
}
- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
    objc_setAssociatedObject(self, &badgeTextColorKey, badgeTextColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)badgeFont {
    UIFont *font = objc_getAssociatedObject(self, &badgeFontKey);
    if (!font) {
        font = [UIFont systemFontOfSize:12];
    }
    return font;
}
- (void)setBadgeFont:(UIFont *)badgeFont {
    objc_setAssociatedObject(self, &badgeFontKey, badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)badgeHorizonPadding {
    NSNumber *number = objc_getAssociatedObject(self, &badgeHorizonPaddingKey);
    if (!number) {
        number = @6;
    }
    return number.floatValue;
}

- (void)setBadgeHorizonPadding:(CGFloat)badgeHorizonPadding {
    NSNumber *number = [NSNumber numberWithDouble:badgeHorizonPadding];
    objc_setAssociatedObject(self, &badgeHorizonPaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)badgeVerticalPadding {
    NSNumber *number = objc_getAssociatedObject(self, &badgeVerticalPaddingKey);
    if (!number) {
        number = @4;
    }
    return number.floatValue;
}

- (void)setBadgeVerticalPadding:(CGFloat)badgeVerticalPadding {
    NSNumber *number = [NSNumber numberWithDouble:badgeVerticalPadding];
    objc_setAssociatedObject(self, &badgeVerticalPaddingKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGFloat)badgeMinHeight {
    NSNumber *number = objc_getAssociatedObject(self, &badgeMinHeightKey);
    if (!number) {
        number = @8;
    }
    return number.floatValue;
}
- (void)setBadgeMinHeight:(CGFloat)badgeMinHeight {
    NSNumber *number = [NSNumber numberWithDouble:badgeMinHeight];
    objc_setAssociatedObject(self, &badgeMinHeightKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)badgeMinWidth {
    NSNumber *number = objc_getAssociatedObject(self, &badgeMinWidthKey);
    if (!number) {
        number = @20;
    }
    return number.floatValue;
}

- (void)setBadgeMinWidth:(CGFloat)badgeMinWidth {
    NSNumber *number = [NSNumber numberWithDouble:badgeMinWidth];
    objc_setAssociatedObject(self, &badgeMinWidthKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginXKey);
    if (!number) {
        number = @(self.frame.size.width - self.badge.frame.size.width/2);
    }
    return number.floatValue;
}

- (void)setBadgeOriginX:(CGFloat)badgeOriginX
{
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGFloat)badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &badgeOriginYKey);
    if (!number) {
        number = @(-4);
    }
    return number.floatValue;
}

- (void)setBadgeOriginY:(CGFloat)badgeOriginY {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldHideBadgeAtZero {
    NSNumber *number = objc_getAssociatedObject(self, &shouldHideBadgeAtZeroKey);
    if (!number) {
        number = [NSNumber numberWithBool:YES];
    }
    return number.boolValue;
}
- (void)setShouldHideBadgeAtZero:(BOOL)shouldHideBadgeAtZero {
    NSNumber *number = [NSNumber numberWithBool:shouldHideBadgeAtZero];
    objc_setAssociatedObject(self, &shouldHideBadgeAtZeroKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldAnimateBadge {
    NSNumber *number = objc_getAssociatedObject(self, &shouldAnimateBadgeKey);
    if (!number) {
        number = [NSNumber numberWithBool:YES];
    }
    return number.boolValue;
}
- (void)setShouldAnimateBadge:(BOOL)shouldAnimateBadge {
    NSNumber *number = [NSNumber numberWithBool:shouldAnimateBadge];
    objc_setAssociatedObject(self, &shouldAnimateBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




@end
