//
//  FirstViewCell.m
//  transferLabel
//
//  Created by 吕涛 on 16/7/28.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "FirstViewCell.h"

@implementation FirstViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//
//-(void)drawRect:(CGRect)rect{
//    
//    CGPoint startP = CGPointMake(self.frame.size.width-2, 0);
//    CGPoint endP = CGPointMake(self.frame.size.width-2, self.frame.size.height - 5);
//    
//    CGContextRef context = UIGraphicsGetCurrentContext();
////    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
////    CGContextFillRect(context, self.bounds);
//    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
//    CGContextMoveToPoint(context, startP.x, startP.y);
//    CGContextAddLineToPoint(context, endP.x, endP.y);
//    
//    CGContextStrokePath(context);
//    
//}

@end
