![折线图.gif](http://upload-images.jianshu.io/upload_images/2262405-38eaccd81e4fd233.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

好吧！首先还是要感谢我们万恶的设计师，非要做什么折线图，而且还非要模仿人家很成熟的APP设计。

其实网上有非常多的折线图画法，但是直接使用现成的的折线图框架，都无法完全满足我们设计师的要求，最终只能自定义了。这里要感谢[健健锅](http://www.jianshu.com/u/ed32616d122f)的[iOS折线图实现（一）](http://www.jianshu.com/p/067825bb104f)。在折线图的实现上，给了我很多参考。

好了，下面进入正题
## 一、首先先来看看，常用的画线控件都有那些。

1、UIGraphicsGetCurrentContext的使用，先把代码贴出来：

```
// 创建上下文
CGContextRef context = UIGraphicsGetCurrentContext();
// 线宽
CGContextSetLineWidth(context, 0.5);
// 线颜色
CGContextSetRGBStrokeColor(context, 0.87, 0.87, 0.87, 1);
// 起点
CGContextMoveToPoint(context, 100, 100);
// 终点
CGContextAddLineToPoint(context, 200, 100);
// 加载上下文
CGContextStrokePath(context);
```
是不是感觉特别的简单。好吧，其实就这这么简单。只需要指定好线的起点和终点，一条直线就这么出现了。有一点需要指出画线的并非只能有一个点，而且可以同时指定多个点，然后画出一条连续的折线。

举个例子吧！下面的代码可以画出一个正方形：

```
CGContextMoveToPoint(context, 10, 10);
CGContextAddLineToPoint(context, 10, 100);
CGContextAddLineToPoint(context, 100, 100);
CGContextAddLineToPoint(context, 100, 10);
CGContextAddLineToPoint(context, 10, 10);
```

2、使用CAShapeLayer和UIBezierPath画线

还是先把代码贴出来：

```
// 折线属性
CAShapeLayer * dashLayer = [CAShapeLayer layer];
dashLayer.strokeColor = lineColor.CGColor;
dashLayer.fillColor = CLEARCOLOR.CGColor;
dashLayer.lineWidth = 0.5;
// 绘制折线
UIBezierPath * path = [[UIBezierPath alloc]init];
[self.layer addSublayer:dashLayer];
// 折线起点
[path moveToPoint:CGPointMake(10, 10)];
// 折线终点
[path addLineToPoint:CGPointMake(10, 100)];
dashLayer.path = path.CGPath;
```

完了，就是这么简单。对于CAShapeLayer和UIBezierPath这两个属性的使用，我就不细写了，这个两个属性的作用，UIBezierPath是用来指定画出图形的形状、位置等，CAShapeLayer则是用来控制画出图片的基本属性的。

同上下文一样，也是可以直接画出折线线条的，代码都差不多：

```
[path moveToPoint:CGPointMake(10, 10)];
[path addLineToPoint:CGPointMake(10, 100)];
[path addLineToPoint:CGPointMake(100, 100)];
[path addLineToPoint:CGPointMake(100, 10)];
[path addLineToPoint:CGPointMake(10, 10)];
```

好了，属性的基本使用写完了，下面就正式开始写折线图的画法了。

## 二、折线图的画法

1、X、Y坐标轴的画法

```
CGContextRef context = UIGraphicsGetCurrentContext();
CGContextSetLineWidth(context, 0.5);
CGContextSetRGBStrokeColor(context, 0.87, 0.87, 0.87, 1);
CGContextMoveToPoint(context, self.xOrigin, self.yAxisTopSpac);
CGContextAddLineToPoint(context, self.xOrigin, rect.size.height - self.yOrigin);
CGContextAddLineToPoint(context, rect.size.width - self.xAxisRightSpac, rect.size.height - self.yOrigin);
CGContextStrokePath(context);
```

具体注释，我就不写了，几乎和上面的用法没有任何区别。

2、X轴分割线

```
- (void)xLineDash:(NSArray *)nodeAry {
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
}
}
```

这里定义了一个数组，用来保存X轴节点，通过这个数组，画出对应的X轴分割线。

```
/** X轴节点数组 */
@property (strong, nonatomic) NSArray *xNodeAry;
```

3、Y轴分割线

```
/** Y轴节点数组 */
@property (strong, nonatomic) NSArray *yNodeAry;
```
```
// y轴分割线
- (void)yLineDash:(NSArray *)nodeAry {
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
}
}
```
做法同X轴相同。

4、X轴坐标点

```
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
```
这个地方其实同画分割线差不多，因为这个地方的难点，我感觉主要在坐标点的计算上，但是这种细致的计算，想来大家仔细想想都没什么问题了。

5、Y轴坐标点

```
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
```
一句话：同上。

其实此时折线图的坐标已经出现了，接下来就是画折线图了。
![X、Y轴坐标](http://upload-images.jianshu.io/upload_images/2262405-8fb60747ae20f08f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

6、画折线

```
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
}
```
折线图的画法，没做的时候感觉挺难的，现在一步一步的拆分开，好像真的没什么技术难点啊！到这来折线图的核心代码已经都实现了。

7、标记点

```
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
```
这个地方为什么把标记点放的这么靠后，主要是因为使用CAShapeLayer画出来的图形是加载在layer层的，使用bringSubviewToFront（）并不能将视图放放置在最上层，这里我采取的做法是控制控件的创建时机，如果还有别的方法，也希望可以指点我一下。
![标记点](http://upload-images.jianshu.io/upload_images/2262405-9acbd56406da2ba4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

7、点击折线图弹框

```
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
```

8、添加轻拍手势

```
- (void)lineViewTapAction:(UIGestureRecognizer *)tap {
// 获取点击坐标
CGPoint point = [tap locationInView:self];
// 计算点击点所在区域
NSInteger xInt = (point.x - self.xOrigin) / self.xAxisSpac;
// 判断当前坐标是否大于等于1
if (xInt >= 1) {
CGFloat xCord = [[self.xNodeCordAry objectAtIndex:xInt + 1] doubleValue];
// 便利每一条折线，弹出数据弹框
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
textBox.width = 92;
textBox.height = size.height + 5;
if (point.y < self.height - 100) {
textBox.y = point.y + (textBox.height + 5) * i;
}else {
textBox.y = 100 + (textBox.height + 5) * i;
}
[textBox setHidden:NO];
}
// 绘制选中分割线
[self drawSelectedLine:xInt + 1];
}
}
```
这里我是对整个折线图view添加了一个轻拍手势，然后根据轻拍手势的点击位置，来判断应该选中标记点，以及相关数据的展示位置，这个地方的代码比较多，因为相关的判断也比较多，这里只是粘出来了一部分，有兴趣的朋友可以下载dome看看。

9、为了能够使折线图更多的具有兼容性，我将整个折线图都放在了一个scrollview上，创建了一个BrokenLineScrollView控件。

```
/** 折线图view */
self.brokenLineView = [BrokenLineView foundBrokenLineChartXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
[self addSubview:self.brokenLineView];
// 设置折线图宽高
[self.brokenLineView mas_makeConstraints:^(MASConstraintMaker *make) {
make.width.mas_equalTo(xAxisSpac * xNodeAry.count + xOrigin + xAxisRightSpac);
make.height.mas_equalTo(yAxisSpac * yNodeAry.count + yOrigin + yAxisTopSpac);
}];
```

10、终于是最后一个了，在折线图X轴滚动的时候，我们的设计师希望坐标Y轴一直存在，为了不改变折线图的画法，我又对BrokenLineScrollView加了一层封装，创建了一个BrokenLineBackView控件，然后在这个控件上，创建了一个展示Y轴坐标的scrollview，之所以使用scrollview是因为我希望当折线图出现上下滚动的需求的时候，Y轴坐标也可以随着折线图滚动而滚动。核心代码如下：

```
#pragma makr - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
// scrollView联合滚动
if (self.brokenScrollView.contentOffset.x > self.xOrigin) {
[self.yAxisMarkerView setHidden:NO];
}else {
[self.yAxisMarkerView setHidden:YES];
}
// 折线图滚动的时候，滚动Y轴坐标scrollview
self.yAxisMarkerView.contentOffset = CGPointMake(0, self.brokenScrollView.contentOffset.y);
// 隐藏选中分割线和弹框
for (int i = 0; i < self.brokenScrollView.brokenLineView.brokenLineAry.count; i++) {
UILabel *textBox = [self.brokenScrollView.brokenLineView viewWithTag:2000 + i];
[textBox setHidden:YES];
// 删除选中分割线
[self.brokenScrollView.brokenLineView.seleDashView setHidden:YES];
}
}
```
![滚动折线图](http://upload-images.jianshu.io/upload_images/2262405-b28b35affa9b22ba.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

代码实现部分基本上就是这样了。因为坐标轴的实现由一些是不可缺少的字段，因此对折线图的创建，我使用了一个便利构造器方法。

```
+ (instancetype)foundBrokenLineChartXNodeAry:(NSArray *)xNodeAry yNodeAry:(NSArray *)yNodeAry xOrigin:(CGFloat)xOrigin yOrigin:(CGFloat)yOrigin xAxisSpac:(CGFloat)xAxisSpac yAxisSpac:(CGFloat)yAxisSpac xAxisRightSpac:(CGFloat)xAxisRightSpac yAxisTopSpac:(CGFloat)yAxisTopSpac {
BrokenLineView *brokenLineView = [[BrokenLineView alloc] init];
[brokenLineView brokenLineXNodeAry:xNodeAry yNodeAry:yNodeAry xOrigin:xOrigin yOrigin:yOrigin xAxisSpac:xAxisSpac yAxisSpac:yAxisSpac xAxisRightSpac:xAxisRightSpac yAxisTopSpac:yAxisTopSpac];
return brokenLineView;
}
```
这几个属性分别是：

```
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
```

好了，好了，想必能看到这里的人实在不多吧！我也是第一次写这么长的文字，而且使用了这么多的代码。如果有什么问题，也可随时联系我啊！关注我的[简书](http://www.jianshu.com/u/f36bc46c1158)就好啊！

