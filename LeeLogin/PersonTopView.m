//
//  PersonTopView.m
//  transferLabel
//
//  Created by 吕涛 on 16/7/28.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "PersonTopView.h"
#import "Masonry.h"
@implementation PersonTopView
{
    float _viewWidth;
    float _viewHeight;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _viewWidth = frame.size.width;
        _viewHeight = frame.size.height;
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageNamed:@"indexbg"];
        [self personNameAndMemberLv];
        [self personHeader];
        
    }
    return self;
}

#pragma mark == 头像
-(void)personHeader{
    float width = _viewWidth/4;
    
    self.headerV = [[UIImageView alloc]init];
    
    __weak typeof(self) weakSelf = self;
    self.headerV.image = [UIImage imageNamed:@"txbk" ];
    [self addSubview:self.headerV];
    [weakSelf.headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
//        make.bottom.equalTo(weakSelf.labelName.mas_top).offset(-10);
        make.centerY.equalTo(@(-10));
        make.size.mas_equalTo(CGSizeMake(width, width));
    }];

    
    self.photoView = [[UIImageView alloc]init];
    self.photoView.image = [UIImage imageNamed:@"biao02"];
    self.photoView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.photoView.layer.borderWidth = 1.0;
    NSLog(@"=======%@",self.headerV);
    self.photoView.layer.cornerRadius = (width-5)/2;

    self.photoView.clipsToBounds = YES;
    [self.headerV addSubview:self.photoView];

    [weakSelf.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(5));
        make.left.equalTo(@(5));
        make.right.equalTo(@(-5));
        make.bottom.equalTo(@(-5));
    }];

    
}
//nickName and member lv
-(void)personNameAndMemberLv{
    float width = _viewWidth/4;
    
    self.labelName = [[UILabel alloc]init];
    self.labelName.textColor = [UIColor whiteColor];
    self.labelName.textAlignment = NSTextAlignmentCenter;
    self.labelName.font = [UIFont boldSystemFontOfSize:15];
    
    self.labelMemberLv = [[UILabel alloc]init];
    self.labelMemberLv.textColor = [UIColor whiteColor];
    self.labelMemberLv.textAlignment = NSTextAlignmentCenter;
    self.labelMemberLv.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:self.labelMemberLv];
    [self addSubview:self.labelName];
    
    __weak typeof(self) weakSelf = self;

    [weakSelf.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(weakSelf.labelMemberLv.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(width, 20));
    }];

    [weakSelf.labelMemberLv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.bottom.equalTo(@(-10));
        make.size.mas_equalTo(CGSizeMake(width, 20));
    }];
    


}

//#pragma mark == 画圆
//-(void)drawRect:(CGRect)rect{
//    
//    CGContextRef contextother = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(contextother, 1,1,1,1.0);
//    CGContextSetLineWidth(contextother, 1.0);
//    CGContextAddArc(contextother, _viewWidth/2, 45+_viewWidth/8, _viewWidth/8+5, 0, M_PI * 2, 0);
//    CGContextDrawPath(contextother, kCGPathStroke);
//    
//}

@end
