//
//  RegisteredVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/27.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "RegisteredVC.h"
#import "LeeAllView.h"
#import "HomePageViewController.h"//首页
#import "RegistrationTermsVC.h"//注册条款
#import "RegistrationPromptVC.h"//注册提示
@interface RegisteredVC ()<UITextFieldDelegate>
{
    UITextField*_editingTextField;
    CGFloat keyboardHeight;
    CGFloat durationTime;
    UIScrollView *scrollView;
    BOOL lastButton;
}
@end

@implementation RegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册界面
    self.title = @"会员注册";
    self.view.backgroundColor = BGCOLOR;
    [self loadingView];//加载视图
    
    // Do any additional setup after loading the view.
}
//加载视图
-(void)loadingView
{
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height-64)];
    scrollView.showsVerticalScrollIndicator = FALSE;
    scrollView.showsHorizontalScrollIndicator = FALSE;
    scrollView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:247/255.0 alpha:1];
    scrollView.contentSize = CGSizeMake(SCREEN_width, 620);
    [self.view addSubview:scrollView];
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    //给view添加一个手势监测；
    [scrollView addGestureRecognizer:singleRecognizer];
    LeeAllView *leeAllView = [LeeAllView new];
    NSArray *array = @[@"  推荐人VE",@"  推荐人",@"  昵称",@"  电话",@"  密码",@"  确认密码",@"  验证码"];
    for (int i=0; i<7; i++) {
        
      UIView *view = [leeAllView registeredViewWithFrame:CGRectMake(15, 25+(65*i), SCREEN_width-30, 50)];
        leeAllView.titerLabel.text = array[i];
        leeAllView.textField.tag = view.frame.origin.y;
        leeAllView.textField.delegate = self;
        if (i==6) {
            leeAllView.textField.frame = CGRectMake(100, 0,view.frame.size.width-181, view.frame.size.height);
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(view.frame.size.width-90, 0, 90, view.frame.size.height)];
            [view addSubview:imgView];
            
        }
         [scrollView addSubview:view];
    }
    //对勾按钮
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
    but.frame = CGRectMake(30,480, 30, 30);
    [scrollView addSubview:but];
    UILabel *yesLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 480, 40, 30)];
    yesLabel.text = @"同意";
    yesLabel.font = THIRTEEN;
    [scrollView addSubview:yesLabel];
    //注册条款按钮
    UIButton *termsBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [termsBut addTarget:self action:@selector(termsButClicled) forControlEvents:UIControlEventTouchUpInside];
    [termsBut setTitleColor:[UIColor colorWithRed:0/255.0 green:133/255.0 blue:220/255.0 alpha:1] forState:UIControlStateNormal];
    [termsBut setTitle:@"注册条款" forState:UIControlStateNormal];
    termsBut.titleLabel.font = THIRTEEN;//设置字体大小
    termsBut.frame = CGRectMake(110,480, 120, 30);
    [scrollView addSubview:termsBut];
    //登录按钮
    UIButton *loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBut.frame = CGRectMake(15, 530, SCREEN_width-30, 50);
    [loginBut addTarget:self action:@selector(loginButClicled) forControlEvents:UIControlEventTouchUpInside];
    loginBut.titleLabel.font = THIRTEEN;
    [loginBut setTitle:@"登  录" forState:UIControlStateNormal];
    loginBut.backgroundColor = COLOR(62, 94, 149, 1);
    //按钮编辑
    [loginBut.layer setMasksToBounds:YES];
    //边框圆角半径
    [loginBut.layer setCornerRadius:10.0];
    [scrollView addSubview:loginBut];
    
}
- (void)loginButClicled
{
    HomePageViewController *vc = [HomePageViewController new];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    UIWindow *window =[[UIApplication  sharedApplication].delegate window];
    window.rootViewController = nvc;
    NSLog(@"登录");
    
}
-(void)termsButClicled
{
    
//        RegistrationTermsVC *TermsVC = [RegistrationTermsVC new];
//        [self.navigationController pushViewController:TermsVC animated:YES];
    
    RegistrationPromptVC *PromptVC = [RegistrationPromptVC new];
    [self.navigationController pushViewController:PromptVC animated:YES];

    NSLog(@"注册条款");
}
-(void)rightButton:(UIButton *)button
{
    if (lastButton==0) {
        [button setImage:[UIImage imageNamed:@"checkbox_on"] forState:UIControlStateNormal];
    }else{
    [button setImage:[UIImage imageNamed:@"checkbox_off"] forState:UIControlStateNormal];
    }
    lastButton = !lastButton;
    NSLog(@"对勾按钮");
}
-(void)viewWillAppear:(BOOL)animated{
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark == 处理键盘覆盖问题  textfiled代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _editingTextField=textField;

    NSLog(@"%ld", (long)textField.tag);
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:durationTime animations:^{
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, 64, scrollView.frame.size.width, scrollView.frame.size.height);
    }];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    durationTime = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]; //得到键盘动画时间
    NSLog(@"time : %f",durationTime);
    NSLog(@"++height:%f",kbSize.height);
    keyboardHeight = kbSize.height;
    
    if (SCREEN_height - keyboardHeight-64 <= _editingTextField.tag) {
        CGFloat y = _editingTextField.tag - (SCREEN_height - keyboardHeight - 65);
        [UIView animateWithDuration:durationTime animations:^{
            scrollView.frame = CGRectMake(scrollView.frame.origin.x, -y, scrollView.frame.size.width, scrollView.frame.size.height);
        }];
        
    }
    
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"--height:%f",kbSize.height);
    keyboardHeight = kbSize.height;
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark == 收起键盘
-(void)SingleTap:(UITapGestureRecognizer*)recognizer
{
    NSLog(@"点击了");
    [self.view endEditing:YES];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
