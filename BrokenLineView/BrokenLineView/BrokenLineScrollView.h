//
//  BrokenLineScrollView.h
//  GJDataCount
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrokenLineView.h"

@interface BrokenLineScrollView : UIScrollView

/** 折线图view */
@property (strong, nonatomic) BrokenLineView *brokenLineView;


/**
 * 初始化方法
 *
 * @paramet xNodeAry:X轴节点数组
 * @paramet yNodeAry:Y轴节点数组
 * @paramet xOrigin:坐标原点X(默认30)
 * @paramet yOrigin:坐标原点Y(默认30)
 * @paramet xAxisSpac:X轴间距(默认50)
 * @paramet yAxisSpac:Y轴间距(默认50)
 * @paramet xAxisRightSpac:X轴间距离右边距离(默认30)
 * @paramet yAxisTopSpac:Y轴间距离上边距离(默认30)
 */
+ (instancetype)foundBrokenLineScrollViewChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac;

@end
