//
//  CheckViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/2.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "CheckViewController.h"
#import "CDCardCell.h"
#import "AuthenticationCell.h"
#import "RefuseAlertView.h"
@interface CheckViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titleArr;
    NSArray * _contentArr;
}

@property (nonatomic,strong) UITableView * checkTableView;
@end

@implementation CheckViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGCOLOR;
    self.title = @"认证审核"; 
    
    //设置返回按钮  不放在ViewWillappear里面 这是最后一个页面了
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];

    [self.view addSubview:self.checkTableView];
    _titleArr = [[NSArray alloc]initWithObjects:@"姓名",@"身份证号", nil];
    _contentArr = [[NSArray alloc]initWithObjects:@"张三",@"14042945749357453", nil];
    [self createButtons];
    

}

-(void)createButtons{
    NSArray * arr = @[@"拒绝通过",@"审核通过"];
    for (int i=0; i<2; i++) {
        UIButton * btn = [LeeAllView BigButton:CGRectMake(10, SCREEN_height-60*(i+1), SCREEN_width-20, 40) withTitel:arr[i]];
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 44453+i;
        if (i==0) {
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor redColor];
        }
        [self.view addSubview:btn];
    }
}

-(void)clickButton:(UIButton *)btn{
    if (btn.tag == 44453) {
        //拒绝
        UIView * bgView= [[UIView alloc]initWithFrame:self.view.bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.7;
        [self.view addSubview:bgView];
        
        RefuseAlertView * view = nil;
        NSArray * arr = [[NSBundle mainBundle] loadNibNamed:@"RefuseAlertView" owner:nil options:nil];
        NSLog(@"2222");
        view = [arr lastObject];
        void(^myBlock)()= ^(){
            [bgView removeFromSuperview];
        };
        view.block = myBlock;
        view.frame = self.view.frame;
        [self.view addSubview:view];

        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(UITableView * )checkTableView{
    if (!_checkTableView) {
        _checkTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height-140) style:UITableViewStylePlain];
        _checkTableView.delegate =self;
        _checkTableView.dataSource = self;
        _checkTableView.showsVerticalScrollIndicator = NO;
        _checkTableView.separatorInset = UIEdgeInsetsZero;
        _checkTableView.estimatedRowHeight = 45;
        _checkTableView.rowHeight = UITableViewAutomaticDimension; //自适应
        [_checkTableView registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_checkTableView registerNib:[UINib nibWithNibName:@"AuthenticationCell" bundle:nil] forCellReuseIdentifier:@"AuthenticationCell"];
    }
    return _checkTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <2) {
        AuthenticationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AuthenticationCell" forIndexPath:indexPath];
        cell.titleLabel.text = _titleArr[indexPath.row];
        cell.contentLabel.text = _contentArr[indexPath.row];
        return cell;
    }
    CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
    cell.UploadPhoto.hidden = YES;
    if (indexPath.row == 3) {
        cell.titleLabel.text = @"身份证背面照片";
    }
    return cell;
}


@end
