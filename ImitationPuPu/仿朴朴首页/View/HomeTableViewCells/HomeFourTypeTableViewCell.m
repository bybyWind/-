//
//  HomeFourTypeTableViewCell.m
//  仿朴朴首页
//
//  Created by 社会人 on 2019/3/4.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import "HomeFourTypeTableViewCell.h"

@interface HomeFourTypeTableViewCell (){
    NSInteger _timeInteger;/** 剩余时间搓 */
}
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;
/**时间计时器 */
@property (nonatomic, weak) NSTimer *countDownTimer;

@end

@implementation HomeFourTypeTableViewCell

- (void)setDataSourceDic:(NSDictionary *)dataSourceDic{
    _dataSourceDic = dataSourceDic;
    NSString *totalSeconds = dataSourceDic[@"countDownTime"];
    
    _timeInteger = [totalSeconds integerValue];
    self.countDownLabel.text = [NSString stringWithFormat:@"离本场开始 %@",[self timeFormatted:[NSString stringWithFormat:@"%ld",(long)_timeInteger]]];
    if (!_countDownTimer) {
        _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownNextSecond) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_countDownTimer forMode:NSRunLoopCommonModes];
    }
    
}
-(void)removeFromSuperview{
    [super removeFromSuperview];
    if (_countDownTimer) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
   
    
}
//NSTimer
- (void)countDownNextSecond{
    if (_timeInteger >0) {
        _timeInteger -= 1;
        self.countDownLabel.text = [NSString stringWithFormat:@"离本场开始 %@",[self timeFormatted:[NSString stringWithFormat:@"%ld",(long)_timeInteger]]];
    }else{
        [_countDownTimer invalidate];
        _countDownTimer = nil;
    }
}
- (NSString *)timeFormatted:(NSString *)totalSeconds
{

    int seconds = [totalSeconds intValue] % 60;
    int minutes = ([totalSeconds intValue] / 60) % 60;
    int hours = ([totalSeconds intValue]/ 3600)%24;
    int days = [totalSeconds intValue]/86400;
    
    NSString *daysString;
    if (days > 0) {
        daysString = [NSString stringWithFormat:@"%d天 ",days];
    }else{
        daysString = @"";
    }
    
    
    return [NSString stringWithFormat:@"%@%02d:%02d:%02d",daysString,hours, minutes, seconds];
}
@end
