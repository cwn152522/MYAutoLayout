//
//  UIView+CWNView.m
//  NSLayout封装
//
//  Created by 陈伟南 on 15/12/29.
//  Copyright © 2015年 陈伟南. All rights reserved.
//

#import "UIView+CWNView.h"
#import <objc/runtime.h>

@implementation UIView (CWNView)

#pragma mark -autolayout布局创建方法-

- (void)cwn_makeConstraints:(void (^)(UIView *))block{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    __weak typeof(self) weakSelf = self;
    block(weakSelf);
}


#pragma mark -新版本链式编程方法-

- (void)setLastConstraint:(NSLayoutConstraint *)lastConstraint{
    objc_setAssociatedObject(self, @selector(lastConstraint), lastConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)lastConstraint{
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    return constraint;
}

- (UIView *(^)(CGFloat))topToSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutTopFromSuperViewWithConstant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))leftToSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutLeftFromSuperViewWithConstant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))bottomToSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutBottomFromSuperViewWithConstant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))rightToSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutRightFromSuperViewWithConstant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))topTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutTop:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))leftTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutLeft:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))bottomTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutBottom:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))rightTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutRight:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))width{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutWidth:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))height{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutHeight:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))widthTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutWidth:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))heightTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutHeight:targetView multiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerXtoSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterX:weakSelf.superview]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerYtoSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterY:weakSelf.superview]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerXto{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *,CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterX:targetView constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerYto{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterY:targetView constant:c]];
        return weakSelf;
    };
    return block;
}


#pragma mark -旧版本方法-

- (NSLayoutConstraint *)setLayoutTopFromSuperViewWithConstant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeTop multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutLeftFromSuperViewWithConstant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeLeft multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutBottomFromSuperViewWithConstant:(CGFloat)neg_c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-neg_c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutRightFromSuperViewWithConstant:(CGFloat)neg_c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeRight multiplier:1.0f constant:-neg_c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutTop:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutLeft:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutBottom:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)neg_c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:multiplier constant:-neg_c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutRight:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)neg_c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:multiplier constant:-neg_c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutWidth:(CGFloat)width{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:width];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutHeight:(CGFloat)height{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:height];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutWidth:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeWidth multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutHeight:(UIView *)targetView  multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeHeight multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutCenterX:(UIView *)targetView{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutCenterY:(UIView *)targetView{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutCenterX:(UIView *)targetView constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutCenterY:(UIView *)targetView  constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

@end
