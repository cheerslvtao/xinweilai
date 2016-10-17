



//
//  HomePageViewController.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/7/28.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"//cell
#import "IndividualAccountVC.h"//个人账户
#import "PersonalInformationVC.h"//个人信息
#import "RealNameAuthenticationViewController.h" // 实名认证
#import "AroundMallVC.h"//商店
#import "MemberTeacherViewController.h"
#import "ASingleSparkViewController.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *BigView;
}
@end

@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGCOLOR;
    //首页
    [self addView];
    // Do any additional setup after loading the view.
}
-(void)addView
{
    BigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 300+SCREEN_width/4*3)];
    BigView.backgroundColor = BGCOLOR;
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped];
    tabelView.backgroundColor = [UIColor clearColor];
    tabelView.tableHeaderView = BigView;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [self.view addSubview:tabelView];
    [tabelView registerClass:[HomePageTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self tabelViewHearView];
    [self manyView];
    [self classificationView];
}
//个人资料视图
-(void)tabelViewHearView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 200)];
    view.backgroundColor = [UIColor clearColor];
    [BigView addSubview:view];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 200)];
    imgView.image = [UIImage imageNamed:@"indexbg"];
    UIImageView *gardenImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/2-60, 15, 120, 120)];
    gardenImg.image = [UIImage imageNamed:@"txbk"];
    [imgView addSubview:gardenImg];
    [view addSubview:imgView];
    UIButton *hearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    hearButton.frame = CGRectMake(SCREEN_width/2-50, 25, 100, 100);
    //按钮编辑
    [hearButton.layer setMasksToBounds:YES];
    //边框宽度
    [hearButton.layer setBorderWidth:1.0];
    //边框圆角半径
    [hearButton.layer setCornerRadius:50];
    //边框颜色
    hearButton.layer.borderColor=[UIColor whiteColor].CGColor;
    hearButton.backgroundColor = [UIColor yellowColor];
    hearButton.layer.masksToBounds = 45;
    [hearButton addTarget:self action:@selector(hearButtonClicke) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:hearButton];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 145, SCREEN_width, 20)];
    nameLabel.textColor = COLOR(218, 227, 236, 1);
    nameLabel.text = @"落雨";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont systemFontOfSize:17];
    [view addSubview:nameLabel];
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 168, SCREEN_width, 20)];
    levelLabel.textColor = COLOR(218, 227, 236, 1);
    levelLabel.text = @"入门会员";
    levelLabel.textAlignment = NSTextAlignmentCenter;
    levelLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:levelLabel];
}
//显示余额视图
- (void)manyView
{
    NSArray *colorArray = @[COLOR(46, 128, 204, 1),COLOR(151, 38, 186, 1),COLOR(218, 25, 36, 1)];
    NSArray *titleArray = @[@"翼币",@"现金",@"积分"];
    NSArray *manyArray = @[@"1110.00",@"3000.00",@"1000"];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_width, 70)];
    view.backgroundColor = [UIColor whiteColor];
    [BigView addSubview:view];
    for (int i=0; i<3; i++)
    {
        UILabel *titleLabel = [[UILabel alloc]init];
        UILabel *colorlabel = [[UILabel alloc]init];
        UILabel *manyLabel  = [[UILabel alloc]init];
        manyLabel.frame = CGRectMake(SCREEN_width/3*i, 37, SCREEN_width/3, 25);
        titleLabel.frame = CGRectMake(SCREEN_width/3*i, 10, SCREEN_width/3, 25);
        if (i==0)
        {
            colorlabel.frame = CGRectMake(0, 0, SCREEN_width/3, 5);
        }else if (i==1){
            colorlabel.frame = CGRectMake(SCREEN_width/3+1, 0, SCREEN_width/3-2, 5);
        }else{
            colorlabel.frame = CGRectMake(SCREEN_width/3*2, 0, SCREEN_width/3, 5);
        }
        
        manyLabel.font = [UIFont systemFontOfSize:20];
        manyLabel.textAlignment = NSTextAlignmentCenter;
        manyLabel.text = manyArray[i];
        manyLabel.adjustsFontSizeToFitWidth =YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = COLOR(170, 170, 170, 1);
        titleLabel.text = titleArray[i];
        colorlabel.backgroundColor = colorArray[i];
        [view addSubview:colorlabel];
        [view addSubview:titleLabel];
        [view addSubview:manyLabel];
    }
    for (int a=0; a<2; a++)
    {
        UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_width/3*(a+1), 10, 1, 55)];
        lineview.backgroundColor = COLOR(234, 234, 234, 1);
        [view addSubview:lineview];
    }
    
}
//分类按钮视图
-(void)classificationView
{
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 285, SCREEN_width, SCREEN_width/4*3)];
    view.backgroundColor = BGCOLOR;
    [BigView addSubview:view];
    NSArray *buttonImgArray = @[@"nav_grzh",@"nav_xld",@"nav_zbsd",@"nav_tjpy",@"nav_hyjs",@"nav_smrz",@"nav_kg",@"nav_xxzh",@"nav_jssh",@"nav_yhkbd",@"nav_tjlb",@"nav_pysh"];
    for (int i=0; i<12; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(((SCREEN_width-3)/4+1)*(i%4), ((SCREEN_width-3)/4+1)*(i/4), (SCREEN_width-3)/4, (SCREEN_width-3)/4);
        [button setImage:[UIImage imageNamed:buttonImgArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+10;
        button.backgroundColor = [UIColor whiteColor];
        [view addSubview:button];
    }

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 50;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 50)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_width/4*3, 50)];
        label.text = @"今日推荐任务";
        [view addSubview:label];
    //标记图片
    UIImageView *redImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width-47, 0, 47, 50)];
    redImg.image = [UIImage imageNamed:@"hto"];
    [view addSubview:redImg];
    //灰色线条
    UIView *colorView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_width, 1)];
    colorView.backgroundColor = BGCOLOR;
    [view addSubview:colorView];
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 4;
    
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_width/4+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//取消点击状态
    return cell;
}
#pragma mark -- buttonClicke
- (void)buttonClick:(UIButton *)button
{
    
    switch (button.tag)
    {
           
            
        case 10:
        {
            IndividualAccountVC *individualAccountVC = [IndividualAccountVC new];//个人账户
            [self.navigationController pushViewController:individualAccountVC animated:YES];
            break;
        }
        case 12:
        {
            AroundMallVC * vc = [AroundMallVC new];//商城
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 14:
        {
            MemberTeacherViewController * vc = [MemberTeacherViewController new];//实名认证
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 15:
        {
            RealNameAuthenticationViewController * vc = [RealNameAuthenticationViewController new];//实名认证
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 17:
        {
            ASingleSparkViewController * vc = [ASingleSparkViewController new];//实名认证
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }


        default:
            break;
    }
    NSLog(@"按钮被点击");
    
}
- (void)hearButtonClicke
{
    [self.navigationController pushViewController:[PersonalInformationVC new] animated:YES];
    NSLog(@"个人信息");
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
