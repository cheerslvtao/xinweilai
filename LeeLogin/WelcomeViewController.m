

//
//  WelcomeViewController.m
//  HeartFuture
//
//  Created by 李雪虎 on 16/7/18.
//  Copyright © 2016年 光之翼. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginVC.h"//登录
#import "RegisteredVC.h"//注册
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //欢迎页面
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:SCREEN_bounds];
    imgView.image = [UIImage imageNamed:@"qdy_bg"];
    imgView.backgroundColor = [UIColor redColor];
    imgView.userInteractionEnabled=YES;
    [self.view addSubview:imgView];
    UIImageView *titleImg = [[UIImageView alloc]initWithFrame:CGRectMake(50, SCREEN_height/2-15, SCREEN_width-100, 30)];
    titleImg.image = [UIImage imageNamed:@"name"];
    [self.view addSubview:titleImg];
    UIImageView *contentImg = [[UIImageView alloc]initWithFrame:CGRectMake(60, SCREEN_height-60, SCREEN_width-120, 40)];
    contentImg.image = [UIImage imageNamed:@"Copyright"];
    [self.view addSubview:contentImg];
    NSArray *array = @[@"登录",@"注册"];
    for (int i=0; i<2; i++)
    {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:array[i] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butClicled:) forControlEvents:UIControlEventTouchUpInside];
        [but setBackgroundImage:[UIImage imageNamed:@"qdy_btn"] forState:UIControlStateNormal];
        but.tag = i+10;
        but.frame = CGRectMake(50+(((SCREEN_width-130)/2+30)*i), SCREEN_height/2+60, (SCREEN_width-130)/2, 40);
        [imgView addSubview:but];
    }
    
    // Do any additional setup after loading the view.
}
-(void)butClicled:(UIButton *)button
{
   // NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSLog(@"~~~%@",NSHomeDirectory());
    if (button.tag ==10) {
        [self loginVC];//登录页面
    }else{
        [self registeredVC];//注册页面
    }
    NSLog(@"hello");
}
#pragma mark == 登录页面
-(void)loginVC
{
    LoginVC *vc= [LoginVC new];
    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
    UIWindow *window =[[UIApplication  sharedApplication].delegate window];
    window.rootViewController = nv;
    
}
#pragma mark == 注册页面
-(void)registeredVC
{
    RegisteredVC *vc = [RegisteredVC new];
    UINavigationController * nv = [[UINavigationController alloc]initWithRootViewController:vc];
    UIWindow *window =[[UIApplication  sharedApplication].delegate window];
    window.rootViewController = nv;
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
