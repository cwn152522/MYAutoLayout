//
//  ViewController.m
//  MYChainCodeDemo
//
//  Created by 伟南 陈 on 2017/4/11.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "ViewController.h"
#import "UIView+CWNView.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *blueView;

@property (strong, nonatomic) NSLayoutConstraint *redViewTop;//红色视图距离父视图视图顶部约束
@property (strong, nonatomic) NSLayoutConstraint *blueViewHeight;//蓝色视图高度约束

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.redView];
    [self.view addSubview:self.blueView];
    
    
    //新版本实现
    [_redView cwn_makeConstraints:^(UIView *maker) {
        weakSelf.redViewTop = maker.topToSuper(20).lastConstraint;//记住需动态更新的约束
        maker.leftToSuper(20);
        maker.centerXtoSuper(0);
        maker.bottomTo(weakSelf.blueView, 1, 20);
//     maker.leftToSuper(20).centerXtoSuper(0).bottomTo(weakSelf.blueView, 1, 20);  链式
    }];
    
    _redViewTop.constant = 30;//动态更新约束

    
    //旧版本实现
    [_blueView cwn_makeConstraints:^(UIView *maker) {
        [maker setLayoutLeftFromSuperViewWithConstant:20];
        [maker setLayoutRightFromSuperViewWithConstant:20];
        [maker setLayoutBottomFromSuperViewWithConstant:20];
        weakSelf.blueViewHeight = [maker setLayoutHeight:200];//记住需动态更新的约束
//    maker.leftToSuper(20).rightToSuper(20).bottomToSuper(20).height(200);  链式
    }];
    
    _blueViewHeight.constant = 150;//动态更新约束
}


#pragma mark 控件get方法

- (UIView *)redView{
    if(!_redView){
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (UIView *)blueView{
    if(!_blueView){
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

@end
