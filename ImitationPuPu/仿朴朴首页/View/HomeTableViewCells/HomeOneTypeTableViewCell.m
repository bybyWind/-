//
//  HomeOneTypeTableViewCell.m
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/3.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "HomeOneTypeTableViewCell.h"
#define kButtonTag (8888)
@interface HomeOneTypeTableViewCell (){
    homeOneTypeTableViewCellExpendButtonClick _homeOneTypeTableViewCellExpendButtonClick;
}
@property(nonatomic,strong)NSMutableArray * btnAndTextViewArray;

@property(nonatomic,strong)UIButton *expendButton;//点击扩展按钮

@property(nonatomic,strong)UIButton *packUpButton;//点击收起按钮
@end

@implementation HomeOneTypeTableViewCell


- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
     self.backgroundColor = kLineGrayColor;
    if (self.btnAndTextViewArray.count!= 0) {
        return;
    }
    
    CGFloat viewWidth =  WINDOW_WIDTH/5;
    CGFloat viewHeight =  90*ScaleHeight;
    for (int i = 0; i<dataSource.count; i++) {
        UIView *v = [[UIView alloc] init];
        v.frame = CGRectMake(i%5*viewWidth, i/5*viewHeight, viewWidth, viewHeight);
        v.backgroundColor = [UIColor whiteColor];
        [self addSubview:v];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"pupu"] forState:UIControlStateNormal];
        btn.frame =CGRectMake((viewWidth-45*ScaleWidth)/2, (viewHeight-65*ScaleWidth)/2, 45*ScaleWidth, 45*ScaleWidth);
        btn.tag = i+kButtonTag;
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [v addSubview:btn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(btn.frame)+8, viewWidth, 10)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.text = self.dataSource[i];
        [v addSubview:label];
        
        if (i>9) {
            v.hidden = YES;
        }
        [self.btnAndTextViewArray addObject:v];
    }
    
    //下拉按钮
    self.expendButton.frame = CGRectMake(0, 0, 50, 15);
    self.expendButton.center = CGPointMake(WINDOW_WIDTH/2, 175*ScaleHeight);
    
}

- (void)setIsExpend:(BOOL)isExpend{
    
    if (_isExpend == isExpend) {
        return;
    }
    _isExpend = isExpend;
    
    if (_isExpend) {
        //扩展
        self.expendButton.hidden = YES;
        self.packUpButton.hidden = NO;
        for (int i = 10; i<self.btnAndTextViewArray.count; i++) {
            UIView *v = self.btnAndTextViewArray[i];
            v.hidden = NO;
        }
    }else{
        //收起
        self.expendButton.hidden = NO;
        self.packUpButton.hidden = YES;
        for (int i = 10; i<self.btnAndTextViewArray.count; i++) {
            UIView *v = self.btnAndTextViewArray[i];
            v.hidden = YES;
        }
    }
    
    
}

#pragma mark - event
-(void)buttonClick:(UIButton *)btn{
    NSLog(@"图标点击");
}

-(void)expendButtonClick{
    if (_homeOneTypeTableViewCellExpendButtonClick) {
        _homeOneTypeTableViewCellExpendButtonClick(YES);
    }
}
-(void)packUpButtonClick{
    if (_homeOneTypeTableViewCellExpendButtonClick) {
        _homeOneTypeTableViewCellExpendButtonClick(NO);
    }
}
#pragma mark - setter
-(void)setHomeOneTypeTableViewCellExpendButtonClick:(homeOneTypeTableViewCellExpendButtonClick)homeOneTypeTableViewCellExpendButtonClick{
    _homeOneTypeTableViewCellExpendButtonClick = homeOneTypeTableViewCellExpendButtonClick;
}

#pragma mark - getter

-(NSMutableArray *)btnAndTextViewArray{
    if (!_btnAndTextViewArray) {
        _btnAndTextViewArray = [NSMutableArray array];
    }
    return _btnAndTextViewArray;
}

-(UIButton *)expendButton{
    if (!_expendButton) {
        _expendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expendButton setTitle:@"扩展" forState:UIControlStateNormal];
        [_expendButton setImage:[UIImage imageNamed:@"bbs_arrow_down"] forState:UIControlStateNormal];
        _expendButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_expendButton setBackgroundColor:[UIColor whiteColor]];
        [_expendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_expendButton addTarget:self action:@selector(expendButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_expendButton];
    }
    return _expendButton;
}
-(UIButton *)packUpButton{
    if (!_packUpButton) {
        _packUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_packUpButton setTitle:@"收起" forState:UIControlStateNormal];
        [_packUpButton setImage:[UIImage imageNamed:@"bbs_arrow_up"] forState:UIControlStateNormal];
        _packUpButton.titleLabel.font = [UIFont systemFontOfSize:11];
        [_packUpButton setBackgroundColor:[UIColor whiteColor]];
        [_packUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_packUpButton addTarget:self action:@selector(packUpButtonClick) forControlEvents:UIControlEventTouchUpInside];
        //下拉按钮
        _packUpButton.frame = CGRectMake(0, 0, 50, 15);
        _packUpButton.center = CGPointMake(WINDOW_WIDTH/2, 265*ScaleHeight);
        [self addSubview:_packUpButton];
    }
    return _packUpButton;
}

@end
