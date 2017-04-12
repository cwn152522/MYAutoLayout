//
//  UIView+CWNView.h
//  NSLayout封装
//
//  Created by 陈伟南 on 15/12/29.
//  Copyright © 2015年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author 陈伟南, 17-04-11 22:05:55
 *
 *  引入链式编程思想，进一步简化autolayout代码
 *
 *
 * @note  关于constant符号说明：
 *
                (1)所有方法传入的constant均传正数即可，部分方法内部需使用负数时会自动转换。
 *             (2)当外界需对某个约束进行更新时(改变约束的constant)，这时候就得注意正负值了。
 *             (3)constant正负取决于参照视图和自身的位置关系，比如:a.right = b.left + constant，这个约束表示a的右边距离b的左边constant处。如果你希望a和b间关系是相离，那么constant得为负数，因为如果是正数的话a和b就相交了。
 */


@interface UIView (CWNView)

/**
 * autolayout布局创建方法
 *
 * @ param maker    待约束视图，即自身
 */
- (void)cwn_makeConstraints:(void (^)(UIView *maker))block;


#pragma mark 具体约束设置方法(分新旧两套)，根据个人喜好，自行选择

//---------------------------------------------新版本链式编程------------------------------------------------

/**
 * 最新创建的一个约束获取方法
 *
 * @note 这个约束只记录以下方法执行结束时产生的约束，是个临时值
 * @note 用途：动态更新，需先定义变量进行存储
 */
@property (strong, nonatomic) NSLayoutConstraint *lastConstraint;

/**
 *  控件相对父视图约束设置方法
 *
 * @ param constant  上下左右相对父视图的距离
 */
- (UIView *(^)(CGFloat constant))topToSuper;
- (UIView *(^)(CGFloat constant))leftToSuper;
- (UIView *(^)(CGFloat constant))rightToSuper;
- (UIView *(^)(CGFloat constant))bottomToSuper;

/**
 *  控件间相对约束设置方法
 *
 * @ param targetView    参照视图
 * @ param multiplier   比例
 * @ param constant      常数
 * @ note   setLayoutLeft:方法相对的是参照视图的Right，其他方法同理
 */
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))topTo;
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))leftTo;
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))rightTo;
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))bottomTo;

/**
 *  控件宽高的约束设置方法
 *
 * @ param targetView     参照视图
 * @ param multiplier   比例
 * @ param constant    常数
 */
- (UIView *(^)(CGFloat constant))width;
- (UIView *(^)(CGFloat constant))height;
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))widthTo;
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))heightTo;

/**
 *  控件中心对齐约束设置方法
 *
 * @ param targetView    参照视图
 * @ param constant   常数
 */
- (UIView *(^)(CGFloat constant))centerXtoSuper;
- (UIView *(^)(CGFloat constant))centerYtoSuper;
- (UIView *(^)(UIView *targetView, CGFloat constant))centerXto;
- (UIView *(^)(UIView *targetView, CGFloat constant))centerYto;


//---------------------------------------------旧版本------------------------------------------------

- (NSLayoutConstraint *)setLayoutLeftFromSuperViewWithConstant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutTopFromSuperViewWithConstant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutRightFromSuperViewWithConstant:(CGFloat)neg_c;
- (NSLayoutConstraint *)setLayoutBottomFromSuperViewWithConstant:(CGFloat)neg_c;

- (NSLayoutConstraint *)setLayoutLeft:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutTop:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutRight:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)neg_c;
- (NSLayoutConstraint *)setLayoutBottom:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)neg_c;

- (NSLayoutConstraint *)setLayoutWidth:(CGFloat)width;
- (NSLayoutConstraint *)setLayoutHeight:(CGFloat)height;
- (NSLayoutConstraint *)setLayoutWidth:(UIView *)targetView multiplier:(CGFloat)multiplier constant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutHeight:(UIView *)targetView  multiplier:(CGFloat)multiplier constant:(CGFloat)c;

- (NSLayoutConstraint *)setLayoutCenterX:(UIView *)targetView;
- (NSLayoutConstraint *)setLayoutCenterY:(UIView *)targetView;
- (NSLayoutConstraint *)setLayoutCenterX:(UIView *)targetView constant:(CGFloat)c;
- (NSLayoutConstraint *)setLayoutCenterY:(UIView *)targetView constant:(CGFloat)c;

@end
