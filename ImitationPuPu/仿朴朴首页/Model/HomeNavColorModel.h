//
//  HomeNavColorModel.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/2.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeNavColorModel : NSObject
@property(nonatomic,strong) UIColor *textColor;
@property(nonatomic,strong) UIColor *selectedTextColor;
@property(nonatomic,strong) UIColor *backGroundColor;

-(instancetype)initWithTextColor:(UIColor*)textColor selectedTextColor:(UIColor*)selectedTextColor backGroundColor:(UIColor *)backGroundColor;
@end

NS_ASSUME_NONNULL_END
