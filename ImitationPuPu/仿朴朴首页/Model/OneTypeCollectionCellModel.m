//
//  OneTypeCollectionCellModel.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/3.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "OneTypeCollectionCellModel.h"

@implementation OneTypeCollectionCellModel

-(NSMutableArray *)oneCellDatasource{
    if (!_oneCellDatasource) {
        _oneCellDatasource = [NSMutableArray array];
        [_oneCellDatasource addObjectsFromArray:@[
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551461508610&di=041dfad4667422660892da2f472f83c6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FtSTfQAJZJzHldsA9J4FFDw%3D%3D%2F58546795256017528.jpg",
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551461508610&di=041dfad4667422660892da2f472f83c6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FtSTfQAJZJzHldsA9J4FFDw%3D%3D%2F58546795256017528.jpg",
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551461508610&di=041dfad4667422660892da2f472f83c6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FtSTfQAJZJzHldsA9J4FFDw%3D%3D%2F58546795256017528.jpg",
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551461508610&di=041dfad4667422660892da2f472f83c6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FtSTfQAJZJzHldsA9J4FFDw%3D%3D%2F58546795256017528.jpg",
                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1551461508610&di=041dfad4667422660892da2f472f83c6&imgtype=0&src=http%3A%2F%2Fimg1.ph.126.net%2FtSTfQAJZJzHldsA9J4FFDw%3D%3D%2F58546795256017528.jpg"]];
    }
    return _oneCellDatasource;
}
-(NSMutableArray *)twoCellDatasource{
    if (!_twoCellDatasource) {
        _twoCellDatasource = [NSMutableArray array];
        [_twoCellDatasource addObjectsFromArray:@[@"水 果",@"蔬 菜",@"肉质蛋品",@"海鲜水产",@"粮油调味",@"熟食卤味",@"牛奶面包",@"酒水冲饮",@"面点火锅",@"休闲零食",@"日用清洁",@"护理美妆",@"进口商品",@"鲜花礼品",@"全部分类"]];
    }
    return _twoCellDatasource;
}
-(NSDictionary *)threeCellDic{
    if (!_threeCellDic) {
        _threeCellDic = @{@"title":@"掌柜推荐",
                          @"dataArray":@[@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标"]
                          };
    }
    return _threeCellDic;
}

-(NSDictionary *)fiveCellDic{
    if (!_fiveCellDic) {
        _fiveCellDic = @{@"countDownTime":@"33333",
                         @"dataArray":@[@"朴朴商标",@"朴朴商标",@"朴朴商标",@"朴朴商标"]
                          };
    }
    return _fiveCellDic;
}
@end
