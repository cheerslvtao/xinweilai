//
//  MeetListViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "MeetListViewController.h"
#import "ShowMeetInfoViewController.h"
#import "MeetCell.h"
#import "SubmitMeetContentViewController.h"
@interface MeetListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * SparkTableView;

@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation MeetListViewController

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
    
    titlelabel.text = @" 会议审核列表";
    titlelabel.font = [UIFont systemFontOfSize:15];
    titlelabel.textColor = COLOR(107,177, 234, 1);
    [view addSubview:titlelabel];
    
    
    UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 119, SCREEN_width, 1)];
    lineView.backgroundColor =COLOR(107,177, 234, 1);
    [view addSubview:lineView];
    
    return view;
}

#pragma mark == btn 点击事件   &&  页面跳转
-(void)clickButton:(UIButton *)btn{
    if (btn.tag == 6742) {
        //会议审核
        
    }else{
        //会议提交
        SubmitMeetContentViewController * vc = [SubmitMeetContentViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    self.SparkTableView.frame = CGRectMake(0, 64, SCREEN_width, SCREEN_height);
    
    return 3;
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MeetCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.meetStatus.text = @"查看";
    }else if (indexPath.row == 1){
        cell.meetStatus.text = @"已通过";
        cell.meetStatus.textColor =[UIColor greenColor];
    }else{
        cell.meetStatus.textColor = [UIColor redColor];
        cell.meetStatus.text = @"已拒绝";
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    ShowMeetInfoViewController * vc = [ShowMeetInfoViewController new];
    vc.titleString = @"会议审核";
    vc.isCheck = NO;
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
