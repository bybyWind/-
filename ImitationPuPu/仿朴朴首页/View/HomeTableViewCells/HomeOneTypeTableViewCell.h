//
//  HomeOneTypeTableViewCell.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/3/3.
//  Copyright © 2019 funnyS. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^homeOneTypeTableViewCellExpendButtonClick)(BOOL isExpend);

@interface HomeOneTypeTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,assign)BOOL isExpend;
-(void)setHomeOneTypeTableViewCellExpendButtonClick:(homeOneTypeTableViewCellExpendButtonClick)homeOneTypeTableViewCellExpendButtonClick;

@end

NS_ASSUME_NONNULL_END
