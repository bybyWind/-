//
//  ViewController.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "ViewController.h"
#import "HomeNavView.h"
#import "OneTypeCollectionViewCell.h"
#import "TwoTypeCollectionViewCell.h"
#import "HomeHorizontalCollectionViewLayout.h"

static NSString * oneTypeCellID = @"oneTypeCellID";
static NSString * twoTypeCellID = @"twoTypeCellID";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    BOOL _isDragging;//是否是手动拖动
}
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)HomeNavView *homeNavView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];

}

-(void)initUI{
    [self collectionView];
    [self homeNavView];
    [self.homeNavView setTitles:self.dataSource];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        OneTypeCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:oneTypeCellID forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        [cell setScrollViewDidScrollBlock:^(scrollViewScrollState state, CGFloat percentageScale) {
            if (state == scrollViewPullDown) {
                if (weakSelf.homeNavView.alpha != percentageScale) {
                     weakSelf.homeNavView.alpha = percentageScale;
                }
               
                [weakSelf.homeNavView recommendedChangeTinColorWithPercentageScale:1];
                [weakSelf changeNavViewYWithPercentageScale:1];
                [weakSelf.homeNavView pullDownAddressLabelHideWithPercentageScale:1];
            }else if (state == scrollViewScrollUp) {
                if (weakSelf.homeNavView.alpha != 1) {
                    weakSelf.homeNavView.alpha = 1;
                }
                [weakSelf.homeNavView recommendedChangeTinColorWithPercentageScale:percentageScale];
                [weakSelf changeNavViewYWithPercentageScale:percentageScale];
                [weakSelf.homeNavView pullDownAddressLabelHideWithPercentageScale:percentageScale];
            }

        }];
         return cell;
    }else{
        TwoTypeCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:twoTypeCellID forIndexPath:indexPath];
         __weak typeof(self) weakSelf = self;
        [cell updatedTableViewFrameWhenNavViewYChange:self.homeNavView.frame.origin.y];
        cell.weakHomeNavView = self.homeNavView;
        [cell setScrollViewDidScrollBlock:^(scrollViewScrollState state, CGFloat percentageScale) {
            if (state == scrollViewScrollUp) {
                [weakSelf changeNavViewYWithPercentageScale:percentageScale];
                [weakSelf.homeNavView pullDownAddressLabelHideWithPercentageScale:percentageScale];
            }
        }];
        return cell;
    }

}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.collectionView) {
        if (scrollView.contentOffset.x == 0) {
            [self.homeNavView changeBottomSliderTincolor:RecommendedTinColor];
        }else{
            [self.homeNavView changeBottomSliderTincolor:OtherTinColor];
        }
        if (_isDragging) {
            //选项滑动
            NSInteger index = (NSInteger)(self.collectionView.contentOffset.x / WINDOW_WIDTH+0.5);
            [self.homeNavView setBottomSliderFrameToIndex:index];
        }
       
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isDragging = YES;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat index =  roundf(scrollView.contentOffset.x/WINDOW_WIDTH);
    [self.homeNavView setBottomSliderColorWithIndex:index];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x/WINDOW_WIDTH;
    [self.homeNavView setBottomSliderColorWithIndex:index];
}

#pragma mark - private
/**
 修改nav的坐标
 @param percentageScale 修改比例
 */
-(void)changeNavViewYWithPercentageScale:(CGFloat)percentageScale{
    static CGFloat oldPercentageScale = 1000;
    if (oldPercentageScale == percentageScale) {
        return;
    }
    oldPercentageScale = percentageScale;
    CGRect navViewFrame = self.homeNavView.frame;
    self.homeNavView.frame = CGRectMake(0, -kNAVViewOffsetY*(1-percentageScale), navViewFrame.size.width, navViewFrame.size.height);
}


#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(WINDOW_WIDTH, WINDOW_HEIGHT);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT) collectionViewLayout:flowLayout];
        if (@available(iOS 11.0, *)) {
            collectionView .contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[OneTypeCollectionViewCell class] forCellWithReuseIdentifier:oneTypeCellID];
        [collectionView registerClass:[TwoTypeCollectionViewCell class] forCellWithReuseIdentifier:twoTypeCellID];
        [self.view addSubview:collectionView];
        
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

-(HomeNavView *)homeNavView{
    if (!_homeNavView) {
        _homeNavView  = [[HomeNavView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, kNAVViewHeight)];
        __weak typeof(self) weakSelf = self;
        [_homeNavView setSelectedButtonClickedReturnBlock:^(NSInteger index) {
            self->_isDragging = NO;
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
        }];
        [self.view addSubview:_homeNavView];
    }
    return _homeNavView;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObjectsFromArray:@[@"推荐",@"掌柜推荐",@"限时抢购",@"特价专区",@"人气热卖",@"本周上新",@"水 果",@"蔬 菜",@"肉禽蛋",@"海鲜水产"]];
    }
    return _dataSource;
}

@end
