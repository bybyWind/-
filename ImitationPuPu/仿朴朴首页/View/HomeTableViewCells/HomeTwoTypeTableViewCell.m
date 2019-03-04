//
//  HomeTwoTypeTableViewCell.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/4.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "HomeTwoTypeTableViewCell.h"
#import "HomeOneSubOneColCell.h"
#define kCellWidth (135)
@interface HomeTwoTypeTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
}
@property(nonatomic,strong)NSMutableArray * btnAndTextViewArray;
@property(nonatomic,strong)UILabel *titleLabel;//标题
@property(nonatomic,strong)UIButton *moreButton;//更多按钮
@property(nonatomic,strong)UIView *lineView;//横线

@property(nonatomic,strong)UICollectionView *collectionView;

@end
@implementation HomeTwoTypeTableViewCell


- (void)setDataSourceDic:(NSDictionary *)dataSourceDic{
    _dataSourceDic = dataSourceDic;
    self.backgroundColor = kLineGrayColor;
    NSString *titleString = dataSourceDic[@"title"];
    self.titleLabel.text = [NSString stringWithFormat:@"\t%@",titleString];
    [self moreButton];
    [self lineView];
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *dataSource = self.dataSourceDic[@"dataArray"];
   
    return dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        HomeOneSubOneColCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeOneSubOneColCell" forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
    
        return cell;
    
    
}


#pragma mark - event
-(void)moreButtonClick{
    
}

#pragma mark - getter

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.frame = CGRectMake(0, 0, WINDOW_WIDTH, 44);
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UIButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.frame = CGRectMake(WINDOW_WIDTH-70, 0, 70, 44);
        [self addSubview:_moreButton];
    }
    return _moreButton;
}

#pragma mark - getter
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(kCellWidth, self.bounds.size.height-CGRectGetMaxY(self.lineView.frame)-10*ScaleHeight);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 1;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 1;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 1, 0, 1);
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lineView.frame), WINDOW_WIDTH, self.bounds.size.height-CGRectGetMaxY(self.lineView.frame)-10*ScaleHeight) collectionViewLayout:flowLayout];
        if (@available(iOS 11.0, *)) {
            collectionView .contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        collectionView.backgroundColor = kLineGrayColor;
        
        collectionView.bounces = NO;
        
        collectionView.delegate = self;
        
        collectionView.dataSource = self;
    
        collectionView.showsHorizontalScrollIndicator = NO;
        [collectionView registerNib:[UINib nibWithNibName:@"HomeOneSubOneColCell" bundle:nil] forCellWithReuseIdentifier:@"HomeOneSubOneColCell"];
        [self addSubview:collectionView];
        
        _collectionView = collectionView;
        
    }
    return _collectionView;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, WINDOW_WIDTH, 1)];
        _lineView.backgroundColor = kLineGrayColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}
@end
