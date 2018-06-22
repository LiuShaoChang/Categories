//
//  UILabel+Setting.m
//  YjyxParent
//
//  Created by 刘少昌 on 2018/5/21.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import "UILabel+Setting.h"

@implementation UILabel (Setting)

+ (UILabel*)labelWithFrame:(CGRect)frame
                 textColor:(UIColor*)color
                      font:(UIFont*)font
                   context:(NSString*)context
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = frame;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = color;
    label.font = font;
    label.textAlignment = NSTextAlignmentLeft;
    label.text = context;
    
    return label;
}

- (void)roundingWithText:(NSString *)text color:(UIColor *)color {
    
    [self roundingWithText:text textColor:color borderColor:color];
}

- (void)roundingWithText:(NSString *)text textColor:(UIColor *)textColor borderColor:(UIColor *)borderColor {
    
    CGFloat width = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.width;
    CGRect frame = self.frame;
    frame.size.width = width + 30;
    self.frame = frame;
    self.textAlignment = NSTextAlignmentCenter;
    self.textColor = textColor;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = frame.size.height / 2;
    self.layer.masksToBounds = YES;
    self.text = text;
    
}

@end
