//
//  HomeNavView.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RecommendedTinColor,//推荐页色调
    OtherTinColor,//其他页色调
} navBottomSliderTinColor;

typedef void (^selectedButtonClickedReturnBlock)(NSInteger index);
@interface HomeNavView : UIView
@property(nonatomic,strong)NSArray *titles;
-(void)setSelectedButtonClickedReturnBlock:(selectedButtonClickedReturnBlock)selectedButtonClickedReturnBlock;


/**
 推荐页上拉改变nav颜色渐变 和 部分文字按钮的隐藏
 @param percentageScale 渐变比例 (1-0)
 */
-(void)recommendedChangeTinColorWithPercentageScale:(CGFloat)percentageScale;
/**
 下拉更改address的hide
 @param percentageScale 渐变比例1-0
 */
-(void)pullDownAddressLabelHideWithPercentageScale:(CGFloat)percentageScale;

/**
 选项卡修改主题色
 */
-(void)changeBottomSliderTincolor:(navBottomSliderTinColor)tinColor;
/**
 *  设置选项卡底部滑动的坐标
 */
- (void)setBottomSliderFrameToIndex:(NSInteger)index;

/**
 *  设置选项卡颜色
 */
- (void)setBottomSliderColorWithIndex:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
