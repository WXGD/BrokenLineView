//
//  BrokenLineView.h
//  GJDataCount
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 apple. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface BrokenLineView : UIView


/****************控件****************/
/** 选中分割线属性 */
@property (strong, nonatomic) UIView *seleDashView;
/****************属性参数****************/
/** 是否有Y轴(YES:有，NO:没有，默认YES) */
@property (assign, nonatomic) BOOL isYAxis;
/** 是否有X轴(YES:有，NO:没有，默认YES) */
@property (assign, nonatomic) BOOL isXAxis;
/****************数据参数****************/
/** 折线数组(里面是数组，一个数组就是一条线，每个数组中，包含的是每一个点) */
@property (strong, nonatomic) NSArray *brokenLineAry;
/** 折线颜色数组(里面是UIColor类型，每一条线的颜色) */
@property (strong, nonatomic) NSArray *brokenLineColorAry;

#pragma makr - 初始化方法
+ (instancetype)foundBrokenLineChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac;

@end
