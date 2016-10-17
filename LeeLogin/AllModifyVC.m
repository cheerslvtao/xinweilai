



//
//  AllModifyVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "AllModifyVC.h"
#import "PersonalInformationVC.h"
@interface AllModifyVC ()<UITextFieldDelegate>
{
    UITextField *_textField;
}
@end

@implementation AllModifyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleString;
    //导航完成按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    if ([_titleString isEqualToString:@"邮箱"]) {
        [button setTitle:@"发送验证" forState:UIControlStateNormal];
         button.frame = CGRectMake(SCREEN_width-90, 24, 80, 80);
        UILabel *label = [LeeAllView allLabelWith:CGRectMake(10, 160, SCREEN_width-30, 90) withTextColor:TEXTCOLOR];
        label.text = @"注:请输入您绑定的邮箱账号,发送验证邮件,进入邮箱内确认连接完成绑定。";
        label.numberOfLines = 0;
        [self.view addSubview:label];
    }else{
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
      
    }
    
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10,100,SCREEN_width-20,50 )];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.font = THIRTEEN;//字体大小
    _textField.delegate = self;
    [self.view addSubview:_textField];
    [self.view addSubview:_textField];
    
    
    
    // Do any additional setup after loading the view.
}
//完成按钮
- (void)buttonClick
{
    [self.delegate refreshList];//传回内容
     _textString = [NSString stringWithFormat:@"~~~%@",_textField.text];
    NSLog(@"%@",_textString);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
     _textString = [NSString stringWithFormat:@"~~~%@",textField.text];
      NSLog(@"%@",_textString);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *string = [NSString stringWithFormat:@"%@",self.title];
    [user setObject:textField.text forKey:string];
}
//键盘下去
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
