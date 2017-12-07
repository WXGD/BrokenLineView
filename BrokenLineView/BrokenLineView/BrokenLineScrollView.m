//
//  BrokenLineScrollView.m
//  GJDataCount
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BrokenLineScrollView.h"

@interface BrokenLineScrollView ()

@end

@implementation BrokenLineScrollView


#pragma makr - 初始化方法
+ (instancetype)foundBrokenLineScrollViewChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    BrokenLineScrollView *brokenLineScrollView = [[BrokenLineScrollView alloc] init];
    [brokenLineScrollView brokenLineScrollViewXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
    return brokenLineScrollView;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = RANDOMCOLOR;
    }
    return self;
}

#pragma makr - 创建控件 
- (void)brokenLineScrollViewXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    /** 折线图view */
    self.brokenLineView = [BrokenLineView foundBrokenLineChartXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
    [self addSubview:self.brokenLineView];
    // 设置折线图宽高
    [self.brokenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(xAxisSpac * xNodeAry.count + xOrigin + xAxisRightSpac);
        make.height.mas_equalTo(yAxisSpac * yNodeAry.count + yOrigin + yAxisTopSpac);
    }];
}


#pragma makr - 布局方法
- (void)layoutSubviews {
    [super layoutSubviews];
    @weakify(self)
    /** 折线图view */
    [self.brokenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}


@end
