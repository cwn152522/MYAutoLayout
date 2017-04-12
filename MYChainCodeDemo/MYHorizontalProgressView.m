//
//  MYHorizontalProgressView.m
//  MYProgressView
//
//  Created by 伟南 陈 on 2017/4/12.
//  Copyright © 2017年 chenweinan. All rights reserved.
//

#import "MYHorizontalProgressView.h"
#import "UIView+CWNView.h"

#define RGBColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]

@interface MYHorizontalProgressView ()

@property (strong, nonatomic) UIProgressView *progressView;

@property (assign, nonatomic) BOOL didLayout;

@end

@implementation MYHorizontalProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.progressView = [[UIProgressView alloc] init];
        [self addSubview:self.progressView];
        
        //autolayout代码
        [self.progressView cwn_makeConstraints:^(UIView *maker) {
            maker.topToSuper(0).bottomToSuper(0).leftToSuper(0).rightToSuper(0);
        }];
    }
    return self;
}

- (void)setProgressColor:(UIColor *)progressColor{
    _progressColor = progressColor;
    self.progressView.progressImage = [self changeColorToImageWithColor:progressColor];
}

- (void)setTrackColor:(UIColor *)trackColor{
    _trackColor = trackColor;
    self.progressView.trackImage = [self changeColorToImageWithColor:trackColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated{
//    static BOOL didLayout = NO;
    if(self.didLayout == NO){
        [self layoutIfNeeded];
        self.didLayout = YES;
        CGFloat height = CGRectGetHeight(self.frame);
        
        self.layer.cornerRadius = height / 2.0;
        self.layer.masksToBounds = YES;
        self.layer.allowsEdgeAntialiasing = YES;
        
        self.progressView.backgroundColor = [UIColor redColor];
        self.progressView.trackImage = [self changeColorToImageWithColor:HexColor(0xecf0f1)];
        self.progressView.progressImage = [self changeColorToImageWithColor:HexColor(0xcd0000)];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, height / 2.0);
    }

    [self.progressView setProgress:progress animated:animated];
}

#pragma mark private methods

- (UIImage *)changeColorToImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 10, 10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
