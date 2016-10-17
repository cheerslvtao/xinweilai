

//
//  IndividualAccountVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/1.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "IndividualAccountVC.h"
#import "IndividualAccountCell.h"
#import "PersonalInformationVC.h"//个人账户
#import "IndividualAccountContenVC.h"//内容加载页面
@interface IndividualAccountVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *BigView;
    NSArray *_titelArray;
}
@end

@implementation IndividualAccountVC

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
    //个人账户
    _titelArray = @[@"翼币",@"现金",@"积分",@"银行卡",];
    [self addView];
    // Do any additional setup after loading the view.
}
-(void)addView
{
    BigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 270)];
    BigView.backgroundColor = BGCOLOR;
    UITableView *tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped];
    tabelView.tableHeaderView = BigView;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
   // tabelView.separatorStyle = UITableViewCellFocusStyleCustom;
   // tabelView.separatorInset = UIEdgeInsetsZero;
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [tabelView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:tabelView];
    [tabelView registerClass:[IndividualAccountCell class] forCellReuseIdentifier:@"cell"];
    [self tabelViewHearView];
    [self manyView];

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
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 10, 19, 39) ;
    [backButton setImage:[UIImage imageNamed:@"head_arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 15;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IndividualAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    if (indexPath.section == 0){
        cell.titleLabel.text = _titelArray[indexPath.row];
        cell.tag = indexPath.row +10;
    }else{
        cell.titleLabel.text = @"支付密码";
        cell.tag = indexPath.row+20;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//取消点击状态
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        IndividualAccountCell *cell = [self.view viewWithTag:10+indexPath.row];
        IndividualAccountContenVC *vc = [IndividualAccountContenVC new];
        vc.titleString = cell.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        IndividualAccountCell *cell = [self.view viewWithTag:20+indexPath.row];
        IndividualAccountContenVC *vc = [IndividualAccountContenVC new];
        vc.titleString = cell.titleLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
#pragma mark -- buttonClicke
- (void)backButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)buttonClick
{
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
