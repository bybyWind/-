//
//  HomeNavColorModel.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/2.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "HomeNavColorModel.h"

@implementation HomeNavColorModel
-(instancetype)initWithTextColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor *)backGroundColor{
    if (self = [super init]) {
        self.backGroundColor =backGroundColor;
        self.textColor = textColor;
        self.selectedTextColor = selectedTextColor;
    }
    return self;
}


@end
