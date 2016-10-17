


//
//  IndividualAccountContenVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/4.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualAccountContenVC.h"

@interface IndividualAccountContenVC ()
{
    NSURL *_url;
}
@end

@implementation IndividualAccountContenVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",self.navigationController.navigationBar);
    self.title= _titleString;
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height-64)];
    [webView setOpaque:NO];//opaque是不透明的意思
    [webView setScalesPageToFit:YES];//自动缩放以适应屏幕
    [webView setUserInteractionEnabled:YES];//是否支持交互
    [self.view addSubview:webView];
    if ([_titleString isEqualToString:@"翼币"]) {
        NSLog(@"翼币");
        _url = [NSURL URLWithString:@"https://www.baidu.com"];
    }else if ([_titleString isEqualToString:@"现金"]){
        NSLog(@"现金");
        _url = [NSURL URLWithString:@"https://www.sina.com"];
    }else if ([_titleString isEqualToString:@"积分"]){
        NSLog(@"积分");
        _url = [NSURL URLWithString:@"https://lol.qq.com"];
    }else if ([_titleString isEqualToString:@"银行卡"]){
        NSLog(@"银行卡");
        _url = [NSURL URLWithString:@"https://www.panda.tv"];
    }else if ([_titleString isEqualToString:@"支付密码"]){
        NSLog(@"支付密码");
        _url = [NSURL URLWithString:@"https://t.qq.com/huhudeweibe"];
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:_url]];
    // Do any additional setup after loading the view.
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
