//
//  MYHorizontalProgressView.h
//  MYProgressView
//
//  Created by 伟南 陈 on 2017/4/12.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYHorizontalProgressView : UIView

@property (strong, nonatomic) UIColor *trackColor;
@property (strong, nonatomic) UIColor *progressColor;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
