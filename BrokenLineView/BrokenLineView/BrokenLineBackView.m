//
//  BrokenLineBackView.m
//  GJDataCount
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BrokenLineBackView.h"

@interface BrokenLineBackView ()<UIScrollViewDelegate>

/** 坐标原点X */
@property (assign, nonatomic) CGFloat xOrigin;
/** y轴标记 */
@property (strong, nonatomic) UIScrollView *yAxisMarkerView;

@end


@implementation BrokenLineBackView

#pragma makr - 初始化方法
+ (instancetype)foundBrokenLineChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry {
    BrokenLineBackView *brokenLineBackView = [[BrokenLineBackView alloc] init];
    [brokenLineBackView brokenLineBackXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:30 yOrigin:30 xAxisSpac:50 yAxisSpac:50 xAxisRightSpac:30 yAxisTopSpac:30];
    return brokenLineBackView;
}
+ (instancetype)foundBrokenLineChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    BrokenLineBackView *brokenLineBackView = [[BrokenLineBackView alloc] init];
    [brokenLineBackView brokenLineBackXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
    return brokenLineBackView;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
    }
    return self;
}

#pragma makr - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // scrollView联合滚动
    if (self.brokenScrollView.contentOffset.x > self.xOrigin) {
        [self.yAxisMarkerView setHidden:NO];
    }else {
        [self.yAxisMarkerView setHidden:YES];
    }
    self.yAxisMarkerView.contentOffset = CGPointMake(0, self.brokenScrollView.contentOffset.y);
    // 隐藏选中分割线和弹框
    for (int i = 0; i < self.brokenScrollView.brokenLineView.brokenLineAry.count; i++) {
        UILabel *textBox = [self.brokenScrollView.brokenLineView viewWithTag:2000 + i];
        [textBox setHidden:YES];
        // 删除选中分割线
        [self.brokenScrollView.brokenLineView.seleDashView setHidden:YES];
    }
}


#pragma makr - 创建控件
- (void)brokenLineBackXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    /** 保存坐标原点X */
    self.xOrigin = xOrigin;
    /** 折线图view */
    self.brokenScrollView = [BrokenLineScrollView foundBrokenLineScrollViewChartXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
    self.brokenScrollView.delegate = self;
    [self addSubview:self.brokenScrollView];
    /** y轴标记 */
    self.yAxisMarkerView = [[UIScrollView alloc] init];
    self.yAxisMarkerView.delegate = self;
    self.yAxisMarkerView.userInteractionEnabled = NO;
    self.yAxisMarkerView.contentSize = CGSizeMake(xOrigin, yAxisSpac * yNodeAry.count + yOrigin + yAxisTopSpac);
    [self addSubview:self.yAxisMarkerView];
    [self.yAxisMarkerView setHidden:YES];
    // 创建y轴数据
    [self createLabelYNodeAry:yNodeAry xOrigin:xOrigin yAxisSpac:yAxisSpac yAxisTopSpac:yAxisTopSpac];
}



#pragma makr - 布局方法
- (void)layoutSubviews {
    [super layoutSubviews];
    /** 折线图view */
    @weakify(self)
    [self.brokenScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    /** y轴标记 */
    [self.yAxisMarkerView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(self.xOrigin);
    }];
}


#pragma makr - 创建y轴数据
- (void)createLabelYNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yAxisSpac:(CGFloat)yAxisSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    for (NSInteger i = 0; i < yNodeAry.count ; i++) {
        // 获取展示字符
        NSString *text = yNodeAry[i];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 展示文字
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(xOrigin - size.width - 5,
                                                                            yAxisTopSpac + yAxisSpac * i - size.height/2,
                                                                            size.width, size.height)];
        labelYdivision.text = text;
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self.yAxisMarkerView addSubview:labelYdivision];
    }
}

@end
