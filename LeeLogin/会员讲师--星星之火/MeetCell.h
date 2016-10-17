//
//  MeetCell.h
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *meetTitle;
@property (weak, nonatomic) IBOutlet UILabel *meetTime;
@property (weak, nonatomic) IBOutlet UILabel *meetOwner;

@property (weak, nonatomic) IBOutlet UILabel *meetStatus;
@property (weak, nonatomic) IBOutlet UILabel *publishTime;

@end
