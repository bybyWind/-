//
//  OneTypeCollectionCellModel.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/3.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneTypeCollectionCellModel : NSObject
@property(nonatomic,strong)NSMutableArray *oneCellDatasource;//第一栏分类数据源
@property(nonatomic,assign)BOOL oneCellIsExpend;//第一栏分类扩展
@property(nonatomic,strong)NSMutableArray *twoCellDatasource;//第二栏分类数据源
@property(nonatomic,strong)NSDictionary *threeCellDic;//第三栏分类数据源
@property(nonatomic,strong)NSDictionary *fourCellDic;//第四栏分类数据源
@property(nonatomic,strong)NSDictionary *fiveCellDic;//第五栏分类数据源
@end

NS_ASSUME_NONNULL_END
