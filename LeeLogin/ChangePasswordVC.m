





//
//  ChangePasswordVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()<UITextFieldDelegate>

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    //导航完成按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    //输入框
    NSArray *array = @[@"  原密码",@"  输入密码",@"  确认密码"];
    for (int i=0; i<3; i++)
    {
        LeeAllView *leeView = [[LeeAllView alloc]init];
      UIView *view = [leeView registeredViewWithFrame:CGRectMake(10, 100+(65*i), SCREEN_width-20, 50)];
        leeView.titerLabel.text = array[i];
        [self.view addSubview:view];
    }
    // Do any additional setup after loading the view.
}
#pragma mark--按钮事件
-(void)buttonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"完成");
}
#pragma mark--收起键盘
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
