

//
//  PersonalInformationVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/1.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "PersonalInformationVC.h"
#import "PersonalInformationVCCell.h"
#import "HeadPortraitCell.h"//头像Cell
#import "ModifyPictureVC.h"//修改头像
#import "ChangePasswordVC.h"//修改密码
#import "AllModifyVC.h"//所以修改
#import "IndividualitySignatureCell.h"//个性签名
@interface PersonalInformationVC ()<UITableViewDelegate,UITableViewDataSource,AllModifyVCdelegate>
{
    NSArray *_bigArray;
    NSArray *_contenArray;
    UITableView *tabelView;
}
@end

@implementation PersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    NSArray * firstArray = @[@"头像",@"VE号",@"会员等级",@"昵称",@"姓名",@"联系方式",@"邮箱",@"个性签名"];
    NSArray * secondArray = @[@"推荐人",@"培养人",@"企业员工",@"婚姻状况",@"有无子女",@"政治面貌",@"养老保险",@"人寿保险"];
    _bigArray = [NSArray arrayWithObjects:firstArray,secondArray, nil];
    [self storeInformation];
    //个人信息
    [self addView];
    // Do any additional setup after loading the view.
}
-(void)addView
{
    tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height-64) style:UITableViewStyleGrouped];
    tabelView.backgroundColor = BGCOLOR;
    tabelView.showsVerticalScrollIndicator = NO;//隐藏滑动条
    tabelView.delegate = self;
    tabelView.dataSource = self;
    [tabelView setLayoutMargins:UIEdgeInsetsZero];
    [self.view addSubview:tabelView];
    [tabelView registerClass:[PersonalInformationVCCell class] forCellReuseIdentifier:@"cell"];
    [tabelView registerClass:[HeadPortraitCell class] forCellReuseIdentifier:@"headCell"];
    [tabelView registerClass:[IndividualitySignatureCell class] forCellReuseIdentifier:@"IndividualityCell"];
}
#pragma mark--表代理方法
//返回区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01;
    }
    return 15;
    
}
//返回行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2)
    {
        return 1;
    }else if (section==3)
    {
        return 0;
    }
    else
    {
         return 8;
    }
   
    
}
//用于设定编中区的个数,默认情况是1个区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0||indexPath.row==7) {
            return 80;
        }else
        {
            return 60;
        }
    }else{
        return 60;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.001;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    PersonalInformationVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     HeadPortraitCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
    IndividualitySignatureCell *IndividualityCell = [tableView dequeueReusableCellWithIdentifier:@"IndividualityCell"];
    if (indexPath.section==2)
    {
        headCell.titelLabel.text = @"修改登录密码";
        headCell.titelLabel.frame = CGRectMake(20, 20, 150, 20);
        headCell.headImgView.frame = CGRectMake(SCREEN_width-30, 10, 20, 40);
        headCell.headImgView.image = [UIImage imageNamed:@"arrow_right"];
        headCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
        return headCell;
    }else if(indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            headCell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];
             headCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return headCell;
        }else if (indexPath.row==7){
            IndividualityCell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];
            IndividualityCell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
            IndividualityCell.tag = indexPath.row+10;
            IndividualityCell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
            return IndividualityCell;
        }
        else
        {
            cell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];//标题
            cell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
            cell.contentLabel.backgroundColor = [UIColor redColor];
            cell.tag = indexPath.row+10;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
        
    }else if (indexPath.section==1){
        cell.titelLabel.text = _bigArray[indexPath.section][indexPath.row];//标题
        cell.contentLabel.text = _contenArray[indexPath.section][indexPath.row];//内容
        cell.contentLabel.backgroundColor = [UIColor redColor];
        cell.tag = indexPath.row+30;
        
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;//取消点击状态
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section==0)//第一个区
    {
        if (indexPath.row==0)
        {
            ModifyPictureVC *vc = [ModifyPictureVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            PersonalInformationVCCell *cell = [self.view viewWithTag:indexPath.row+10];
            AllModifyVC *modifyVC = [AllModifyVC new];
            modifyVC.titleString = cell.titelLabel.text;
            [self.navigationController pushViewController:modifyVC animated:YES];
        }
       
    }else if (indexPath.section==1)//第二个区
    {
        PersonalInformationVCCell *cell = [self.view viewWithTag:indexPath.row+30];
        NSLog(@"%ld",(long)cell.tag);
        NSLog(@"%@",cell.titelLabel.text);
        AllModifyVC *modifyVC = [AllModifyVC new];
        modifyVC.titleString = cell.titelLabel.text;
        [self.navigationController pushViewController:modifyVC animated:YES];
        
    }else if (indexPath.section==2)//第三个区
    {
        ChangePasswordVC *vc = [ChangePasswordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
//代理方法
- (void)refreshList
{
    [self storeInformation];//刷新数据
    [tabelView reloadData];//刷新表格
    
}
-(void)storeInformation
{
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSString *VEString = [NSString stringWithFormat:@"%@",[user objectForKey:@"VE号"]];
     NSString *membershipString = [NSString stringWithFormat:@"%@",[user objectForKey:@"会员等级"]];
     NSString *nicknameString = [NSString stringWithFormat:@"%@",[user objectForKey:@"昵称"]];
     NSString *nameString = [NSString stringWithFormat:@"%@",[user objectForKey:@"姓名"]];
     NSString *contactString = [NSString stringWithFormat:@"%@",[user objectForKey:@"联系方式"]];
     NSString *emailString = [NSString stringWithFormat:@"%@",[user objectForKey:@"邮箱"]];
     NSString *individualitySignatureString = [NSString stringWithFormat:@"%@",[user objectForKey:@"个性签名"]];
     NSString *refereesString = [NSString stringWithFormat:@"%@",[user objectForKey:@"推荐人"]];
     NSString *personString = [NSString stringWithFormat:@"%@",[user objectForKey:@"培养人"]];
     NSString *enterpriseString = [NSString stringWithFormat:@"%@",[user objectForKey:@"企业员工"]];
     NSString *marriageString = [NSString stringWithFormat:@"%@",[user objectForKey:@"婚姻状况"]];
     NSString *childrenString = [NSString stringWithFormat:@"%@",[user objectForKey:@"有无子女"]];
     NSString *politicalString = [NSString stringWithFormat:@"%@",[user objectForKey:@"政治面貌"]];
     NSString *agedString = [NSString stringWithFormat:@"%@",[user objectForKey:@"养老保险"]];
    NSString *lifeString = [NSString stringWithFormat:@"%@",[user objectForKey:@"人寿保险"]];
    NSArray *firstContenArray = @[@"",VEString,membershipString,nicknameString,nameString,contactString,emailString,individualitySignatureString];
    
    NSArray *sectonContenArray = @[refereesString,personString,enterpriseString,marriageString,childrenString,politicalString,agedString,lifeString];
    _contenArray = @[firstContenArray,sectonContenArray];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self storeInformation];//刷新数据
    [tabelView reloadData];//刷新表格
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
