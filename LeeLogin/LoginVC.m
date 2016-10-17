


//
//  LoginVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "LoginVC.h"
#import "RegisteredVC.h"//注册
#import "RetrievePasswordVC.h"//找回密码
#import "MainViewController.h"//首页

@interface LoginVC ()<UITextFieldDelegate>
{
    BOOL lastButton;
}
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGCOLOR;
    self.navigationItem.hidesBackButton = YES;
    //登录
    self.title = @"请您登录";
    [self addView];//添加视图
    // Do any additional setup after loading the view.
}
- (void)addView
{
    NSArray *array = @[@"VE号",@"密码"];
    LeeAllView *leeAllView = [LeeAllView new];
    for (int i=0; i<2; i++)
    {
        UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 85+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.titerLabel.textAlignment = NSTextAlignmentCenter;
        leeAllView.textField.tag = i+10;
        leeAllView.textField.delegate = self;
        [self.view addSubview:view];
    }
    //对勾按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    [but setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    but.frame = CGRectMake(30,225, 30, 30);
    [self.view addSubview:but];
    UILabel *yesLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 225, 80, 30)];
    yesLabel.text = @"记住密码";
    yesLabel.font = THIRTEEN;
    [self.view addSubview:yesLabel];
    //忘记密码
    UIButton *forgetBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBut addTarget:self action:@selector(termsButClicled) forControlEvents:UIControlEventTouchUpInside];
    [forgetBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [forgetBut setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgetBut.titleLabel.font = THIRTEEN;//设置字体大小
    forgetBut.frame = CGRectMake(SCREEN_width-150,225, 120, 30);
    [self.view addSubview:forgetBut];
    //登录按钮
   UIButton *button = [LeeAllView BigButton:CGRectMake(15, 275, SCREEN_width-30, 50) withTitel:@"登  录"];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    //注册
    UIButton *registeredBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [registeredBut addTarget:self action:@selector(registeredButClicled) forControlEvents:UIControlEventTouchUpInside];
    [registeredBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [registeredBut setTitle:@"还不是会员? 马上注册" forState:UIControlStateNormal];
    registeredBut.titleLabel.font = THIRTEEN;//设置字体大小
    registeredBut.frame = CGRectMake(SCREEN_width/8,340, SCREEN_width/4*3, 30);
    [self.view addSubview:registeredBut];
}
- (void)buttonClick
{
    MainViewController *vc = [MainViewController new];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    UIWindow *window =[[UIApplication  sharedApplication].delegate window];
    window.rootViewController = nvc;
    NSLog(@"登录");
}
- (void)rightButton:(UIButton *)button
{
    if (lastButton==0) {
        [button setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    }
    lastButton = !lastButton;
    NSLog(@"对勾按钮");
    NSLog(@"对勾");
}
- (void)termsButClicled
{
    RetrievePasswordVC *retrievePasswordVC = [RetrievePasswordVC new];
    [self.navigationController pushViewController:retrievePasswordVC animated:YES];
    NSLog(@"忘记密码");
}
- (void)registeredButClicled
{
    RegisteredVC *registeredVC = [RegisteredVC new];
    [self.navigationController pushViewController:registeredVC animated:YES];
      NSLog(@"注册");
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
