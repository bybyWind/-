//
//  TwoTypeCollectionViewCell.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 滑动回调
 */
typedef void(^scrollViewDidScrollBlock)(scrollViewScrollState state,CGFloat percentageScale);
@interface TwoTypeCollectionViewCell : UICollectionViewCell

@property(weak,nonatomic)UIView *weakHomeNavView;
-(void)setScrollViewDidScrollBlock:(scrollViewDidScrollBlock)scrollViewDidScrollBlock;

///**
// 当其他页面改变navViewheight时，更新tableView的y
// */
-(void)updatedTableViewFrameWhenNavViewYChange:(CGFloat)navViewY;
@end

NS_ASSUME_NONNULL_END
