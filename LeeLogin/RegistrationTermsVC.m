
//
//  RegistrationTermsVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RegistrationTermsVC.h"

@interface RegistrationTermsVC ()

@end

@implementation RegistrationTermsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册条款
   
    self.title = @"注册条款";
    self.view.backgroundColor = COLOR(244, 245, 247, 1);
    [self addView];
    // Do any additional setup after loading the view.
}
- (void)addView
{
    UIScrollView *scrollView = [LeeAllView BGScrollViewWith:CGRectMake(0, 135, SCREEN_width, SCREEN_height-225)];
    [self.view addSubview:scrollView];
    UILabel *titelLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEN_width, 30)];
    titelLable.text = @"心未来互联网平台注册服务条款";
    titelLable.textAlignment = NSTextAlignmentCenter;
    titelLable.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:titelLable];
    UILabel *contenLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 500)];
    contenLabel.backgroundColor = [UIColor whiteColor];
    contenLabel.text =@"      我自愿成为一名遵纪守法，诚信共赢，爱国爱家爱自己的创业者，本着改变自己，服务他人的原则，遵循心未来互联平台规则（包含但不仅限于以下几点）：\n\t一、16周岁以下会员只能在监护人的陪同并允许下，从事学习和体验式劳动（比如开心农场），和参加一些正能量的活动（比如遵守交规，献爱心等）给予积分和E币的奖励；16周岁以下会员不可以进行报销行为；\n\t二、在职军人不允许注册心未来互联平台，军人其职责是保家卫国，责任巨大，不可分心。如果在职军人私自注册，平台一旦发现，会立刻冻结该ve号，直到其复员或者转业到社会，通过其本人申请，重新开通；\n\t我遵循以上明示规则及内在道德要求。我将全力以赴，全心全赢的付出。成己成人，薪火相传；与爱同行，不离不弃。";
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contenLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:20];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [contenLabel.text length])];
    contenLabel.attributedText = attributedString;
    [scrollView addSubview:contenLabel];
    
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, SCREEN_height-70, SCREEN_width-30, 50) withTitel:@"我知道了,返回继续注册"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}
- (void)buttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"返回");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
