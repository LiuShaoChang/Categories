//
//  UIView+NoDataLabel.m
//  YjyxParent
//
//  Created by Yun Chen on 2017/4/24.
//  Copyright © 2017年 YJYX. All rights reserved.
//

#import "UIView+NoDataLabel.h"

@implementation UIView (NoDataLabel)

static NSInteger kTagNoDataLabel = 948748216;

- (void)addNoDataLabelWithText:(NSString *)text {
    UILabel *noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 25)];
    noDataLabel.text = text;
    noDataLabel.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.37);
    noDataLabel.tag = kTagNoDataLabel;
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:noDataLabel];
}

- (void)removeNoDataLabel {
    UILabel *noDataLabel = [self viewWithTag:kTagNoDataLabel];
    if (noDataLabel != nil) {
        [noDataLabel removeNoDataLabel];
    }
}

@end
