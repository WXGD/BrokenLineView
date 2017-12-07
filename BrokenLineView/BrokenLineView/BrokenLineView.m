//
//  BrokenLineView.m
//  GJDataCount
//
//  Created by apple on 2017/11/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BrokenLineView.h"

@interface BrokenLineView ()

/****************数据参数****************/
/** X轴节点数组 */
@property (strong, nonatomic) NSArray *xNodeAry;
/** Y轴节点数组 */
@property (strong, nonatomic) NSArray *yNodeAry;
/** X轴节点坐标数组 */
@property (strong, nonatomic) NSMutableArray *xNodeCordAry;
/****************X,Y轴共用参数****************/
/** 坐标原点X */
@property (assign, nonatomic) CGFloat xOrigin;
/** 坐标原点Y(距离下边距离) */
@property (assign, nonatomic) CGFloat yOrigin;
/****************X轴参数****************/
/** X轴间距 */
@property (assign, nonatomic) CGFloat xAxisSpac;
/** X轴间距离右边距离 */
@property (assign, nonatomic) CGFloat xAxisRightSpac;
/****************Y轴参数****************/
/** Y轴间距 */
@property (assign, nonatomic) CGFloat yAxisSpac;
/** Y轴间距离上边距离 */
@property (assign, nonatomic) CGFloat yAxisTopSpac;


@end

@implementation BrokenLineView

#pragma mark - 初始化方法
+ (instancetype)foundBrokenLineChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    BrokenLineView *brokenLineView = [[BrokenLineView alloc] init];
    [brokenLineView brokenLineXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
    return brokenLineView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = WhiteColor;
        // 当前页面添加轻拍手势
        UITapGestureRecognizer *lineViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lineViewTapAction:)];
        [self addGestureRecognizer:lineViewTap];
    }
    return self;
}

#pragma mark - set方法
- (void)setBrokenLineAry:(NSArray *)brokenLineAry {
    _brokenLineAry = brokenLineAry;
    // 创建折线
    [self ergodicBrokenLineAry:brokenLineAry];
}


#pragma mark - 轻拍手势点击
- (void)lineViewTapAction:(UIGestureRecognizer *)tap {
    // 获取点击坐标
    CGPoint point = [tap locationInView:self];
    // 计算点击点所在区域
    NSInteger xInt = (point.x - self.xOrigin) / self.xAxisSpac;
    // 判断当前坐标是否大于等于1
    if (xInt >= 1) {
        // 获取x轴坐标
        // 判断点击的是不是最后一条
        if (xInt < self.xNodeCordAry.count - 2 ) {
            // 判断点击区域距离屏幕右边距是否大于100
            // 获取父视图
            UIScrollView *supScr = (UIScrollView *)[self superview];
            if (point.x - supScr.contentOffset.x <= 200) {
//            if (point.x - supScr.contentOffset.x + 92 > self.width) {
                CGFloat xCord = [[self.xNodeCordAry objectAtIndex:xInt + 1] doubleValue];
                // 便利每一条折线，数据出现在分割线右边
                [self splitLineRight:xInt point:point xCord:xCord];
            }else {
                CGFloat xCord = [[self.xNodeCordAry objectAtIndex:xInt + 1] doubleValue];
                // 便利每一条折线，数据出现在分割线左边
                [self splitLineLeft:xInt point:point xCord:xCord];
            }
            // 绘制选中分割线
            [self drawSelectedLine:xInt + 1];
        }else if (xInt == self.xNodeCordAry.count - 2 ) {
            CGFloat xCord = [[self.xNodeCordAry objectAtIndex:xInt + 1] doubleValue];
            // 最后一条数据出现在分割线左边
            [self splitLineLeft:xInt point:point xCord:xCord];
            // 绘制选中分割线
            [self drawSelectedLine:xInt + 1];
        }
    }else if (xInt == 0) {
        // 计算点击点所在区域
        CGFloat xfloat = (point.x - self.xOrigin) / self.xAxisSpac;
        if (xfloat > 0.5) {
            // 获取x轴坐标
            CGFloat xCord = [[self.xNodeCordAry objectAtIndex:1] doubleValue];
            // 便利每一条折线，数据出现在分割线右边
            [self splitLineRight:xInt point:point xCord:xCord];
            // 绘制选中分割线
            [self drawSelectedLine:1];
        }else if (xfloat <= 0.5) {
            // 获取x轴坐标
            CGFloat xCord = [[self.xNodeCordAry firstObject] doubleValue];
            // 便利每一条折线，数据出现在分割线右边
            [self splitLineRight:xInt point:point xCord:xCord];
            // 绘制选中分割线
            [self drawSelectedLine:0];
        }
    }
}


#pragma mark - 创建控件
- (void)brokenLineXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
    // 设置默认值
    /** X轴节点数组 */
    self.xNodeAry = xNodeAry;
    /** Y轴节点数组 */
    self.yNodeAry = yNodeAry;
    /** 坐标原点X */
    self.xOrigin = xOrigin;
    /** 坐标原点Y(距离下边距离) */
    self.yOrigin = yOrigin;
    /** X轴间距(默认为50) */
    self.xAxisSpac = xAxisSpac;
    /** X轴间距离右边距离 */
    self.xAxisRightSpac = xAxisRightSpac;
    /** Y轴间距(默认为50) */
    self.yAxisSpac = yAxisSpac;
    /** Y轴间距离上边距离 */
    self.yAxisTopSpac = yAxisTopSpac;
    /** 是否有Y轴(YES:有，NO:没有，默认YES) */
    self.isYAxis = YES;
    /** 是否有X轴(YES:有，NO:没有，默认YES) */
    self.isXAxis = YES;
    /** 初始化X轴节点坐标数组 */
    self.xNodeCordAry = [[NSMutableArray alloc] init];
    /** 选中分割线属性 */
    self.seleDashView = [[UIView alloc] init];
    self.seleDashView.backgroundColor = ThemeColor;
    [self addSubview:self.seleDashView];
    [self.seleDashView setHidden:YES];
}



#pragma mark - 点击数据弹出
// 数据出现在分割线右边
- (void)splitLineRight:(NSInteger)xInt point:(CGPoint)point xCord:(CGFloat)xCord {
    // 便利每一条折线
    for (int i = 0; i < self.brokenLineAry.count; i++) {
        // 获取价格字符内容
        NSArray *brokenAry = [self.brokenLineAry objectAtIndex:i];
        NSString *text = [NSString stringWithFormat:@"单价：%@/㎡", [brokenAry objectAtIndex:xInt]];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 真实价格字符
        UILabel *textBox = [self viewWithTag:2000 + i];
        textBox.text = text;
        textBox.x = xCord + 10;
//        textBox.width = size.width + 14;
        textBox.width = 92;
        textBox.height = size.height + 5;
        if (point.y < self.height - 100) {
            textBox.y = point.y + (textBox.height + 5) * i;
        }else {
            textBox.y = 100 + (textBox.height + 5) * i;
        }
        [textBox setHidden:NO];
    }
}

// 数据出现在分割线左边
- (void)splitLineLeft:(NSInteger)xInt point:(CGPoint)point xCord:(CGFloat)xCord {
    // 便利每一条折线
    for (int i = 0; i < self.brokenLineAry.count; i++) {
        // 获取价格字符内容
        NSArray *brokenAry = [self.brokenLineAry objectAtIndex:i];
        NSString *text = [NSString stringWithFormat:@"单价：%@/㎡", [brokenAry objectAtIndex:xInt]];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 真实价格字符
        UILabel *textBox = [self viewWithTag:2000 + i];
        textBox.text = text;
//        textBox.width = size.width + 14;
        textBox.width = 92;
        textBox.x = xCord - 10 - textBox.width;
        textBox.height = size.height + 5;
        if (point.y < self.height - 100) {
            textBox.y = point.y + (textBox.height + 5) * i;
        }else {
            textBox.y = 100 + (textBox.height + 5) * i;
        }
        [textBox setHidden:NO];
    }
}

#pragma mark - 绘制选中分割线
- (void)drawSelectedLine:(NSInteger)xInt {
    /** 选中分割线属性 */
    [self.seleDashView setHidden:NO];
    self.seleDashView.x = self.xOrigin + self.xAxisSpac * xInt;
    self.seleDashView.y = self.yAxisTopSpac;
}

#pragma mark - 画出坐标轴
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetRGBStrokeColor(context, 0.87, 0.87, 0.87, 1);
    // 判断是否有X,Y轴
    if (self.isXAxis && self.isYAxis) { // 都有
        CGContextMoveToPoint(context, self.xOrigin, self.yAxisTopSpac);
        CGContextAddLineToPoint(context, self.xOrigin, rect.size.height - self.yOrigin);
        CGContextAddLineToPoint(context, rect.size.width - self.xAxisRightSpac, rect.size.height - self.yOrigin);
    }else if (self.isXAxis && !self.isYAxis) { // 有X轴
        CGContextMoveToPoint(context, self.xOrigin, rect.size.height - self.yOrigin);
        CGContextAddLineToPoint(context, rect.size.width - self.xAxisRightSpac, rect.size.height - self.yOrigin);
    }else if (!self.isXAxis && self.isYAxis) { // 有Y轴
        CGContextMoveToPoint(context, self.xOrigin, self.yAxisTopSpac);
        CGContextAddLineToPoint(context, self.xOrigin, rect.size.height - self.yOrigin);
    }
    CGContextStrokePath(context);
    // x轴分割线
    [self setXLineDash:self.xNodeAry];
    // y轴分割线
    [self setYLineDash:self.yNodeAry];
}

#pragma mark - 添加虚线
// x轴分割线
- (void)setXLineDash:(NSArray *)nodeAry {
    if (self.height != 0) {
        for (NSInteger i = 1;i < nodeAry.count; i++ ) {
            // 分割线属性
            CAShapeLayer * dashLayer = [CAShapeLayer layer];
            dashLayer.strokeColor = GrayLineColor.CGColor;
            dashLayer.fillColor = CLEARCOLOR.CGColor;
            dashLayer.lineWidth = 0.5;
            // 绘制分割线
            UIBezierPath *path = [[UIBezierPath alloc]init];
            // 分割线起始点
            [path moveToPoint:CGPointMake(self.xOrigin + self.xAxisSpac * i, self.yAxisTopSpac)];
            [path addLineToPoint:CGPointMake(self.xOrigin + self.xAxisSpac * i, self.height - self.yOrigin)];
            dashLayer.path = path.CGPath;
            [self.layer addSublayer:dashLayer];
        }
        // 创建y轴的数据
        [self createLabelX:nodeAry];
    }
}
// y轴分割线
- (void)setYLineDash:(NSArray *)nodeAry {
    if (self.width != 0) {
        for (NSInteger i = 1;i < nodeAry.count; i++ ) {
            // 分割线属性
            CAShapeLayer * dashLayer = [CAShapeLayer layer];
            dashLayer.strokeColor = GrayLineColor.CGColor;
            dashLayer.fillColor = CLEARCOLOR.CGColor;
            dashLayer.lineWidth = 0.5;
            // 绘制分割线
            UIBezierPath * path = [[UIBezierPath alloc]init];
            // 分割线起始点
            [path moveToPoint:CGPointMake(self.xOrigin, self.yAxisTopSpac + self.yAxisSpac * i)];
            [path addLineToPoint:CGPointMake(self.width - self.xAxisRightSpac, self.yAxisTopSpac + self.yAxisSpac * i)];
            dashLayer.path = path.CGPath;
            [self.layer addSublayer:dashLayer];
        }
        // 创建y轴的数据
        [self createLabelY:nodeAry];
    }
}
#pragma mark - 创建轴线的数据
// 创建x轴的数据
- (void)createLabelX:(NSArray *)nodeAry {
    for (NSInteger i = 0; i < nodeAry.count; i++) {
        // 获取展示字符
        NSString *text = nodeAry[i];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 展示文字
        UILabel * LabelMonth = [[UILabel alloc]initWithFrame:CGRectMake(self.xOrigin + self.xAxisSpac * i - size.width / 2,
                                                                        self.frame.size.height - self.yOrigin + 5,
                                                                        size.width, size.height)];
        LabelMonth.text = text;
        LabelMonth.font = [UIFont systemFontOfSize:10];
//        LabelMonth.transform = CGAffineTransformMakeRotation(M_PI * 0.3);
        [self addSubview:LabelMonth];
        // 保存x轴坐标
        [self.xNodeCordAry addObject:[NSString stringWithFormat:@"%f", self.xOrigin + self.xAxisSpac * i]];
    }
    
}
// 创建y轴数据
- (void)createLabelY:(NSArray *)nodeAry {
    for (NSInteger i = 0; i < nodeAry.count ; i++) {
        // 获取展示字符
        NSString *text = nodeAry[i];
        // 计算字符size
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        NSAttributedString *attributeSting = [[NSAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10]}];
        size = [attributeSting size];
        // 展示文字
        UILabel * labelYdivision = [[UILabel alloc]initWithFrame:CGRectMake(self.xOrigin - size.width - 5,
                                                                            self.yAxisTopSpac + self.yAxisSpac * i - size.height/2,
                                                                            size.width, size.height)];
        labelYdivision.text = text;
        labelYdivision.font = [UIFont systemFontOfSize:10];
        [self addSubview:labelYdivision];
    }
}

#pragma mark - 创建折线
// 折线数组
- (void)ergodicBrokenLineAry:(NSArray *)brokenLineAry {
    // 便利折线数组
    for (NSInteger i = 0;i < brokenLineAry.count; i++ ) {
        // 创建折线
        [self paintingBrokenLineSpot:[brokenLineAry objectAtIndex:i] lineColor:[self.brokenLineColorAry objectAtIndex:i]];
    }
    // 便利折线数组
    for (NSInteger i = 0;i < brokenLineAry.count; i++ ) {
        // 创建点击出现的文字弹框
        UILabel *textBox = [[UILabel alloc] init];
        textBox.textColor = WhiteColor;
        textBox.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.9];
        textBox.textAlignment = NSTextAlignmentCenter;
        textBox.font = [UIFont systemFontOfSize:10];
        textBox.layer.masksToBounds = YES;
        textBox.layer.cornerRadius = 5;
        textBox.tag = 2000 + i;
        [self addSubview:textBox];
        [textBox setHidden:YES];
        [textBox becomeFirstResponder];
    }
}
// 创建折线
- (void)paintingBrokenLineSpot:(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor {
    // 画折线
    [self drawBrokenLine:brokenLineSpotAry lineColor:lineColor];
    // 画标记点
    [self drawMarkeroint:brokenLineSpotAry lineColor:lineColor];
}
// 画折线
- (void)drawBrokenLine:(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor {
    // 折线属性
    CAShapeLayer * dashLayer = [CAShapeLayer layer];
    dashLayer.strokeColor = lineColor.CGColor;
    dashLayer.fillColor = CLEARCOLOR.CGColor;
    dashLayer.lineWidth = 0.5;
    // 绘制折线
    UIBezierPath * path = [[UIBezierPath alloc]init];
    // 折线图起点 brokenOrigin
    CGPoint brokenOrigin = CGPointMake(self.xOrigin, [[brokenLineSpotAry firstObject] integerValue]);
    // 折线起点
    [path moveToPoint:brokenOrigin];
    [self.layer addSublayer:dashLayer];
    // 便利折线图数据
    for (NSInteger i = 1;i < brokenLineSpotAry.count; i++ ) {
        // 折线终点
        brokenOrigin = CGPointMake(self.xOrigin + self.xAxisSpac * i, [[brokenLineSpotAry objectAtIndex:i] integerValue]);
        [path addLineToPoint:brokenOrigin];
        dashLayer.path = path.CGPath;
    }
    // 折线显示动画
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3;
    pathAnimation.repeatCount = 1;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [dashLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

// 画标记点
- (void)drawMarkeroint :(NSArray *)brokenLineSpotAry lineColor:(UIColor *)lineColor {
    // 标记点起点
    CGPoint markerOrigin = CGPointMake(self.xOrigin, [[brokenLineSpotAry firstObject] integerValue]);
    // 便利折标记点数据
    for (NSInteger i = 1;i <= brokenLineSpotAry.count; i++ ) {
        // 白色标记点
        UIView *whiteView = [[UIView alloc] init];
        whiteView.backgroundColor = WhiteColor;
        whiteView.x = markerOrigin.x - 5;
        whiteView.y = markerOrigin.y - 5;
        whiteView.size = CGSizeMake(10, 10);
        whiteView.layer.masksToBounds = YES;
        whiteView.layer.cornerRadius = 5;
        [self addSubview:whiteView];
        [self bringSubviewToFront:whiteView];
        // 折线颜色标记点
        UIView *markeriew = [[UIView alloc] init];
        markeriew.backgroundColor = lineColor;
        markeriew.x = 2.5;
        markeriew.y = 2.5;
        markeriew.size = CGSizeMake(5, 5);
        markeriew.layer.masksToBounds = YES;
        markeriew.layer.cornerRadius = 2.5;
        [whiteView addSubview:markeriew];
        // i==brokenLineAry.count的时候不去取下一个点的坐标
        if (i < brokenLineSpotAry.count) {
            // 保存下一个标记点位置
            markerOrigin = CGPointMake(self.xOrigin + self.xAxisSpac * i, [[brokenLineSpotAry objectAtIndex:i] integerValue]);
        }
    }
}



#pragma mark - 布局方法
- (void)layoutSubviews {
    [super layoutSubviews];
    // 选中分割线宽高
    self.seleDashView.width = 1;
    self.seleDashView.height = self.height - self.yOrigin - self.yAxisTopSpac;
}

@end
