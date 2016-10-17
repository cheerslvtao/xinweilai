//
//  FirstViewCell.h
//  transferLabel
//
//  Created by 吕涛 on 16/7/28.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *flagView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *value;
@end
