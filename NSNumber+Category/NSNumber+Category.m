//
//  NSNumber+Category.m
//  YjyxParent
//
//  Created by 刘少昌 on 2018/6/12.
//  Copyright © 2018年 YJYX. All rights reserved.
//

#import "NSNumber+Category.h"

@implementation NSNumber (Category)

- (NSString *)numString {
    
    NSString *string;
    if (self.integerValue < 10000) {
        string = [NSString stringWithFormat:@"%@", self];
    }else {
        string = [NSString stringWithFormat:@"%.1f万",self.floatValue/10000];
    }
    
    return string;
}

/** 消息数显示，大于99时99+ */
- (NSString *)messageCountString {
    NSString *string;
    if (self.integerValue <= 99) {
        string = [NSString stringWithFormat:@"%@", self];
    }else {
        string = @"99+";
    }
    
    return string;
}

/** double类型精度处理 */
- (NSString *)dl_description {
    //double（CGFloat）数字转换成NSString的最高长度为16
    //当其转换的长度为16时，可能遇到需求情况
    if (self.description.length >= 16) {
        return @([self floatValue]).description;
    }
    return self.description;
}


@end
