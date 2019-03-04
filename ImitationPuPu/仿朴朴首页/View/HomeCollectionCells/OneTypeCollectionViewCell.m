//
//  OneTypeCollectionViewCell.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "OneTypeCollectionViewCell.h"
#import "HomePageBannerView.h"
#import "HomeOneTypeTableViewCell.h"
#import "OneTypeCollectionCellModel.h"
#import "HomeTwoTypeTableViewCell.h"
#import "HomeThreeTypeTableViewCell.h"
#import "HomeFourTypeTableViewCell.h"
#define kGradientDistance (40)
@interface OneTypeCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>{
    scrollViewDidScrollBlock _scrollViewDidScrollBlock;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)HomePageBannerView *tableHeaderView;
@property(nonatomic,strong)OneTypeCollectionCellModel * dataModel;

@end

@implementation OneTypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self tableView];
    }
    return self;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        HomeOneTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeOneTypeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataSource:self.dataModel.twoCellDatasource];
        [cell setIsExpend:self.dataModel.oneCellIsExpend];
        __weak typeof(self)weakSelf = self;
        [cell setHomeOneTypeTableViewCellExpendButtonClick:^(BOOL isExpend) {
            if (isExpend != weakSelf.dataModel.oneCellIsExpend) {
                weakSelf.dataModel.oneCellIsExpend = isExpend;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        
        return cell;
    }else if (indexPath.row == 1){
        HomeTwoTypeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HomeTwoTypeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataSourceDic:self.dataModel.threeCellDic];
        return cell;
    }else if (indexPath.row == 2){
        HomeThreeTypeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HomeThreeTypeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 3){
        HomeFourTypeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"HomeFourTypeTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setDataSourceDic:self.dataModel.fiveCellDic];
        return cell;
    }else{
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.dataModel.oneCellIsExpend) {
            return (270+10)*ScaleHeight;
        }else{
            return (180+10)*ScaleHeight;
        }
    }else if (indexPath.row == 1){
        return (260)+10*ScaleHeight;
    }else if (indexPath.row == 2){
        return (225)+10;
    }else if (indexPath.row == 3){
        return (225)+10;
    }else{
          return 300*ScaleHeight;
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY =  scrollView.contentOffset.y;
    if (offsetY<0 &&offsetY>=-kGradientDistance) {
        CGFloat percentageScale = 1+(offsetY)/kGradientDistance;

        if (_scrollViewDidScrollBlock) {
            _scrollViewDidScrollBlock(scrollViewPullDown,percentageScale);
        }
    }else if (offsetY>=0){
        CGFloat percentageScale = 1-(offsetY)/kGradientDistance;
        if (percentageScale<0) {
            percentageScale =0;
        }
        if (_scrollViewDidScrollBlock) {
            _scrollViewDidScrollBlock(scrollViewScrollUp,percentageScale);
        }
    }
    
}

#pragma mark - setter
-(void)setScrollViewDidScrollBlock:(scrollViewDidScrollBlock)scrollViewDidScrollBlock{
    _scrollViewDidScrollBlock = scrollViewDidScrollBlock;
}

#pragma mark - getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH,WINDOW_HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.tableHeaderView;
        if (@available(iOS 11.0, *)) {
            _tableView .contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
       
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [_tableView registerClass:[HomeOneTypeTableViewCell class] forCellReuseIdentifier:@"HomeOneTypeTableViewCell"];
        [_tableView registerClass:[HomeTwoTypeTableViewCell class] forCellReuseIdentifier:@"HomeTwoTypeTableViewCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"HomeThreeTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeThreeTypeTableViewCell"];
         [_tableView registerNib:[UINib nibWithNibName:@"HomeFourTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeFourTypeTableViewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self addSubview:_tableView];
    }
    return _tableView;
}
-(HomePageBannerView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView = [[HomePageBannerView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 300)];
        _tableHeaderView.imageURLStringsGroup = self.dataModel.oneCellDatasource;
    }
    return _tableHeaderView;
}
-(OneTypeCollectionCellModel *)dataModel{
    if (!_dataModel) {
        _dataModel = [[OneTypeCollectionCellModel alloc] init];
    }
    return _dataModel;
}

@end
