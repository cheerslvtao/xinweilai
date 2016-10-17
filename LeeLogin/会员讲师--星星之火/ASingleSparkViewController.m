//
//  ASingleSparkViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "ASingleSparkViewController.h"
#import "MeetCell.h"
#import "SubmitMeetContentViewController.h"
#import "MeetListViewController.h"
#import "ShowMeetInfoViewController.h"
@interface ASingleSparkViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * SparkTableView;

@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation ASingleSparkViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"星星之火";
    [self.view addSubview:self.SparkTableView];
}

-(UITableView *)SparkTableView{
    if (!_SparkTableView) {
        _SparkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height) style:UITableViewStylePlain];
        _SparkTableView.delegate =self;
        _SparkTableView.dataSource = self;
        _SparkTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _SparkTableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
        _SparkTableView.backgroundColor = [UIColor clearColor];
        _SparkTableView.tableHeaderView = [self customHeaderView]; // 表头
        [_SparkTableView registerNib:[UINib nibWithNibName:@"MeetCell" bundle:nil] forCellReuseIdentifier:@"MeetCell"];
    }
    return _SparkTableView;
}
//自定义表头
-(UIView *)customHeaderView
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 120 )];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel * lvLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 60)];
    lvLabel.font = [UIFont boldSystemFontOfSize:15];
    lvLabel.textAlignment = NSTextAlignmentCenter;
    lvLabel.backgroundColor = BGCOLOR;
    NSString * text = [NSString stringWithFormat:@"%@ [%@]",@"12345678",@"银牌讲师-地市级"];
    //添加副文本
    NSRange range = [text rangeOfString:@" "];
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(range.location+1,[text length]-range.location-1 )];
    
    lvLabel.attributedText = attStr;
    [view addSubview:lvLabel];
    
    UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, SCREEN_width/3+5, 59)];

    titlelabel.text = @" 已提交会议列表";
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = COLOR(107,177, 234, 1);
    [view addSubview:titlelabel];

    
    NSArray * arr = @[@"会议审核",@"会议提交"];
    for (int i =0 ; i<2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_width - (SCREEN_width/3-25+10)*(i+1), 75, SCREEN_width/3-25, 30);
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 15;
        btn.layer.borderColor =COLOR(107,177, 234, 1).CGColor;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLOR(107,177, 234, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 6742+i;
        [view addSubview:btn];
    }
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 119, SCREEN_width, 1)];
    lineView.backgroundColor =COLOR(107,177, 234, 1);
    [view addSubview:lineView];
    
    return view;
}

#pragma mark == btn 点击事件   &&  页面跳转
-(void)clickButton:(UIButton *)btn{
    if (btn.tag == 6742) {
        //会议审核
        MeetListViewController * vc = [MeetListViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //会议提交
        SubmitMeetContentViewController * vc = [SubmitMeetContentViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    self.SparkTableView.frame = CGRectMake(0, 64, SCREEN_width, SCREEN_height);
    
    return 2;
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ShowMeetInfoViewController * vc = [ShowMeetInfoViewController new];
    vc.titleString = @"已提交会议信息";
    vc.isCheck = YES; //vc 中不会出现 审核 button
    [self.navigationController pushViewController:vc animated:YES];
    
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
