//
//  Refuse AlertView.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "RefuseAlertView.h"

@implementation RefuseAlertView

- (IBAction)cdcard:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)photo:(UIButton *)sender {
    sender.selected = !sender.selected;

}

- (IBAction)name:(UIButton *)sender {
    
    sender.selected = !sender.selected;

}
- (IBAction)sure:(UIButton *)sender {
    self.block();
    [self removeFromSuperview];
}

@end
