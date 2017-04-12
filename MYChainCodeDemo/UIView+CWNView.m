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
    block(self);
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
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
       [self setLastConstraint:[self setLayoutTopFromSuperViewWithConstant:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))leftToSuper{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutLeftFromSuperViewWithConstant:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))bottomToSuper{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
       [self setLastConstraint:[self setLayoutBottomFromSuperViewWithConstant:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))rightToSuper{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutRightFromSuperViewWithConstant:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))topTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutTop:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))leftTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutLeft:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))bottomTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutBottom:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))rightTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutRight:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))width{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutWidth:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))height{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutHeight:constant]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))widthTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutWidth:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat, CGFloat))heightTo{
    UIView *(^block)(UIView *, CGFloat, CGFloat) = ^(UIView *targetView, CGFloat m, CGFloat c){
        [self setLastConstraint:[self setLayoutHeight:targetView multiplier:m constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerXtoSuper{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutCenterX:self.superview]];
        return self;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerYtoSuper{
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [self setLastConstraint:[self setLayoutCenterY:self.superview]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerXto{
    UIView *(^block)(UIView *,CGFloat) = ^(UIView *targetView, CGFloat c){
        [self setLastConstraint:[self setLayoutCenterX:targetView constant:c]];
        return self;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerYto{
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [self setLastConstraint:[self setLayoutCenterY:targetView constant:c]];
        return self;
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
