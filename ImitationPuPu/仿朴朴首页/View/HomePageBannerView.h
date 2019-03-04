//
//  HomePageBannerView.h
//  168LiCaiWang
//
//  Created by 陈经风 on 2018/8/15.
//  Copyright © 2018年 168LiCaiWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomePageBannerViewDelegate <NSObject>

- (void)homePageBannerViewDidSelectedAtIndex:(NSInteger)index;

@end
@interface HomePageBannerView : UIView
//- (void)reloadImageGroup;

// 数据源
@property (nonatomic, strong) NSArray *imageURLStringsGroup;

// 滚动控制接口

@property (nonatomic, weak) id<HomePageBannerViewDelegate> delegate;

// 占位图，用于网络未加载到图片时
@property (nonatomic, strong) UIImage *placeholderImage;


@end
