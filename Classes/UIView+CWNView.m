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

- (void)setCornerRadius:(CGFloat)cornerRadius{
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置圆角
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}
- (CGFloat)cornerRadius{
    return  [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setBorderColor:(UIColor *)borderColor{
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    //设置边框颜色
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}
- (UIColor *)borderColor{
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark 布局操作器获取方法

#pragma mark -autolayout布局操作器获取方法

- (void)cwn_makeConstraints:(void (^)(UIView *))block{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    __weak typeof(self) weakSelf = self;
    block(weakSelf);
}

- (void)cwn_reMakeConstraints:(void (^)(UIView *))block{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    __weak typeof(self) weakSelf = self;
    UIView *superview = self.superview;
    if(superview){
        [self removeFromSuperview];
        [superview addSubview:self];
    }
    block(weakSelf);
}

#pragma mark -frame布局适配操作器获取方法

- (void)cwn_makeShiPeis:(void (^)(UIView *))block{
    __weak typeof(self) weakSelf = self;
    block(weakSelf);
}



#pragma mark - <********************************* autolayout布局 **********************************>
//maker操作器最近操作的一个约束
- (void)setLastConstraint:(NSLayoutConstraint *)lastConstraint{
    objc_setAssociatedObject(self, @selector(lastConstraint), lastConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSLayoutConstraint *)lastConstraint{
    NSLayoutConstraint *constraint = objc_getAssociatedObject(self, _cmd);
    return constraint;
}

//宽度约束
- (NSLayoutConstraint *)widthConstraint{
    __block NSLayoutConstraint *constraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeWidth && obj.secondItem == nil){
            constraint = obj;
            *stop = YES;
        }
    }];
    return constraint;
}
- (void)setWidthConstraint:(NSLayoutConstraint *)widthConstraint{
    objc_setAssociatedObject(self, @selector(widthConstraint), widthConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//高度约束
- (NSLayoutConstraint *)heightConstraint{
    __block NSLayoutConstraint *constraint = nil;
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeHeight && obj.secondItem == nil){
            constraint = obj;
            *stop = YES;
        }
    }];
    return constraint;
}
- (void)setHeightConstraint:(NSLayoutConstraint *)heightConstraint{
    objc_setAssociatedObject(self, @selector(heightConstraint), heightConstraint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *(^)(CGFloat constant))topToSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat constant) = ^(CGFloat constant){
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

- (void (^)(UIEdgeInsets))edgeInsetsToSuper{
    __weak typeof(self) weakSelf = self;
    void (^block)(UIEdgeInsets) = ^(UIEdgeInsets insets){
        [weakSelf setLayoutTopFromSuperViewWithConstant:insets.top];
        [weakSelf setLayoutRightFromSuperViewWithConstant:insets.right];
        [weakSelf setLayoutBottomFromSuperViewWithConstant:insets.bottom];
        [weakSelf setLayoutLeftFromSuperViewWithConstant:insets.left];
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))topTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutTop:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *targetView, CGFloat constant))topToTop{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *targetView, CGFloat constant) = ^(UIView *targetView, CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutTopToTop:targetView multiplier:1 constant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))leftTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutLeft:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))leftToLeft{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutLeftToLeft:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))bottomTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutBottom:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))bottomToBottom{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutBottomToBottom:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))rightTo{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutRight:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))rightToRight{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutRightToRight:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))widthValue{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutWidth:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))heightValue{
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

- (UIView *(^)(CGFloat, CGFloat))widthToHeight {
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat, CGFloat) = ^(CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutWidthToHeightWithMultiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat, CGFloat))heightToWidth {
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat, CGFloat) = ^(CGFloat m, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutHeightToWidthWithMultiplier:m constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerXtoSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterX:weakSelf.superview multiplier:1 constant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(CGFloat))centerYtoSuper{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(CGFloat) = ^(CGFloat constant){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterY:weakSelf.superview multiplier:1 constant:constant]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerXto{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *,CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterX:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)(UIView *, CGFloat))centerYto{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)(UIView *, CGFloat) = ^(UIView *targetView, CGFloat c){
        [weakSelf setLastConstraint:[weakSelf setLayoutCenterY:targetView multiplier:1 constant:c]];
        return weakSelf;
    };
    return block;
}

#pragma mark - <********************************* autolayout适配 **********************************>

- (UIView *(^)())shipeiAllSubViewsUsinglayout{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)() = ^{
        [weakSelf shiPeiAllSubViewsUsingLayout];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)())shiPeiAllSubViews_X_W_UsingLayout{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)() = ^{
        [weakSelf shiPeiAllSubView_X_W_UsingLayout];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)())shiPeiAllSubViews_Y_H_UsingLayout{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)() = ^(){
        [weakSelf shiPeiAllSubView_Y_H_UsingLayout];
        return weakSelf;
    };
    return block;
}



#pragma mark - <********************************* frame适配 **********************************>

- (UIView * (^)())shiPeiSelf{
    __weak typeof(self) weakSelf = self;
    UIView * (^block)() = ^{
        [weakSelf shiPeiSelf_X_Y_W_H];
        return weakSelf;
    };
    return block;
}
- (UIView *(^)())shiPeiSelf_XW{
    __weak typeof(self) weakSelf = self;
    UIView * (^block)() = ^{
        [weakSelf shiPeiSelf_X_W];
        return weakSelf;
    };
    return block;
}

- (UIView *(^)())shiPeiAllSubViews{
    __weak typeof(self) weakSelf = self;
    UIView * (^block)() = ^{
        [weakSelf shiPeiAllSubViews_X_Y_W_H];
        return weakSelf;
    };
    return block;
}
- (UIView *(^)())shiPeiAllSubViews_XW{
    __weak typeof(self) weakSelf = self;
    UIView *(^block)() = ^{
        [weakSelf shiPeiAllSubViews_X_W];
        return weakSelf;
    };
    return block;
}











#pragma mark - <********************************* 具体实现 **********************************>
#pragma mark -------------------------------------autolayout具体布局方法-------------------------------------------

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

- (NSLayoutConstraint *)setLayoutTopToTop:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeTop multiplier:multiplier constant:c];
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

- (NSLayoutConstraint *)setLayoutLeftToLeft:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeLeft multiplier:multiplier constant:c];
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

- (NSLayoutConstraint *)setLayoutRightToRight:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeRight multiplier:multiplier constant:c];
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

- (NSLayoutConstraint *)setLayoutBottomToBottom:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)neg_c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeBottom multiplier:multiplier constant:-neg_c];
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

- (NSLayoutConstraint *)setLayoutWidthToHeightWithMultiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:multiplier constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}
- (NSLayoutConstraint *)setLayoutHeightToWidthWithMultiplier:(CGFloat)multiplier constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:multiplier constant:c];
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

- (NSLayoutConstraint *)setLayoutCenterX:(UIView *)targetView multiplier:(CGFloat)m constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterX multiplier:m constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

- (NSLayoutConstraint *)setLayoutCenterY:(UIView *)targetView  multiplier:(CGFloat)m   constant:(CGFloat)c{
    NSLayoutConstraint *constraint;
    if (self.superview != nil) {
        constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:targetView attribute:NSLayoutAttributeCenterY multiplier:m constant:c];
        [self.superview addConstraint:constraint];
    }
    return constraint;
}

#pragma mark -------------------------------------autolayout具体适配方法-------------------------------------------

- (void)shiPeiAllSubViewsUsingLayout{//全部适配(自己的宽高约束、和其他控件间的约束)
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setAdapterScreen:YES];
    }];
    
    [self shiPeiSubViewUsingLayout:self];
}
- (void)shiPeiSubViewUsingLayout:(UIView *)targetView{
    //TODO: 递归适配所有视图xywh
    [[targetView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj shiPeiAllSubViewsUsingLayout];
    }];
}

- (void)shiPeiAllSubView_X_W_UsingLayout{//水平适配
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if((obj.firstAttribute == NSLayoutAttributeLeft) || obj.firstAttribute == NSLayoutAttributeRight || obj.firstAttribute == NSLayoutAttributeLeading || obj.firstAttribute == NSLayoutAttributeTrailing || obj.firstAttribute == NSLayoutAttributeWidth || obj.firstAttribute == NSLayoutAttributeCenterX){
            [obj setAdapterScreen:YES];
        }
    }];
    
    [self shiPeiAllSubViews_X_W_UsingLayout:self];
}
- (void)shiPeiAllSubViews_X_W_UsingLayout:(UIView *)targetView{
    //TODO: 递归适配所有视图xw
    [[targetView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj shiPeiAllSubView_X_W_UsingLayout];
    }];
}

- (void)shiPeiAllSubView_Y_H_UsingLayout{//竖直适配
    [self.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(obj.firstAttribute == NSLayoutAttributeTop || obj.firstAttribute == NSLayoutAttributeBottom || obj.firstAttribute == NSLayoutAttributeHeight || obj.firstAttribute == NSLayoutAttributeCenterY){
            [obj setAdapterScreen:YES];
        }
    }];
    
    [self shiPeiAllSubViews_Y_H_UsingLayout:self];
}
- (void)shiPeiAllSubViews_Y_H_UsingLayout:(UIView *)targetView{
    //TODO: 递归适配所有视图yh
    [[targetView subviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj shiPeiAllSubView_Y_H_UsingLayout];
    }];
}


#pragma mark -------------------------------------frame具体适配方法-------------------------------------------

- (void)shiPeiSelf_X_Y_W_H{
    self.frame = CGRectMake(SHIPEI(self.frame.origin.x), SHIPEI(self.frame.origin.y), SHIPEI(self.frame.size.width), SHIPEI(self.frame.size.height));
}
- (void)shiPeiSelf_X_W{
    self.frame = CGRectMake(SHIPEI(self.frame.origin.x), self.frame.origin.y, SHIPEI(self.frame.size.width), self.frame.size.height);
}

- (void)shiPeiAllSubViews_X_Y_W_H{
    [self shiPeiSubView:self];
}

- (void)shiPeiAllSubViews_X_W{
    [self shiPeiSubView_X_W:self];
}


- (void)shiPeiSubView:(UIView *)targetView{
    //TODO: 递归适配所有视图xywh
    __weak typeof(self) weakSelf = self;
    [targetView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SHIPEI(obj.frame.origin.x), SHIPEI(obj.frame.origin.y), SHIPEI(obj.frame.size.width), SHIPEI(obj.frame.size.height));
        [weakSelf shiPeiSubView:obj];
    }];
}

- (void)shiPeiSubView_X_W:(UIView *)targetView{
    //TODO: 递归适配所有视图xw
    __weak typeof(self) weakSelf = self;
    [targetView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(SHIPEI(obj.frame.origin.x), obj.frame.origin.y, SHIPEI(obj.frame.size.width), obj.frame.size.height);
        [weakSelf shiPeiSubView_X_W:obj];
    }];
}






#pragma mark - <************************** xib中进行字体大小、水平竖直方向约束适配 **************************>
#pragma mark - 全部适配
- (void)setAdapterFont:(BOOL)adapterFont{
    objc_setAssociatedObject(self, @selector(adapterFont), [NSNumber numberWithBool:adapterFont], OBJC_ASSOCIATION_RETAIN);
    if(adapterFont){
        if ([self isKindOfClass:[UILabel class]]) {
            UILabel * label = (UILabel *)self;
            CGFloat fontSize = label.font.pointSize;
            //创建一个新的字体相同当前字体除了指定的大小
            label.font = [label.font fontWithSize:SHIPEI(fontSize)];
        }
        if ([self isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)self;
            CGFloat fontSize = button.titleLabel.font.pointSize;
            //创建一个新的字体相同当前字体除了指定的大小
            button.titleLabel.font = [button.titleLabel.font fontWithSize:SHIPEI(fontSize)];
        }
        if ([self isKindOfClass:[UITextField class]]) {
            UITextField * button = (UITextField *)self;
            CGFloat fontSize = button.font.pointSize;
            //创建一个新的字体相同当前字体除了指定的大小
            button.font = [button.font fontWithSize:SHIPEI(fontSize)];
        }
    }
}
- (BOOL)adapterFont{
    BOOL adapterFont = [objc_getAssociatedObject(self, _cmd) boolValue];
    return adapterFont;
}
#pragma mark - 全部适配
- (void)setAdapterHVConstraints:(BOOL)adapterHVConstraints{
    objc_setAssociatedObject(self, @selector(adapterHVConstraints), [NSNumber numberWithBool:adapterHVConstraints], OBJC_ASSOCIATION_RETAIN);
    if(adapterHVConstraints){
        self.shipeiAllSubViewsUsinglayout();
    }
}
- (BOOL)adapterHVConstraints{
    BOOL adapterHVConstraints = [objc_getAssociatedObject(self, _cmd) boolValue];
    return adapterHVConstraints;
}
#pragma mark - 水平适配
- (void)setAdapterHConstraints:(BOOL)adapterHConstraints{
    if (self.adapterHConstraints) {
        return;
    }
    objc_setAssociatedObject(self, @selector(adapterHConstraints), [NSNumber numberWithBool:adapterHConstraints], OBJC_ASSOCIATION_RETAIN);
    if(adapterHConstraints){
        self.shiPeiAllSubViews_X_W_UsingLayout();
    }
}
- (BOOL)adapterHConstraints{
    BOOL adapterHConstraints = [objc_getAssociatedObject(self, _cmd) boolValue];
    return adapterHConstraints;
}

#pragma mark - 竖直适配
- (void)setAdapterVConstraints:(BOOL)adapterVConstraints{
    if (self.adapterVConstraints) {
        return;
    }
    objc_setAssociatedObject(self, @selector(adapterVConstraints), [NSNumber numberWithBool:adapterVConstraints], OBJC_ASSOCIATION_RETAIN);
    if(adapterVConstraints){
        self.shiPeiAllSubViews_Y_H_UsingLayout();
    }
}
- (BOOL)adapterVConstraints{
    BOOL adapterVConstraints = [objc_getAssociatedObject(self, _cmd) boolValue];
    return adapterVConstraints;
}
@end


#pragma mark - <************************** xib中进行单个约束适配 **************************>
@implementation NSLayoutConstraint (IBDesignable)
-  (void)setAdapterScreen:(BOOL)adapterScreen{
    objc_setAssociatedObject(self, @selector(adapterScreen), [NSNumber numberWithBool:adapterScreen], OBJC_ASSOCIATION_RETAIN);
    if(adapterScreen){
        self.constant =  SHIPEI(self.constant);
    }
}
-  (BOOL)adapterScreen{
    BOOL adapterScreen = [objc_getAssociatedObject(self, _cmd) boolValue];
    return adapterScreen;
}

@end





