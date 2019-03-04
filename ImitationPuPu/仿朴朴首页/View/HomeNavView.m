//
//  HomeNavView.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "HomeNavView.h"
#import "HomeNavColorModel.h"

#define kButtonTag (1000)
#define kSPACE (10)
#define kButtonWidth (70)
@interface HomeNavView (){
    NSInteger _selectedIndex;//滑动选中的index
    selectedButtonClickedReturnBlock _selectedButtonClickedReturnBlock;
    navBottomSliderTinColor _navBottomSliderTinColor;
}

@property(nonatomic,strong)UIScrollView *sliderView;
/** 滑动底标线条*/
@property (nonatomic, strong) UIView *bottomLine;

@property(nonatomic,strong)NSMutableArray * btnSource;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIButton *searchButton;
@property(nonatomic,strong)HomeNavColorModel *recommendedColorModel;//存储推荐页nav的颜色
@property(nonatomic,strong)HomeNavColorModel *otherColorModel;//其他页nav的颜色

@end

@implementation HomeNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = self.recommendedColorModel.backGroundColor;
        [self addressLabel];
        [self searchButton];
    }
    return self;
}


#pragma mark - public
/**
 推荐页上拉改变nav颜色渐变 和 部分文字按钮的隐藏
 
 @param percentageScale 渐变比例 (1-0)
 */
-(void)recommendedChangeTinColorWithPercentageScale:(CGFloat)percentageScale{
    static CGFloat oldPercentageScale = 1000;
    if (oldPercentageScale == percentageScale) {
        return;
    }
    oldPercentageScale = percentageScale;
    //白色225 255 255  灰色 192 192 192  黑色 0 0 0 绿色 0 252 0
    UIColor *backGroundColor = RGBACOLOR(255, 255, 255, 1-percentageScale);
    self.backgroundColor = backGroundColor;
   
    //白<->绿
    UIColor *selectedTextColor = RGBACOLOR(((255-0)*percentageScale+0), ((255-252)*percentageScale+252), ((255-0)*percentageScale+0), 1);
    //白<->黑
    UIColor *textColor = RGBACOLOR((255*percentageScale), (255*percentageScale),(255*percentageScale), 1);
    
    for (int i = 0; i<self.btnSource.count; i++) {
        UIButton *btn = self.btnSource[i];
        if (i == _selectedIndex) {
            [btn setTitleColor:selectedTextColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:textColor forState:UIControlStateNormal];
        }
    }
     self.bottomLine.backgroundColor = selectedTextColor;
     self.recommendedColorModel.backGroundColor = backGroundColor;
     self.recommendedColorModel.textColor = textColor;
     self.recommendedColorModel.selectedTextColor = selectedTextColor;
    
}
/**
 下拉更改address的hide
 
 @param percentageScale
 */
-(void)pullDownAddressLabelHideWithPercentageScale:(CGFloat)percentageScale{
    if (self.addressLabel.alpha == percentageScale) {
        return;
    }
    self.addressLabel.alpha = percentageScale;
}


/**
 选项卡修改主题色
 */
-(void)changeBottomSliderTincolor:(navBottomSliderTinColor)tinColor{
    
    if (_navBottomSliderTinColor == tinColor) {
        return;
    }
    _navBottomSliderTinColor  = tinColor;
    if (tinColor ==RecommendedTinColor) {
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundColor = self.recommendedColorModel.backGroundColor;
            self.addressLabel.textColor = self.recommendedColorModel.textColor;
            self.bottomLine.backgroundColor = self.recommendedColorModel.selectedTextColor;
            for (int i = 0; i<self.btnSource.count; i++) {
                UIButton *btn = self.btnSource[i];
                if (i == self->_selectedIndex) {
                    [btn setTitleColor:self.recommendedColorModel.selectedTextColor forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:self.recommendedColorModel.textColor forState:UIControlStateNormal];
                }
            }
        }];
    }else if (tinColor ==OtherTinColor){
        [UIView animateWithDuration:0.1 animations:^{
            self.backgroundColor = self.otherColorModel.backGroundColor;
            for (int i = 0; i<self.btnSource.count; i++) {
                UIButton *btn = self.btnSource[i];
                if ( self->_selectedIndex == i) {
                    [btn setTitleColor:self.otherColorModel.selectedTextColor forState:UIControlStateNormal];
                }else{
                    [btn setTitleColor:self.otherColorModel.textColor forState:UIControlStateNormal];
                }
            }
            self.addressLabel.textColor = self.otherColorModel.textColor;
            self.bottomLine.backgroundColor = self.otherColorModel.selectedTextColor;
        }];
    }

}

/**
 *  设置选项卡底部滑动的坐标
 */
- (void)setBottomSliderFrameToIndex:(NSInteger)index{
    [self __setBottomSliderToFrameWithIndex:index];
}
/**
 *  设置选项卡颜色
 */
- (void)setBottomSliderColorWithIndex:(NSInteger)index{
    [self __setSelectedButtonsIndex:index];
     _selectedIndex = index;
}
#pragma mark - private
/**
 *  设置选项卡底部滑动的坐标
 */
- (void)__setBottomSliderToFrameWithIndex:(NSInteger)index{
   
    static NSInteger oldIndex = 1000;
    if (oldIndex == index) {
        return;
    }
    oldIndex = index;
    //修改滑动条位置和让按钮尽量居中
    CGRect oldBottomLineFrame = self.bottomLine.frame;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.frame = CGRectMake(index*kButtonWidth+2, oldBottomLineFrame.origin.y, oldBottomLineFrame.size.width, oldBottomLineFrame.size.height);
    }];
    CGFloat distance  =index*kButtonWidth-self.sliderView.contentOffset.x;
    CGFloat spaceX =  distance-(self.sliderView.frame.size.width-kButtonWidth)/2;
    CGFloat contentOffsetX = self.sliderView.contentOffset.x+spaceX;
    if (contentOffsetX<0) {
        contentOffsetX = 0;
    }else if (contentOffsetX>(self.sliderView.contentSize.width-self.sliderView.frame.size.width)){
        contentOffsetX =(self.sliderView.contentSize.width-self.sliderView.frame.size.width);
    }
    [self.sliderView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];
    
}
/**
 *  设置选项卡被选中的颜色
 */
- (void)__setSelectedButtonsIndex:(NSInteger)index{
    if (_selectedIndex == index) {
        return;
    }
    
    if (_navBottomSliderTinColor == RecommendedTinColor) {
        //修改按钮颜色
        UIButton *oldBtn = self.btnSource[_selectedIndex];
        [oldBtn setTitleColor:self.recommendedColorModel.textColor forState:UIControlStateNormal];
        UIButton *newBtn = self.btnSource[index];
        [newBtn setTitleColor:self.recommendedColorModel.selectedTextColor forState:UIControlStateNormal];
    }else  if (_navBottomSliderTinColor == OtherTinColor) {
        //修改按钮颜色
        UIButton *oldBtn = self.btnSource[_selectedIndex];
        [oldBtn setTitleColor:self.otherColorModel.textColor forState:UIControlStateNormal];
        UIButton *newBtn = self.btnSource[index];
        [newBtn setTitleColor:self.otherColorModel.selectedTextColor forState:UIControlStateNormal];
    }
    
   

}

#pragma mark - event
/**
 选项卡点击事件
 */
-(void)sliderButtonClick:(UIButton *)btn{
    
    NSInteger selected = btn.tag-kButtonTag;
    if (_selectedIndex == selected) {
        return;
    }
    [self __setBottomSliderToFrameWithIndex:selected];
    [self __setSelectedButtonsIndex:selected];
    _selectedIndex = selected;
    
    if (_selectedButtonClickedReturnBlock) {
        _selectedButtonClickedReturnBlock(selected);
    }
}
#pragma mark - setter
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    self.sliderView.contentSize = CGSizeMake(titles.count*kButtonWidth, 0);
    if (self.btnSource.count>0) {
        [self.btnSource removeAllObjects];
    }
    _selectedIndex = 0;
    for (int i = 0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+kButtonTag;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.frame = CGRectMake(i*kButtonWidth, 0, kButtonWidth, self.sliderView.frame.size.height);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (i == _selectedIndex) {
            [btn setTitleColor:self.recommendedColorModel.selectedTextColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:self.recommendedColorModel.textColor forState:UIControlStateNormal];
        }
        
        [btn addTarget:self action:@selector(sliderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.sliderView addSubview:btn];
        [self.btnSource addObject:btn];
    }
    [self bottomLine];
}

-(void)setSelectedButtonClickedReturnBlock:(selectedButtonClickedReturnBlock)selectedButtonClickedReturnBlock{
    _selectedButtonClickedReturnBlock = selectedButtonClickedReturnBlock;
}
#pragma mark - getter
-(UIScrollView  *)sliderView{
    if (!_sliderView) {
        _sliderView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width, 40)];
        _sliderView.showsHorizontalScrollIndicator = NO;
        _sliderView.backgroundColor = [UIColor clearColor];
        [self addSubview:_sliderView];
    }
    return _sliderView;
}
-(NSMutableArray *)btnSource{
    if (!_btnSource) {
        _btnSource = [NSMutableArray array];
    }
    return _btnSource;
}
-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSPACE, statusBarH, 100, 25)];
        _addressLabel.text = @"朝阳区";
        _addressLabel.textColor = [UIColor whiteColor];
        [self addSubview:_addressLabel];
    }
    return _addressLabel;
}
-(UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.backgroundColor = [UIColor whiteColor];
        [_searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _searchButton.frame =CGRectMake(kSPACE, CGRectGetMaxY(self.addressLabel.frame)+8, self.bounds.size.width-kSPACE*2, 30);
        [_searchButton setTitle:@"1元起送，30分钟送达" forState:UIControlStateNormal];
        [self addSubview:_searchButton];
    }
    return _searchButton;
}
-(HomeNavColorModel *)recommendedColorModel{
    if (!_recommendedColorModel) {
        
        _recommendedColorModel = [[HomeNavColorModel alloc] initWithTextColor:[UIColor whiteColor] selectedTextColor:[UIColor whiteColor] backGroundColor:RGBACOLOR(255, 255, 255, 0)];
    }
    return _recommendedColorModel;
}
-(HomeNavColorModel *)otherColorModel{
    if (!_otherColorModel) {
        
        _otherColorModel = [[HomeNavColorModel alloc] initWithTextColor:[UIColor blackColor] selectedTextColor:RGBACOLOR(0, 252, 0, 1) backGroundColor:RGBACOLOR(255, 255, 255, 1)];
    }
    return _otherColorModel;
}

-(UIView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0*kButtonWidth+2, self.sliderView.frame.size.height - 2, kButtonWidth-4, 2)];
        _bottomLine.backgroundColor = self.recommendedColorModel.selectedTextColor;
        [self.sliderView addSubview:_bottomLine];
    }
    return _bottomLine;
}
@end
