//
//  ViewController.m
//  BrokenLineView
//
//  Created by apple on 2017/12/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "BrokenLineBackView.h"

@interface ViewController ()

@property (strong, nonatomic) BrokenLineBackView *brokenLineBackView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GrayVCColor;
    // 布局视图
    [self lineLayoutView];
}


#pragma mark - 布局nav
- (void)btnAction:(UIButton *)button {
    self.brokenLineBackView.brokenScrollView.brokenLineView.brokenLineColorAry = @[ThemeColor, YellowColor, BlueColor];
    NSArray *array1 = @[[NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50]];
    NSArray *array2 = @[[NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50]];
    NSArray *array3 = @[[NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50],
                        [NSString stringWithFormat:@"%u", arc4random() % 180 + 50]];
    self.brokenLineBackView.brokenScrollView.brokenLineView.brokenLineAry = @[array1, array2, array3];
    
}

#pragma mark - 布局视图
- (void)lineLayoutView {
    //    self.brokenLineBackView = [BrokenLineBackView foundBrokenLineChartXNodeAry:@[@"17.7", @"17.8", @"17.9", @"17.10", @"17.11", @"17.12(预)"] yNodeAry:@[@"元/m", @"15000", @"14000", @"13000", @"12000", @"11000", @"10000"]];
    self.brokenLineBackView = [BrokenLineBackView foundBrokenLineChartXNodeAry:@[@"17.7", @"17.8", @"17.9", @"17.10", @"17.11", @"17.12(预)"] yNodeAry:@[@"元/m", @"15000", @"14000", @"13000", @"12000", @"11000", @"10000"] xOrigin:52 yOrigin:20 xAxisSpac:60 yAxisSpac:30 xAxisRightSpac:10 yAxisTopSpac:10];
    [self.view addSubview:self.brokenLineBackView];
    @weakify(self)
    [self.brokenLineBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 7 * 30 + 30));
    }];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.normalTitle = @"点我";
    btn.backgroundColor = RANDOMCOLOR;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 100, 30);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

