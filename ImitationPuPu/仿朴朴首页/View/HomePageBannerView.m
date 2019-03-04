//
//  HomePageBannerView.m
//  168LiCaiWang
//
//  Created by 陈经风 on 2018/8/15.
//  Copyright © 2018年 168LiCaiWang. All rights reserved.
//

#import "HomePageBannerView.h"
#import "UIImageView+WebCache.h"

#define kSCROLLVIEWX (0)

#define kBANNERWIDTH (self.bounds.size.width-2*kSCROLLVIEWX) //广告的宽度
#define kBANNERHEIGHT  (self.bounds.size.height)//广告的高度

#define kSCALESPACE (0) //放大缩小的长度比例

static CGFloat const chageImageTime = 3.0; //滚动间隔
static NSInteger currentImage = 1;//记录中间图片的下标,开始总是为1
@interface HomePageBannerView()<UIScrollViewDelegate>{
    BOOL _isTimeUp; //NO表示，手动滑动，要停止计时器。YES表示自动滑动，开启计时器。
    NSTimer *_moveTime;
    CGFloat _lastContentOffX;//上一次滑动的contentOff.x
    NSInteger _whitchMiddle;//标记第几个ImageView在中间
}
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIScrollView *bgScrollView;
@property(nonatomic,strong)NSMutableArray *imageViewArray;
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UIImageView *centerImageView;
@property(nonatomic,strong)UIImageView *rightImgaeView;
@property(nonatomic,strong)UIImageView *beforeLeftImageView;
@property(nonatomic,strong)UIImageView *afterRightImageView;



@end

@implementation HomePageBannerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _lastContentOffX = kBANNERWIDTH*2;
        _whitchMiddle = 2;
        self.backgroundColor = [UIColor whiteColor];
        [self imageViewArray];
        [self bgScrollView];
        
    }
    return self;
}




#pragma mark - scrollViewDelegate
/**
 开始拉

 @param scrollView <#scrollView description#>
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isTimeUp = NO;
    [self cancelTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_lastContentOffX<scrollView.contentOffset.x) {
        //右滑
            UIImageView *centerView = self.imageViewArray[_whitchMiddle];
            UIImageView *leftView = self.imageViewArray[_whitchMiddle-1];
            UIImageView *rightView = self.imageViewArray[_whitchMiddle+1];
            CGRect centerViewFrame = [self convertRect:centerView.frame fromView:centerView.superview];
            CGRect leftViewFrame = [self convertRect:leftView.frame fromView:leftView.superview];
            CGRect rightViewFrame = [self convertRect:rightView.frame fromView:rightView.superview];
            CGFloat centerViewMiddleX =  centerViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat leftViewMiddleX =  leftViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat rightViewMiddleX =  rightViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat centerDistance = fabs(centerViewMiddleX-WINDOW_WIDTH/2);//中线
            CGFloat leftDistance = fabs(leftViewMiddleX-WINDOW_WIDTH/2);//中线
            CGFloat rightDistance = fabs(rightViewMiddleX-WINDOW_WIDTH/2);//中线
            [self adjustImageViewScale:centerView WithScale:centerDistance/kBANNERWIDTH];
            [self adjustImageViewScale:leftView WithScale:leftDistance/kBANNERWIDTH];
            [self adjustImageViewScale:rightView WithScale:rightDistance/kBANNERWIDTH];
    }
    if (_lastContentOffX>scrollView.contentOffset.x) {
        //左滑
            UIImageView *centerView = self.imageViewArray[_whitchMiddle];
            UIImageView *leftView = self.imageViewArray[_whitchMiddle-1];
            UIImageView *rightView = self.imageViewArray[_whitchMiddle+1];
        
            CGRect centerViewFrame = [self convertRect:centerView.frame fromView:centerView.superview];
            CGRect leftViewFrame = [self convertRect:leftView.frame fromView:leftView.superview];
            CGRect rightViewFrame = [self convertRect:rightView.frame fromView:rightView.superview];
            CGFloat centerViewMiddleX =  centerViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat leftViewMiddleX =  leftViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat rightViewMiddleX =  rightViewFrame.origin.x+kBANNERWIDTH/2;
            CGFloat centerDistance = fabs(centerViewMiddleX-WINDOW_WIDTH/2);//中线
            CGFloat leftDistance = fabs(leftViewMiddleX-WINDOW_WIDTH/2);//中线
            CGFloat rightDistance = fabs(rightViewMiddleX-WINDOW_WIDTH/2);//中线
            [self adjustImageViewScale:centerView WithScale:centerDistance/kBANNERWIDTH];
            [self adjustImageViewScale:leftView WithScale:leftDistance/kBANNERWIDTH];
            [self adjustImageViewScale:rightView WithScale:rightDistance/kBANNERWIDTH];
    }
    _lastContentOffX = scrollView.contentOffset.x;

    
    if (scrollView.contentOffset.x>kBANNERWIDTH*3) {
        scrollView.scrollEnabled = NO;
        [self didManualScrollAdjustView];
    }
    if (scrollView.contentOffset.x<kBANNERWIDTH) {
        scrollView.scrollEnabled = NO;
        [self didManualScrollAdjustView];
    }
}
/**
 scrollView结束加速

 @param scrollView <#scrollView description#>
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self didManualScrollAdjustView];
}

/**
 scrollView结束拉动
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0){
    [self didManualScrollAdjustView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //自动滑动动画后 进行自动滑动的界面设置。在automaticScroll方法之后会执行。
    if (_isTimeUp) {
        [self didAutoScrollAdjustView];
    }
}
#pragma mark - private
/**
 自动滚动
 */
- (void)automaticScroll
{
    [self.bgScrollView setContentOffset:CGPointMake(kBANNERWIDTH * 3, 0) animated:YES];
    _isTimeUp = YES;
    //    //自动滚动的时候。第三个自然是中间的啦。
    //    _whitchMiddle = 2;
}
/**
 自动滑动后调整视图
 */
-(void)didAutoScrollAdjustView{
    
    if (self.imageURLStringsGroup.count == 0) {
    }else if (self.imageURLStringsGroup.count == 1){
    }else{
        
        currentImage = (currentImage+1)%self.imageURLStringsGroup.count;
        self.pageControl.currentPage = (self.pageControl.currentPage + 1)%self.imageURLStringsGroup.count;
        [self.beforeLeftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-2+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-1+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[currentImage%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.rightImgaeView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+1)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.afterRightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+2)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        self.bgScrollView.contentOffset = CGPointMake(kBANNERWIDTH*2, 0);
        
       
        
        //自动滑动结束后要缩放大小。
        [self amplification:self.centerImageView];
        UIImageView *rightImageView = self.imageViewArray[3];
        [self narrowImageView:rightImageView];
        
    }
}

/**
 手动滑动后，修改图片的位置。
 */
-(void)didManualScrollAdjustView{
    self.bgScrollView.scrollEnabled = YES;
    if (self.imageURLStringsGroup.count == 0) {
    }else if (self.imageURLStringsGroup.count == 1){
    }else{
        //手动控制图片滚动应该取消那个三秒的计时器
        [self setupTimer];
        _isTimeUp = YES;
        
        if (self.bgScrollView.contentOffset.x == kBANNERWIDTH)
        {
            currentImage = (currentImage-1+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count;
            //当往左滑动的时候，可能出现负数取模的情况，如果小于0就加imageURLStringsGroup.count
            self.pageControl.currentPage =  ((self.pageControl.currentPage+self.imageURLStringsGroup.count- 1)%self.imageURLStringsGroup.count);
        }
        else if(self.bgScrollView.contentOffset.x == kBANNERWIDTH * 3)
        {
            currentImage = (currentImage+1)%self.imageURLStringsGroup.count;
            self.pageControl.currentPage = (self.pageControl.currentPage + 1)%self.imageURLStringsGroup.count;
        }
        else
        {
            return;
        }
        
        [self.beforeLeftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-2+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-1+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[currentImage%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.rightImgaeView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+1)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.afterRightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+2)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        
        
        self.bgScrollView.contentOffset = CGPointMake(kBANNERWIDTH*2, 0);
        
      
        //手动滑动结束后要缩放大小。
        [self amplification:self.centerImageView];
        UIImageView *leftImageView = self.imageViewArray[1];
        [self narrowImageView:leftImageView];
        UIImageView *rightImageView = self.imageViewArray[3];
        [self narrowImageView:rightImageView];
    }
}

/**
 设置定时器
 */
- (void)setupTimer
{
    if (!_moveTime) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
        _moveTime = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}
/**
 取消定时器
 */
-(void)cancelTimer{
    [_moveTime invalidate];
    _moveTime = nil;
}

/**
 直接设置为缩小视图的坐标
 */
-(void)narrowImageView:(UIImageView *)imageView{
        imageView.frame = CGRectMake(kBANNERWIDTH*kSCALESPACE/2, kBANNERHEIGHT*kSCALESPACE/2, kBANNERWIDTH*(1-kSCALESPACE), kBANNERHEIGHT*(1-kSCALESPACE));
    imageView.layer.shadowOpacity = 0.0;
}
/**
 直接设置为放大视图的坐标

 @param imageView <#imageView description#>
 */
-(void)amplification:(UIImageView *)imageView{
  
    imageView.frame = CGRectMake(0, 0, kBANNERWIDTH, kBANNERHEIGHT);
}
/**
 通过缩率比例来缩小放大视图的坐标
 @param scale 为 (imageView的middle距离屏幕中间的距离)/bannerwidth
 */
-(void)adjustImageViewScale:(UIImageView *)imageView WithScale:(CGFloat)scale{
    if (scale>1) {
        return;
    }
    imageView.frame = CGRectMake(kBANNERWIDTH*kSCALESPACE*scale/2, kBANNERHEIGHT*kSCALESPACE*scale/2, kBANNERWIDTH*((1-kSCALESPACE)+kSCALESPACE*(1-scale)), kBANNERHEIGHT*((1-kSCALESPACE)+kSCALESPACE*(1-scale)));
}


#pragma mark - event
-(void)centerImagViewClick{
    if ([self.delegate respondsToSelector:@selector(homePageBannerViewDidSelectedAtIndex:)]) {
        [self.delegate homePageBannerViewDidSelectedAtIndex:currentImage];
    }
}

#pragma mark - setter
-(void)setImageURLStringsGroup:(NSArray *)imageURLStringsGroup{
    _imageURLStringsGroup = imageURLStringsGroup;
    self.pageControl.numberOfPages = imageURLStringsGroup.count;
    if (_imageURLStringsGroup.count == 0) {
    }else if (_imageURLStringsGroup.count == 1){
        currentImage = 0;
        self.bgScrollView.scrollEnabled = NO;
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:imageURLStringsGroup[0]] placeholderImage:self.placeholderImage];
        
    }else{
        [self setupTimer];
        currentImage = 1;
        self.bgScrollView.contentOffset = CGPointMake(kBANNERWIDTH*2, 0);
        [self.beforeLeftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-2+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage-1+self.imageURLStringsGroup.count)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[currentImage%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.rightImgaeView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+1)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        [self.afterRightImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLStringsGroup[(currentImage+2)%self.imageURLStringsGroup.count]] placeholderImage:self.placeholderImage];
        
       
        
    }
}



#pragma mark - getter
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-10, self.bounds.size.width, 10)];
         [self addSubview:_pageControl];
        //添加委托方法，当点击小白点就执行此方法
        _pageControl.hidesForSinglePage = YES;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor redColor];// 设置非选中页的圆点颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor]; // 设置选中页的圆点颜色
    }
    return _pageControl;
}
-(UIScrollView *)bgScrollView{
    if (!_bgScrollView ){
        _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(kSCROLLVIEWX, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.bounces = NO;
      
        //剪裁效果设为NO,使不满屏的UIScrollView显示出满屏的效果
        _bgScrollView.clipsToBounds  = NO;
        _bgScrollView.delegate = self;
        _bgScrollView.contentSize = CGSizeMake(kBANNERWIDTH*5, 0);
        _bgScrollView.contentOffset = CGPointMake(kBANNERWIDTH*2, 0);
        _bgScrollView.showsHorizontalScrollIndicator = NO;
        [self.pageControl layoutIfNeeded];
        [self addSubview:_bgScrollView];
     
    }
    return _bgScrollView;
}

-(UIImageView *)beforeLeftImageView
{
    if (!_beforeLeftImageView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [self.bgScrollView addSubview:bgView];
        _beforeLeftImageView = [[UIImageView alloc]init];
        [self narrowImageView:_beforeLeftImageView];
        [bgView addSubview:_beforeLeftImageView];
        
    }
    return _beforeLeftImageView;
}
-(UIImageView *)leftImageView
{
    if (!_leftImageView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kBANNERWIDTH, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [self.bgScrollView addSubview:bgView];
        _leftImageView = [[UIImageView alloc]init];
        [self narrowImageView:_leftImageView];
        [bgView addSubview:_leftImageView];
 
    }
    return _leftImageView;
}

-(UIImageView *)centerImageView
{
    if (!_centerImageView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kBANNERWIDTH*2, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [self.bgScrollView addSubview:bgView];
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [bgView addSubview:_centerImageView];
        
     
     
        _centerImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(centerImagViewClick)];
        [_centerImageView addGestureRecognizer:tap];
        
 
    }
    return _centerImageView;
}
-(UIImageView *)rightImgaeView
{
    if (!_rightImgaeView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kBANNERWIDTH*3, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [self.bgScrollView addSubview:bgView];
        _rightImgaeView = [[UIImageView alloc]init];
        [self narrowImageView:_rightImgaeView];
        
        [bgView addSubview:_rightImgaeView];
        
    }
    return _rightImgaeView;
}

-(UIImageView *)afterRightImageView
{
    if (!_afterRightImageView) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(kBANNERWIDTH*4, 0, kBANNERWIDTH, kBANNERHEIGHT)];
        [self.bgScrollView addSubview:bgView];
        _afterRightImageView = [[UIImageView alloc]init];
        [self narrowImageView:_afterRightImageView];
        [bgView addSubview:_afterRightImageView];
     
    }
    return _afterRightImageView;
}

-(NSMutableArray *)imageViewArray{
    if (!_imageViewArray) {
        _imageViewArray = [NSMutableArray array];
        [_imageViewArray addObject:self.beforeLeftImageView];
        [_imageViewArray addObject:self.leftImageView];
        [_imageViewArray addObject:self.centerImageView];
        [_imageViewArray addObject:self.rightImgaeView];
        [_imageViewArray addObject:self.afterRightImageView];
    }
    return _imageViewArray;
}


@end
