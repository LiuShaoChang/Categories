//
//  UIView+category.h
//  BaseTool
//
//  Created by spinery on 14/10/28.
//  Copyright (c) 2014年 GMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <CoreGraphics/CoreGraphics.h>
#import <Accelerate/Accelerate.h>
#import "RTSpinKitView.h"

//TOAST显示位置
typedef enum SHOW_POSITION {
    SHOW_TOP,//顶部
    SHOW_CENTER,//中部
    SHOW_BOTTOM,//底部
} SHOW_POSITION;

typedef NS_ENUM(NSUInteger, ImageColorStyle) {
    ImageColorBlackWhiteStyle = 1,      // 黑白
    ImageColorBrownStyle = 2,           // 深棕色
    ImageColorExchangeStyle = 3,        // 颜色反转
    ImageColorOriginStyle           // 原图
};


@interface UIView (category)

/**
 * 视图坐标
 * @returned    视图坐标
 */
- (CGPoint)origin;

/**
 * 视图相对于父view的最小x坐标
 * @returned    最小x坐标
 */
- (CGFloat)minX;

/**
 * 视图相对于父view的最大x坐标
 * @returned    最大x坐标
 */
- (CGFloat)maxX;

/**
 * 视图相对于父view的最小y坐标
 * @returned    最小y坐标
 */
- (CGFloat)minY;

/**
 * 视图相对于父view的最大y坐标
 * @returned    最大y坐标
 */
- (CGFloat)maxY;

/**
 * 视图高宽
 * @returned    视图高宽
 */
- (CGSize)size;

/**
 * 视图宽
 * @returned    视图宽
 */
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
/**
 * 视图高
 * @returned    视图高
 */
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

/**
 * 设置中心点X
 */
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;
/**
 * 设置中心点Y
 */
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;
/**
 * 设置y值
 */
- (CGFloat)y;

- (void)setY:(CGFloat)y;
/**
 * 设置x值
 */
- (CGFloat)x;

- (void)setX:(CGFloat)x;
/**
 * 当前界面隐藏键盘
 */
- (void)hideKeyboard;

/**
 * 视图阴影渲染
 * @param       radius 渲染半径
 * @param       color 渲染颜色
 */
- (void)render:(CGFloat)radius withColor:(UIColor*)color;

/**
 * 视图截取为突破
 * @returned    视图截取后的图片
 */
- (UIImage*)viewShot;

/**
 * 视图圆角
 * @param       radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 * 视图边框
 * @param       width 边框宽度
 * @param       color 边框颜色
 */
- (void)setBorder:(CGFloat)width withColor:(CGColorRef)color;

/**
 * 视图上添加等待视图
 * @param       style 等待视图样(RTSpinKitViewStylePlane,RTSpinKitViewStyleBounce,RTSpinKitViewStyleWave,RTSpinKitViewStyleWanderingCubes,RTSpinKitViewStylePulse)
 * @param       color 等待视图颜色
 * @param       point 等待视图位置
 */
- (void)activity:(RTSpinKitViewStyle)style color:(UIColor*)color onCenter:(CGPoint)point;

/**
 * 隐藏等待视图
 */
- (void)disActivity;

/**
 * 视图上添加toast提示
 * @param       message 提示内容
 * @param       interval 提示时长
 * @param       position 显示位置
 */
- (void)makeToast:(NSString *)message
         duration:(CGFloat)interval
         position:(SHOW_POSITION)position
         complete:(void (^)(void))block;

/**
 * 视图上添加等待视图
 * @param       position 显示位置
 */
- (void)makeToastActivity:(SHOW_POSITION)position;
- (void)makeToastActivity:(SHOW_POSITION)position message:(NSString *)str;
/**
 * 隐藏等待视图
 */
- (void)hideToastActivity;

/**
 * 缩放动画显示
 */
- (void)scaleToShow;

//显示badge
- (UIView *)showBadge;

- (void)removeBadgeValue;

/**
 * 加载自定义gif动画
 */
- (void)makeGifToast:(NSString *)gif position:(SHOW_POSITION)position;

/**
 * 加载自定义图片动画
 */
- (void)makeLoadingToast:(NSArray *)imagArr position:(SHOW_POSITION)position;

/**
 带有透明背景的等待动画

 @param position 加载图片显示位置
 */
- (void)makeLoadingToastWithBackground:(SHOW_POSITION)position;




@end

@interface UIImage (category)

/**
 * 通过颜色和大小生成纯色图片
 * @param       color 图片的颜色
 * @param       bounds 图片大小
 * @returned    纯色图片
 */
+ (UIImage *)imageFromColor:(UIColor *)color withSize:(CGSize)size;

/**
 * 拍摄图片压缩后进行旋转处理
 * @param       iWidth 缩放适应的宽度
 * @param       isClip 超过宽度是否裁剪
 * @returned    纯色图片
 */
- (UIImage *)scaleSuit:(CGFloat)iWidth clip:(BOOL)isClip;

/**
 * 图片圆角
 * @param       radius 圆角半径
 * @returned    圆角图片
 */
- (UIImage *)pruning:(float)radius;
//
/**
 * 圆形图片
 *
 * @returned  圆形图片
 */
- (UIImage *)imageClipOvalImage;
/**
 * 生成图片的遮罩图片
 * @returned    添加遮罩后的图片
 */
- (UIImage *)maskImage;

/**
 * 图片等比缩放
 * @param       size 缩放的相对大小
 * @returned    缩放后的图片
 */
- (UIImage*)zoom:(CGSize)size;

/**
 * 图片裁剪
 * @param       size 裁剪后图片大小
 * @param       rect 裁剪区域
 * @returned    裁剪后的图片
 */
- (UIImage*)trim:(CGSize)size inRect:(CGRect)rect;

/**
 * 图片玻璃效果
 * @param       radius圆角
 * @param       iterations阴影长度
 * @param       tintColor模糊效果颜色
 * @returned    玻璃效果处理后的图片
 */
- (UIImage *)blurredWithRadius:(CGFloat)radius
                    iterations:(NSUInteger)iterations
                     tintColor:(UIColor *)tintColor;

/**
 * 图片圆角
 * @param       处理图片
 * @returned    转正后的图片
 */
- (UIImage *)fixOrientation;


//自动拉伸图片
+ (UIImage *)resizedImage:(NSString *)imageName;

/**
 * 图片颜色处理
 * @param       图片变色
 * @param       type 颜色类型
 * @returned    转正后的图片
 */
-(UIImage*)imageColorChangeWithType:(ImageColorStyle)type;


@end

@interface UITabBarItem (category)

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(UIImage *)image
                selectedImage:(UIImage *)selectedImage;

@end
