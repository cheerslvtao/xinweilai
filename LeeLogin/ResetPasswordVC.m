
//
//  ResetPasswordVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ResetPasswordVC.h"

@interface ResetPasswordVC ()<UITextFieldDelegate>

@end

@implementation ResetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //重置密码
    self.title = @"重置密码";
    self.view.backgroundColor = BGCOLOR;
    [self addView];//添加视图
    // Do any additional setup after loading the view.
}
- (void)addView
{
    NSArray *array = @[@"  新密码",@" 确认新密码"];
    LeeAllView *leeAllView = [LeeAllView new];
    for (int i=0; i<2; i++)
    {
        UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 85+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.textField.tag = i+10;
        leeAllView.textField.delegate = self;
        [self.view addSubview:view];
    }
    //发送重置邮件按钮
    UIButton *button = [LeeAllView BigButton:CGRectMake(15, 240, SCREEN_width-30, 50) withTitel:@"重置密码"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)buttonClick
{
    NSLog(@"发送重置密码");
}
//收起键盘
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    [self.view endEditing:YES];
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
