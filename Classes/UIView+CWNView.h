//
//  UIView+CWNView.h
//  NSLayout封装
//
//  Created by 陈伟南 on 15/12/29.
//  Copyright © 2015年 陈伟南. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SHIPEI(a)  [UIScreen mainScreen].bounds.size.width/375.0*a
/**
 *  @author 陈伟南, 17-04-11 22:05:55
 *
 *  引入链式编程思想，进一步简化autolayout代码
 *
 * @note  关于constant符号说明：
 *             (1)所有方法传入的constant均传正数即可，部分方法内部需使用负数时会自动转换。
 *             (2)当外界需对某个约束进行更新时(改变约束的constant)，这时候就得注意正负值了。
 *
 *
 *
 *
 *  @author 陈伟南, 17-04-28 13:58:34
 *
 *  新增frame布局的适配方法，目前提供相对父布局的便捷适配
 *
 *
 *
 *
 *  @author 陈伟南, 17-12-14 11:21:55
 *
 *  不再提供普通方法进行约束布局、适配，，，，约束布局、适配统一采用链式方法
 *
 *
 *
 *
 *  @author 陈伟南, 18-03-09 10:50:32
 *
 *  1.支持相对对齐约束leftToLeft、rightToRight等的设置
 *  2.支持约束重建，使用cwn_reMakeConstraints获取操作器即可
 *  3.支持在代码中进行全部约束适配、水平、竖直方向约束单独适配
 *  4.支持控件width、height约束的快速获取，可以定位xib中的对应约束，进行修改
 *  5.支持相对父视图top、bottom、right、left的约束快速创建：edgeInsetsToSuper
 *
 *
 *
 *
 * @author 陈伟南,19-04-15
 *
 * 1.支持在xib中进行单个约束的适配
 * 2.支持在xib中进行视图的相关适配
 * 3.支持在xib中进行字体的适配
 */


IB_DESIGNABLE
@interface UIView (CWNView)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

#pragma mark 布局操作器获取方法，在block里调用具体布局方法进行布局

/**
 * autolayout布局操作器获取方法
 *
 * @ param maker    待约束视图，即自身
 */
- (void)cwn_makeConstraints:(void (^)(UIView *maker))block;
- (void)cwn_reMakeConstraints:(void (^)(UIView *maker))block;

/**
 * frame布局适配操作器获取方法
 *
 * @ param maker    待适配视图，即自身
 */
- (void)cwn_makeShiPeis:(void (^)(UIView *maker))block;


#pragma mark ----------------------------------autolayout布局-------------------------------------
/**
 * @note 适用于布局内控件间有特定的位置关系且所有控件大小不需适配的场景，比如顶部导航的封装(控件大小固定、中间文本居中、左按钮居左、右按钮居右)、高度固定的自定义cell布局等
 */

/**
 * 最新创建的一个约束获取方法
 *
 * @note 这个约束只记录以下方法执行结束时产生的约束，是个临时值
 * @note 用途：动态更新，需先定义变量进行存储
 */
@property (strong, nonatomic) NSLayoutConstraint *lastConstraint;
/**
 * 控件的宽度约束(可能是xib或代码创建的)
 */
@property (strong, nonatomic) NSLayoutConstraint *widthConstraint;
/**
 * 控件的高度约束(可能是xib或代码创建的)
 */
@property (strong, nonatomic) NSLayoutConstraint *heightConstraint;










/**
 当前视图top相对父视图的top，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))topToSuper;
/**
 当前视图left相对父视图的left，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))leftToSuper;
/**
 当前视图right相对父视图的right，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))rightToSuper;
/**
 当前视图bottom相对父视图的bottom，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))bottomToSuper;
/**
 当前视图edgeInsets相对父视图的edgeInsets，参数为(UIEdgeInsets)
 */
- (void(^)(UIEdgeInsets edgeInsets))edgeInsetsToSuper;


/**
 当前视图top相对targetView的bottom，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))topTo;
/**
 当前视图top相对targetView的top，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))topToTop;
/**
 当前视图left相对targetView的right，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))leftTo;
/**
 当前视图left相对targetView的left，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))leftToLeft;
/**
 当前视图right相对targetView的left，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))rightTo;
/**
 当前视图right相对targetView的right，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))rightToRight;
/**
 当前视图bottom相对targetView的top，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))bottomTo;
/**
 当前视图bottom相对targetView的bottom，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))bottomToBottom;


/**
 当前视图width，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))widthValue;
/**
 当前视图height，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))heightValue;
/**
 当前视图width相对于targetView的width，参数为(targetView, multiplier, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))widthTo;
/**
 当前视图height相对于targetView的height，参数为(targetView, multiplier, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat multiplier, CGFloat constant))heightTo;
/**
 当前视图width相对于targetView的height，参数为(targetView, multiplier, constant)
 */
- (UIView *(^)(CGFloat multiplier, CGFloat constant))widthToHeight;
/**
 当前视图height相对于targetView的width，参数为(targetView, multiplier, constant)
 */
- (UIView *(^)(CGFloat multiplier, CGFloat constant))heightToWidth;


/**
 当前视图centerX相对于父视图的centerX，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))centerXtoSuper;
/**
 当前视图centerY相对于父视图的centerY，参数为(constant)
 */
- (UIView *(^)(CGFloat constant))centerYtoSuper;
/**
 当前视图centerX相对于targetView的centerX，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView,  CGFloat constant))centerXto;
/**
 当前视图centerY相对于targetView的centerY，参数为(targetView, constant)
 */
- (UIView *(^)(UIView *targetView, CGFloat constant))centerYto;















#pragma mark ----------------------------------autolayout适配-------------------------------------

- (UIView *(^)())shipeiAllSubViewsUsinglayout;//全部适配
- (UIView *(^)())shiPeiAllSubViews_X_W_UsingLayout;//适配水平约束
- (UIView *(^)())shiPeiAllSubViews_Y_H_UsingLayout;//适配竖直约束


#pragma mark ----------------------------------frame适配-------------------------------------
/**
 * frame相对父布局适配
 *
 * @note 将指定view及其subview(iphone6下进行frame布局的)的frame参数均乘以适配参数(当前屏幕的宽度和iphone6的宽度比)进行适配
 * @note 适用于布局内控件相对父控件有特定的位置关系且所有控件大小均需适配的场景，比如中间弹窗提示类情景、高度不固定的自定义cell布局等
 * @note 建议storyboard或xib下用autolayout布局完成(按ui设计调好)后，禁用autolayout(移除所有约束)，然后代码中通过执行以下两个接口，确保所有控件的frame都适配好。
 */

/**
 * 相对父布局适配之父视图适配
 */
- (UIView * (^)())shiPeiSelf;
- (UIView *(^)())shiPeiSelf_XW;

/**
 * 相对父布局适配子视图深度遍历frame适配
 */
- (UIView *(^)())shiPeiAllSubViews;
- (UIView *(^)())shiPeiAllSubViews_XW;







#pragma mark - <************************** xib中进行字体大小、水平竖直方向约束适配 **************************>
//xib字体大小适配
@property(assign, nonatomic) IBInspectable BOOL adapterFont;//字体大小适配
//xib约束适配
@property(assign, nonatomic) IBInspectable BOOL adapterHConstraints;//水平方向所有约束适配
@property(assign, nonatomic) IBInspectable BOOL adapterVConstraints;//竖直方向所有约束适配
@property(assign, nonatomic) IBInspectable BOOL adapterHVConstraints;//相当于adapterHScreen+adapterVScreen
@end

#pragma mark - <************************** xib中进行单个约束适配 **************************>
@interface NSLayoutConstraint (IBDesignable)
//单个约束适配
@property(assign, nonatomic) IBInspectable BOOL adapterScreen;//单个约束的适配
@end
