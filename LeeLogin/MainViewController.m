//
//  MainViewController.m
//  transferLabel
//
//  Created by 吕涛 on 16/7/28.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "MainViewController.h"
#import "PersonTopView.h"
#import "MainCell.h"
#import "FirstViewCell.h"
#import "MidCell.h"
#import "Masonry/Masonry.h"
#import "AreaFooterView.h"

#import "IndividualAccountVC.h"//个人账户
#import "PersonalInformationVC.h"//个人信息
#import "RealNameAuthenticationViewController.h" // 实名认证
#import "AroundMallVC.h"//商店
#import "MemberTeacherViewController.h"
#import "ASingleSparkViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) PersonTopView      * headerView;     // 自定义头像昵称View

@property (nonatomic,strong) UIView             * mainHeaderView; // tableView表头

//@property (nonatomic,strong) UIImageView        * backgroudView;  //本视图背景图片

@property (nonatomic,strong) UITableView        * mainTableView;

@property (nonatomic,strong) NSArray            * dataArr;        // 今日任务推荐数据数组

@property (nonatomic,strong) UICollectionView   * firstView;      // 加在表头上的第一个collectionView

@property (nonatomic,strong) NSArray            * titleArr;       // 翼币，现金，积分

@property (nonatomic,strong) UICollectionView   * midView;         //中间12个按钮

@property (nonatomic,strong) NSArray            * ImgArr;          //中间12个按钮图片

@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES ;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCollectionViews];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.headerView];   // 添加带头像View

    [self.view addSubview:self.mainTableView];
    
}

#pragma mark == 头视图
-(PersonTopView *)headerView{
    if (!_headerView) {
        _headerView = [[PersonTopView alloc]initWithFrame:CGRectMake(0, 0, width_screen, width_screen*0.6)]; //高度等于宽度的60%
        _headerView.labelName.text = @"落雨";
        _headerView.labelMemberLv.text = @"入门会员";
        
    }
    return _headerView;
}

#pragma mark == collectionView初始化
-(void)initCollectionViews{
    
    self.mainHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width_screen, width_screen*0.6+60+width_screen*3/4+30)];
    self.mainHeaderView.userInteractionEnabled = YES;
    
    UIView * clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width_screen, width_screen*0.6)];
    clearView.backgroundColor = [UIColor clearColor];

    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc]init];
    flow.minimumInteritemSpacing = 1; //最小行距
    flow.minimumLineSpacing = 1; //最小列距
    [flow setFooterReferenceSize:CGSizeMake(width_screen, 15)];//区尾frame
    
    self.firstView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, width_screen*0.6, width_screen, 60+width_screen*3/4+2+30) collectionViewLayout:flow];
    self.firstView.backgroundColor = [UIColor LowWhileColor];
    self.firstView.tag = 10000;
    
    self.firstView.delegate = self;
    self.firstView.dataSource = self;
    
    [self.firstView registerNib:[UINib nibWithNibName:@"FirstViewCell" bundle:nil] forCellWithReuseIdentifier:@"FirstViewCell"];
    [self.firstView registerNib:[UINib nibWithNibName:@"MidCell" bundle:nil] forCellWithReuseIdentifier:@"MidCell"];
    [self.firstView registerClass:[AreaFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AreaFooterView"]; //注册区尾
    
    [self.mainHeaderView addSubview:clearView];
    [self.mainHeaderView addSubview:self.firstView];    // 添加UICollectionView
    
    UIView * topleftview=  [[UIView alloc]initWithFrame:CGRectMake((width_screen-2)/3-0.5, 0, 1.5, 10)];
    topleftview.backgroundColor = [UIColor whiteColor];
    UIView * toprightview=  [[UIView alloc]initWithFrame:CGRectMake((width_screen-2)*2/3+0.5, 0, 1.5, 10)];
    toprightview.backgroundColor = [UIColor whiteColor];

    UIView * bottomview = [[UIView alloc]initWithFrame:CGRectMake((width_screen-2)/3-5, 50, width_screen-(width_screen-2)/3+5, 10)];
    bottomview.backgroundColor = [UIColor whiteColor ];
    
    [self.firstView addSubview:topleftview];
    [self.firstView addSubview:toprightview];
    [self.firstView addSubview:bottomview];
}

#pragma mark = =collectionViewdelegate & datasource
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((width_screen-2)/3, 60);
    }   
    return CGSizeMake((width_screen-3)/4, (width_screen-3)/4);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return 12;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

//区尾
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AreaFooterView" forIndexPath:indexPath];
    return view;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FirstViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FirstViewCell" forIndexPath:indexPath];
        cell.title.text = self.titleArr[indexPath.item];
        if (indexPath.row == 0) {
            cell.flagView.backgroundColor = [UIColor colorWithRed:50/255.0 green:140/255.0 blue:222/255.0 alpha:1];
        }else if(indexPath.row == 1){
            cell.flagView.backgroundColor = [UIColor colorWithRed:142/255.0 green:13/255.0 blue:185/255.0 alpha:1];
        }else{
            cell.flagView.backgroundColor = [UIColor colorWithRed:210/255.0 green:24/255.0 blue:35/255.0 alpha:1];
        }
        return cell;
    }else{
        MidCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MidCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.img.image = [UIImage imageNamed:self.ImgArr[indexPath.item]];
        return cell;
    }
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
    }else{
        
        switch (indexPath.row)
        {
                
            case 0:
            {
                IndividualAccountVC *individualAccountVC = [IndividualAccountVC new];//个人账户
                [self.navigationController pushViewController:individualAccountVC animated:YES];
                break;
            }
            case 2:
            {
                AroundMallVC * vc = [AroundMallVC new];//商城
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 4:
            {
                MemberTeacherViewController * vc = [MemberTeacherViewController new];//实名认证
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
            case 5:
            {
                RealNameAuthenticationViewController * vc = [RealNameAuthenticationViewController new];//实名认证
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 7:
            {
                ASingleSparkViewController * vc = [ASingleSparkViewController new];//实名认证
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
                
                
            default:
                break;
        }

    }

}

#pragma mark == tableView初始化
-(UITableView *)mainTableView{
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, width_screen, height_screen)];
        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.delegate= self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator =NO;
        _mainTableView.tableHeaderView = self.mainHeaderView;
        [_mainTableView registerNib:[UINib nibWithNibName:@"MainCell" bundle:nil] forCellReuseIdentifier:@"MainCell"];
    }
    return _mainTableView;
}

#pragma mark == UItableViewdelegate & datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
//    return self.dataArr.count;
}
//区头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width_screen, 50)];
    baseView.backgroundColor = [UIColor whiteColor];

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width_screen/2, 49)];
    label.text = @"   今日任务推荐";
    label.font = [UIFont boldSystemFontOfSize:18];
    
    UIView * view = [[UIView alloc ]initWithFrame:CGRectMake(0, 48, width_screen, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(width_screen-44, 0, 44, 49)];
    imgview.image = [UIImage imageNamed:@"hto"];
    
    [baseView addSubview:label];
    [baseView addSubview:imgview];
    [baseView addSubview:view];
    return baseView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark == animation as scale
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"%lf",self.mainTableView.contentOffset.y);
    
    float offsetY = self.mainTableView.contentOffset.y;
    float scale = offsetY/(width_screen*350/660);//放大比例

    if (self.mainTableView.contentOffset.y<0) {
        [self.headerView.headerV.layer addAnimation:[self scale:@(1-scale) orgin:@(1-scale) durTimes:0.1 Rep:1] forKey:nil];
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.01 animations:^{
            CGRect rect = CGRectMake(offsetY/2, 0, width_screen-offsetY, width_screen*0.6-offsetY);
            weakself.headerView.frame = rect;
        }];
    }

}

-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes //缩放

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}

#pragma mark == 数组初始化
//中间12个按钮图片
-(NSArray *)ImgArr{
    if (!_ImgArr) {
        NSArray * arr = @[@"nav_grzh",
                          @"nav_xld",
                          @"nav_zbsd",
                          @"nav_tjpy",
                          @"nav_hyjs",
                          @"nav_smrz",
                          @"nav_kg",
                          @"nav_xxzh",
                          @"nav_jssh",
                          @"nav_yhkbd",
                          @"nav_tjlb",
                          @"nav_pysh",
                          ];
        _ImgArr = [[NSArray alloc]initWithArray:arr];
    }
    return _ImgArr;
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc]initWithObjects:@"翼币",@"现金",@"积分", nil];
    }
    return _titleArr;
}

@end
