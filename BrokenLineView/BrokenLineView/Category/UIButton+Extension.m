//
//  UIButton+Extension.m
//  ParkingSpace
//
//  Created by apple on 2017/9/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIButton+Extension.h"


static void *MShitEdgeinsetKey = &MShitEdgeinsetKey;

@interface UIButton ()

@end

@implementation UIButton (Extension)

#pragma mark - 初始化方法
/** 图片按钮初始化方法 */
+ (instancetype)imageButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle normalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage {
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    return button;
}

/** 背景图片按钮初始化方法 */
+ (instancetype)imageButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle normalBackImage:(UIImage *)normalBackImage highlightBackImage:(UIImage *)highlightBackImage {
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightBackImage forState:UIControlStateHighlighted];
    return button;
}

/** 文字按钮初始化方法 */
+ (instancetype)titleButtonType:(UIButtonType)buttonType normalTitle:(NSString *)normalTitle highlightTitle:(NSString *)highlightTitle normalBackImage:(UIImage *)normalBackImage highlightedBackImage:(UIImage *)highlightedBackImage {
    UIButton *button = [UIButton buttonWithType:buttonType];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:highlightTitle forState:UIControlStateHighlighted];
    [button setBackgroundImage:normalBackImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedBackImage forState:UIControlStateHighlighted];
    return button;
}

#pragma mark - 文字
/** 普通文字 */
- (void)setNormalTitle:(NSString *)normalTitle {
    [self setTitle:normalTitle forState:UIControlStateNormal];
}
- (NSString *)normalTitle {
    if (!self.selected && !self.highlighted) {
        return self.titleLabel.text;
    }else {
        return nil;
    }
}
/** 高亮文字 */
- (void)setHighlightTitle:(NSString *)highlightTitle {
    [self setTitle:highlightTitle forState:UIControlStateHighlighted];
}
- (NSString *)highlightTitle {
    if (self.highlighted) {
        return self.titleLabel.text;
    }else {
        return nil;
    }
}
/** 选中文字 */
- (void)setSelectedTitle:(NSString *)selectedTitle {
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}
- (NSString *)selectedTitle {
    if (self.selected) {
        return self.titleLabel.text;
    }else {
        return nil;
    }
}

#pragma mark - 文字颜色
/** 普通文字颜色 */
- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}
- (UIColor *)normalTitleColor {
    if (!self.selected && !self.highlighted) {
        return self.titleLabel.textColor;
    }else {
        return nil;
    }
}

/** 高亮文字颜色 */
- (void)setHighlightTitleColor:(UIColor *)highlightTitleColor {
    [self setTitleColor:highlightTitleColor forState:UIControlStateHighlighted];
}
- (UIColor *)highlightTitleColor {
    if (self.highlighted) {
        return self.titleLabel.textColor;
    }else {
        return nil;
    }
}

/** 选中文字颜色 */
- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}
- (UIColor *)selectedTitleColor {
    if (self.selected) {
        return self.titleLabel.textColor;
    }else {
        return nil;
    }
}

#pragma mark - 图片
/** 普通图片 */
- (void)setNormalImage:(UIImage *)normalImage {
    [self setImage:normalImage forState:UIControlStateNormal];
}
- (UIImage *)normalImage {
    if (!self.selected && !self.highlighted) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

/** 高亮图片 */
- (void)setHighlightImage:(UIImage *)highlightImage {
    [self setImage:highlightImage forState:UIControlStateHighlighted];
}
- (UIImage *)highlightImage {
    if (self.highlighted) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

/** 选中图片 */
- (void)setSelectedImage:(UIImage *)selectedImage {
    [self setImage:selectedImage forState:UIControlStateSelected];
}
- (UIImage *)selectedImage {
    if (self.selected) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

#pragma mark - 背景图片
/** 普通背景图片 */
- (void)setNormalBackImage:(UIImage *)normalBackImage {
    [self setBackgroundImage:normalBackImage forState:UIControlStateNormal];
}
- (UIImage *)normalBackImage {
    if (!self.selected && !self.highlighted) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

/** 高亮背景图片 */
- (void)setHighlightBackImage:(UIImage *)highlightBackImage {
    [self setBackgroundImage:highlightBackImage forState:UIControlStateHighlighted];
}
- (UIImage *)highlightBackImage {
    if (self.highlighted) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

/** 选中背景图片 */
- (void)setSelectedBackImage:(UIImage *)selectedBackImage {
    [self setBackgroundImage:selectedBackImage forState:UIControlStateSelected];
}
- (UIImage *)selectedBackImage {
    if (self.selected) {
        return self.imageView.image;
    }else {
        return nil;
    }
}

#pragma mark - 本项目常用按钮样式
// 圆角背景图片按钮
+ (instancetype)backImageBtnNormalTitle:(NSString *)normalTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"nor_btn"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"hig_btn"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"sel_btn"] forState:UIControlStateSelected];
    return button;
}
// 直角背景图片按钮
+ (instancetype)rightAngleImageBtnNormalTitle:(NSString *)normalTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"angle_btn_nor"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"angle_btn_hig"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"angle_btn_dis"] forState:UIControlStateSelected];
    return button;
}




@end
