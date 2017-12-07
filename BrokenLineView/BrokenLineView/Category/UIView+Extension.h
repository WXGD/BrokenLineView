//
//  UIView+Extension.h
//  WeiBo
//
//  Created by lanou3g on 15/9/23.
//  Copyright (c) 2015年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/** 视图位置尺寸 */
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
/** 获取当前视图所在控制器 */
- (UIViewController*)viewController;

@end
