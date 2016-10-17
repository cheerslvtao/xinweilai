



//
//  AroundMallVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/4.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "AroundMallVC.h"
#import "StoreTableViewCell.h"
#import "ListGoodsVC.h"//商品
@interface AroundMallVC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AroundMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"新百广场店",@"a",@"新百广场三楼",@"b",@"0311-87654321",@"c", nil];
    NSDictionary *dicc =[[NSDictionary alloc]initWithObjectsAndKeys:@"华强广场店",@"a",@"华强广场四楼",@"b",@"0311-23455423",@"c", nil];
    _cellArray = @[dic,dicc];
    self.title = @"周边商店";
    [self createUItabelView];
    // Do any additional setup after loading the view.
}
#pragma mark--表格以及表格的代理方法
//创建表
-(void)createUItabelView
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 154, SCREEN_width, SCREEN_height) style:UITableViewStyleGrouped ];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate =self;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:@"cell"];
}
//返回区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 250;
}
//返回行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 2;
}
//返回内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.mallLabel.text = _cellArray[indexPath.row][@"a"];
    cell.storeLabel.text = _cellArray[indexPath.row][@"b"];
    cell.phoneLabel.text = _cellArray[indexPath.row][@"c"];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListGoodsVC *vc = [ListGoodsVC new];
    vc.mallString= _cellArray[indexPath.row][@"a"];
    vc.storeString = _cellArray[indexPath.row][@"b"];
    vc.phoneString = _cellArray[indexPath.row][@"c"];
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
