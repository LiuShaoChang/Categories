//
//  NSNumber+Category.h
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/12.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Category)

/* 数据过万时，以万为单位显示 */
- (NSString *)numString;

/** 消息数显示，大于99时99+ */
- (NSString *)messageCountString;

/** double类型精度处理 */
- (NSString *)dl_description;

@end
