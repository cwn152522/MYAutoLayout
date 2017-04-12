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

@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) UIView *blueView;

@property (strong, nonatomic) NSLayoutConstraint *redViewTop;//红色视图距离父视图视图顶部约束
@property (strong, nonatomic) NSLayoutConstraint *blueViewHeight;//蓝色视图高度约束

@property (strong, nonatomic) MYHorizontalProgressView *progressView;//可以控制高度的进度条(基于系统控件UIProgressView)

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    [self.view addSubview:self.redView];
    [self.view addSubview:self.progressView];
    [self.view addSubview:self.blueView];
    
    
    //新版本实现
    [_redView cwn_makeConstraints:^(UIView *maker) {
        weakSelf.redViewTop = maker.topToSuper(10).lastConstraint;//记住需动态更新的约束
        maker.leftToSuper(20);
        maker.centerXtoSuper(0);
        maker.bottomTo(weakSelf.progressView, 1, 10);
//     maker.leftToSuper(20).centerXtoSuper(0).bottomTo(weakSelf.progressView, 1, 10);//链式
    }];
    
    _redViewTop.constant = 20;//动态更新约束
    
    
    [self.progressView cwn_makeConstraints:^(UIView *maker) {
        maker.leftToSuper(20).rightToSuper(20).height(10).bottomTo(weakSelf.blueView, 1, 10);
    }];

    
    //旧版本实现
    [_blueView cwn_makeConstraints:^(UIView *maker) {
        [maker setLayoutLeftFromSuperViewWithConstant:20];
        [maker setLayoutRightFromSuperViewWithConstant:20];
        [maker setLayoutBottomFromSuperViewWithConstant:20];
        weakSelf.blueViewHeight = [maker setLayoutHeight:200];//记住需动态更新的约束
//    maker.leftToSuper(20).rightToSuper(20).bottomToSuper(20).height(200);  链式
    }];
    
    _blueViewHeight.constant = 150;//动态更新约束
    

    
    [self.progressView setProgress:0.5 animated:YES];
}


#pragma mark 控件get方法

- (UIView *)redView{
    if(!_redView){
        _redView = [[UIView alloc] init];
        _redView.backgroundColor = [UIColor redColor];
    }
    return _redView;
}

- (MYHorizontalProgressView *)progressView{
    if(!_progressView){
        _progressView = [[MYHorizontalProgressView alloc] init];
    }
    return _progressView;
}

- (UIView *)blueView{
    if(!_blueView){
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor = [UIColor blueColor];
    }
    return _blueView;
}

@end
