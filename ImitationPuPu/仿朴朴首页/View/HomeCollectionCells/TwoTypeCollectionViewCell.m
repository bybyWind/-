//
//  TwoTypeCollectionViewCell.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "TwoTypeCollectionViewCell.h"
#define kGradientDistance (40)
@interface TwoTypeCollectionViewCell  ()<UITableViewDelegate,UITableViewDataSource>{
    scrollViewDidScrollBlock _scrollViewDidScrollBlock;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation TwoTypeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self tableView];
    }
    return self;
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    [self updatedTableViewFrameWhenNavViewYChange:self.weakHomeNavView.frame.origin.y];
}
- (void)dealloc
{
    [_weakHomeNavView removeObserver:self forKeyPath:@"frame" context:nil];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = kRandomColor;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY =  scrollView.contentOffset.y;
    if (offsetY>=0){
        if (offsetY>kGradientDistance) {
            offsetY = kGradientDistance;
            CGFloat percentageScale = 0;
            if (self.tableView.frame.size.height == (WINDOW_HEIGHT-kNAVViewHeight)+kNAVViewOffsetY) {
                return;
            }
            //减少重复设置和解决拖动太快，坐标没有更改的情形
            if (_scrollViewDidScrollBlock) {
                _scrollViewDidScrollBlock(scrollViewScrollUp,percentageScale);
            }
            CGRect frame = self.tableView.frame;
            self.tableView.frame = CGRectMake(0, kNAVViewHeight-kNAVViewOffsetY, frame.size.width, (WINDOW_HEIGHT-kNAVViewHeight)+kNAVViewOffsetY);
            
        }else{
            CGFloat percentageScale = 1-(offsetY)/kGradientDistance;
            if (_scrollViewDidScrollBlock) {
                _scrollViewDidScrollBlock(scrollViewScrollUp,percentageScale);
            }
            CGRect frame = self.tableView.frame;
            self.tableView.frame = CGRectMake(0, kNAVViewHeight-kNAVViewOffsetY*(1-percentageScale), frame.size.width, (WINDOW_HEIGHT-kNAVViewHeight)+kNAVViewOffsetY*(1-percentageScale));
        }
       
        
    }else if (offsetY<0){
        if (self.tableView.frame.origin.y == kNAVViewHeight) {
            return;
        }
        //减少重复设置和解决拖动太快，坐标没有更改的情形
        CGFloat percentageScale = 1;
        if (_scrollViewDidScrollBlock) {
            _scrollViewDidScrollBlock(scrollViewScrollUp,percentageScale);
        }
        CGRect frame = self.tableView.frame;
       
        self.tableView.frame = CGRectMake(0, kNAVViewHeight, frame.size.width, (WINDOW_HEIGHT-kNAVViewHeight));
    }
    
}


#pragma mark - public
/**
 当其他页面改变navViewheight时，更新tableView的y
 navViewY -(kNAVViewOffsetY)~0
 */
-(void)updatedTableViewFrameWhenNavViewYChange:(CGFloat)navViewY{
    CGRect frame = self.tableView.frame;
    if (frame.size.height == ((WINDOW_HEIGHT-kNAVViewHeight)-navViewY)) {
        return;
    }
    self.tableView.frame = CGRectMake(0, kNAVViewHeight+navViewY, frame.size.width, (WINDOW_HEIGHT-kNAVViewHeight)-navViewY);
   
}

#pragma mark - setter
-(void)setScrollViewDidScrollBlock:(scrollViewDidScrollBlock)scrollViewDidScrollBlock{
    _scrollViewDidScrollBlock = scrollViewDidScrollBlock;
}
-(void)setWeakHomeNavView:(UIView *)weakHomeNavView{
    _weakHomeNavView = weakHomeNavView;
    [_weakHomeNavView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNAVViewHeight, WINDOW_WIDTH,WINDOW_HEIGHT-kNAVViewHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView .contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self addSubview:_tableView];
    }
    return _tableView;
}
@end
