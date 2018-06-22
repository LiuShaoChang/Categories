//
//  UILabel+Setting.h
//  YjyxParent
//
//  Created by 刘少昌 on 2018/5/21.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Setting)

//创建Label
+ (UILabel*)labelWithFrame:(CGRect)frame
                 textColor:(UIColor*)color
                      font:(UIFont*)font
                   context:(NSString*)context;

/**
 圆角处理

 @param text 文本
 @param color 字体颜色，边框颜色（同色）
 */
- (void)roundingWithText:(NSString *)text color:(UIColor *)color;

/**
 圆角处理

 @param text 文本
 @param textColor 文本颜色
 @param borderColor 边框颜色
 */
- (void)roundingWithText:(NSString *)text textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor;


@end
