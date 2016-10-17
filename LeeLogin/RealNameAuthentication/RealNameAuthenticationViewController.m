//
//  RealNameAuthenticationViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/1.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"
#import "FillInformationViewController.h"
#import "AuthenticationCell.h"
#import "MyAuthenticatioinCell.h"
#import "CheckViewController.h"

static NSString * const LTAuthenticationNone = @"AuthenticationNone";         //未审核
static NSString * const LTAuthenticationUnpassed = @"AuthenticationUnpassed"; //审核未通过
static NSString * const LTAuthenticationPassed = @"AuthenticationPassed";     //审核通过
static NSString * const LTAuthenticationing = @"Authenticationing";           //审核中

//#define status  LTAuthenticationNone
//#define sectionNum 2

@interface RealNameAuthenticationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableString * status;     //认证状态
    NSArray * _titleArr;   //标题
    NSArray * _passedContentArr;    //已认证  测试数据
    NSArray * _unPassedContentArr;  //未通过  测试数据
    NSArray * _submited;            //已提交  测试数据
    NSMutableArray * _useArr;       //使用的arr 测试数据
    UIColor * _statusColor;     //认证状态颜色
    UIButton * _authenticationButton; //认证按钮
    NSInteger  _sectionNumber; //返回多少区
    CGFloat _heightTable;//tableview 的高
}
@property (nonatomic,strong) UITableView * authenticationTableView;

@end

@implementation RealNameAuthenticationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"实名认证";
    
    //测试设置的状态和区数
    status = (NSMutableString *)LTAuthenticationNone;
    _sectionNumber = 1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusChanged:) name:@"statusChanged" object:nil];
    
    if ([status isEqualToString:LTAuthenticationNone]) {
        [self AuthenticationNone];
    }else{
        [self createTableView];
    }
}

-(void)statusChanged:(NSNotification *)noti{
    NSDictionary * notifi = noti.userInfo;
    status = notifi[@"status"];
    _sectionNumber = [notifi[@"sectionNum"] integerValue];
    
    for (id view in self.view.subviews) {
        [view removeFromSuperview];
    }

    [self createTableView];
}

-(void)createTableView{
    _titleArr = [[NSArray alloc]initWithObjects:@"当前状态",@"姓名",@"身份证号",@"拒绝理由", nil];
    
    _useArr = [[NSMutableArray alloc]init];
    [_useArr removeAllObjects];
    if ([status isEqualToString:LTAuthenticationUnpassed]) { //认证未通过
        _unPassedContentArr = [[NSArray alloc]initWithObjects:@"认证未通过",@"张三",@"140429************",@"照片不清晰 身份证号码不正确 会员姓名不正确", nil];
        [_useArr addObjectsFromArray:_unPassedContentArr];
        _statusColor = [UIColor redColor];
        _heightTable =  64+50*_useArr.count;//tableView的高，64 + 每个cell的高度50 * 共有多少行cell
        _authenticationButton = [LeeAllView BigButton:CGRectMake(10, 64+50*5+20, SCREEN_width-20, 40) withTitel:@"重新认证"];
        [_authenticationButton addTarget:self action:@selector(goAuthentication) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_authenticationButton];

    }else if([status isEqualToString:LTAuthenticationPassed]){ //已认证
        _passedContentArr = [[NSArray alloc]initWithObjects:@"已认证",@"张三",@"140429************", nil];
        _statusColor = [UIColor greenColor];
        [_useArr addObjectsFromArray:_passedContentArr];
        
        _heightTable =  64+50*_useArr.count+80*5;//tableView的高，64 + 每个cell的高度50 * 共有多少行cell  + 80 *  第二个区的cell个数
        if (_heightTable>=SCREEN_height-64) {
            _heightTable = SCREEN_height-64;
        }
        
    }else if ([status isEqualToString:LTAuthenticationing]){ //已提交
        _submited =[[NSArray alloc]initWithObjects:@"已提交",@"张三",@"140429************", nil];
        _statusColor = COLOR(62, 94, 149, 1);
        
        [_useArr addObjectsFromArray:_submited];
        _heightTable =  64+50*_useArr.count;//tableView的高，64 + 每个cell的高度50 * 共有多少行cell
        
    }
    
    [self.view addSubview:self.authenticationTableView];
    [self.authenticationTableView reloadData];
}

#pragma mark = =  未审核界面
-(void)AuthenticationNone{
    UIImageView * flagImgV = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_width/2-104*0.4, 85, 104*0.8, 90*0.8)];
    flagImgV.image = [UIImage imageNamed:@"icon_ts"];
    [self.view addSubview:flagImgV];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 175, SCREEN_width, 30)];
    label.text = @"您尚未实名认证";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    UIButton * btn = [LeeAllView BigButton:CGRectMake(10, 260, SCREEN_width-20, 40) withTitel:@"立即认证"];
    [btn addTarget:self action:@selector(goAuthentication) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)goAuthentication{
    FillInformationViewController * vc = [FillInformationViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark == 已提交/未通过tableView
-(UITableView *)authenticationTableView{
    if (!_authenticationTableView) {
        _authenticationTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, _heightTable) style:UITableViewStylePlain];
        _authenticationTableView.delegate = self;
        _authenticationTableView.dataSource = self;
        _authenticationTableView.showsVerticalScrollIndicator = NO;
        _authenticationTableView.bounces = NO;
        _authenticationTableView.separatorInset = UIEdgeInsetsZero;
        _authenticationTableView.backgroundColor = BGCOLOR;
        [_authenticationTableView registerNib:[UINib nibWithNibName:@"AuthenticationCell" bundle:nil] forCellReuseIdentifier:@"AuthenticationCell"];
        [_authenticationTableView registerNib:[UINib nibWithNibName:@"MyAuthenticatioinCell" bundle:nil] forCellReuseIdentifier:@"MyAuthenticatioinCell"];
    }
    return _authenticationTableView;
}
//区数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionNumber;
}
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        self.authenticationTableView.frame = CGRectMake(0, 64, SCREEN_width, _heightTable); //重置tableView的frame
        return _useArr.count;
    }
    return 5;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }
    return 80;
}
//区头
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([status isEqualToString:LTAuthenticationPassed]) {
        return 20;
    }
    return 44;
}
//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = nil;
    if ([status isEqualToString:LTAuthenticationUnpassed]||[status isEqualToString:LTAuthenticationing]) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 44)];
        label.text = @"认证信息";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15];
    }
    return label;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AuthenticationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenticationCell" forIndexPath:indexPath];
        cell.titleLabel.text = _titleArr[indexPath.row];
        cell.contentLabel.text = _useArr[indexPath.row];

        if (indexPath.row == 0) {
            cell.contentLabel.textColor = _statusColor;
        }
        return cell;
    }
    MyAuthenticatioinCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyAuthenticatioinCell" forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        CheckViewController * vc = [CheckViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}




@end
