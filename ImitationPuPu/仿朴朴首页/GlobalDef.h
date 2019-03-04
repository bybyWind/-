//
//  GlobalDef.h
//  仿朴朴首页
//
//  Created by 陈经风 on 2019/2/28.
//  Copyright © 2019 funnyS. All rights reserved.
//

#ifndef GlobalDef_h
#define GlobalDef_h
//************************ 视图 宽高 Frame 屏幕尺寸 **************************//
#define WINDOW_WIDTH [UIScreen mainScreen].bounds.size.width
#define WINDOW_HEIGHT [UIScreen mainScreen].bounds.size.height
#define statusBarH (IS_IPHONELH?44.0:20.0)
#define IS_IPHONELH (IS_IPHONEX || IS_IPHONEXSMAX || IS_IPHONEXR)
#define IS_IPHONEX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONEXSMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_IPHONEXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828,1792), [[UIScreen mainScreen] currentMode].size) : NO)

#define kNAVViewOffsetY (30)//首页NAV上滑偏移的距离
#define kNAVViewHeight (statusBarH+110)

#define ScaleWidth [UIScreen mainScreen].bounds.size.width / 375.0 //屏幕大小适配
#define ScaleHeight [UIScreen mainScreen].bounds.size.height / 667.0 //屏幕大小适配
//************************ 颜色 ****************************//
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kRandomColor RGBACOLOR(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kLineGrayColor RGBACOLOR(247, 247, 247, 1)


//************************ 项目类型 字段************************
typedef enum {
    scrollViewPullDown,
    scrollViewScrollUp,
}scrollViewScrollState;

#endif /* GlobalDef_h */
