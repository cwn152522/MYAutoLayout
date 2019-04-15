//
//  ViewController.m
//  MYChainCodeDemo
//
//  Created by 伟南 陈 on 2017/4/11.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "ViewController.h"
#import "MYHorizontalProgressView.h"
#import "UIView+CWNView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIButton *centerbtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    
    //定位xib中的宽度、高度约束
    self.centerView.widthConstraint.constant = 300;
    self.centerView.heightConstraint.constant = 300;
    [UIView animateWithDuration:3 animations:^{
        [weakSelf.centerView.superview layoutIfNeeded];
    }];
    
    //重新做xib中的控件约束
    [self.centerbtn cwn_reMakeConstraints:^(UIView *maker) {
        maker.centerXtoSuper(1, 0).topToSuper(5);
//        maker.edgeInsetsToSuper(U3IEdgeInsetsMake(50, 50, 50, 50));
    }];
    NSLog(@"本来中心对齐的，变成距顶部5");
    
    
    //适配
    //全部适配
//    NSLog(@"全部适配前width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
//    [self.centerView cwn_makeShiPeis:^(UIView *maker) {
//        maker.shipeiAllSubViewsUsinglayout();
//    }];
//    NSLog(@"全部适配后width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
    
    //水平适配
//    NSLog(@"水平适配前width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
//    [self.centerView cwn_makeShiPeis:^(UIView *maker) {
//        maker.shiPeiAllSubViews_X_W_UsingLayout();
//    }];
//    NSLog(@"水平适配后width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
    
    //竖直方向适配
    NSLog(@"竖直适配前width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
    [self.centerView cwn_makeShiPeis:^(UIView *maker) {
        maker.shiPeiAllSubViews_Y_H_UsingLayout();
    }];
    NSLog(@"竖直适配后width：%f height:%f", self.centerView.widthConstraint.constant, self.centerView.heightConstraint.constant);
}

@end
