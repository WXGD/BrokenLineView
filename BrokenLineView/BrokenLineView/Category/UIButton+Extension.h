//
//  UIButton+Extension.h
//  ParkingSpace
//
//  Created by apple on 2017/9/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Extension)

#pragma mark - 本项目常用按钮样式
/** 圆角背景图片按钮 */
+ (instancetype)backImageBtnNormalTitle:(NSString *)normalTitle;
// 直角背景图片按钮
+ (instancetype)rightAngleImageBtnNormalTitle:(NSString *)normalTitle;

#pragma mark - 初始化方法
/**
 * 图片按钮初始化方法
 *
 * @paramet buttonType:按钮类型
 * @paramet normalTitle:普通状态按钮文字
 * @paramet normalImage:图片状态按钮图片
 * @paramet highlightedImage:高亮状态按钮图片
 */
+ (instancetype)imageButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage;

/**
 * 背景图片按钮初始化方法
 *
 * @paramet buttonType:按钮类型
 * @paramet normalTitle:普通状态按钮文字
 * @paramet normalBackImage:普通状态按钮背景图片
 * @paramet highlightBackImage:高亮状态按钮背景图片
 */
+ (instancetype)imageButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle normalBackImage:(UIImage *)normalBackImage highlightBackImage:(UIImage *)highlightBackImage;

/**
 * 文字按钮初始化方法
 *
 * @paramet buttonType:按钮类型
 * @paramet normalTitle:普通状态按钮文字
 * @paramet normalImage:图片状态按钮图片
 * @paramet highlightedImage:高亮状态按钮图片
 */
+ (instancetype)titleButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle normalBackImage:(UIImage *)normalBackImage highlightedBackImage:(UIImage *)highlightedBackImage;


#pragma mark - 文字
/** 普通文字 */
@property (nonatomic, strong) NSString *normalTitle;
/** 高亮文字 */
@property (nonatomic, strong) NSString *highlightTitle;
/** 选中文字 */
@property (nonatomic, strong) NSString *selectedTitle;
#pragma mark - 文字颜色
/** 普通文字颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 高亮文字颜色 */
@property (nonatomic, strong) UIColor *highlightTitleColor;
/** 选中文字颜色 */
@property (nonatomic, strong) UIColor *selectedTitleColor;

#pragma mark - 图片
/** 普通图片 */
@property (nonatomic, strong) UIImage *normalImage;
/** 高亮图片 */
@property (nonatomic, strong) UIImage *highlightImage;
/** 选中图片 */
@property (nonatomic, strong) UIImage *selectedImage;

#pragma mark - 背景图片
/** 普通背景图片 */
@property (nonatomic, strong) UIImage *normalBackImage;
/** 高亮背景图片 */
@property (nonatomic, strong) UIImage *highlightBackImage;
/** 选中背景图片 */
@property (nonatomic, strong) UIImage *selectedBackImage;

#pragma mark - 点击面积设置
/** 点击面积 */
@property (nonatomic, assign) UIEdgeInsets hitEdgeInsets;


@end
