//
//  SubmitMeetContentViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/4.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "SubmitMeetContentViewController.h"
#import "MeetSubmitCell.h"
#import "CDCardCell.h"
#import "SubmitPhotoCell.h"
@interface SubmitMeetContentViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    BOOL _ISelectPhoto;
    BOOL _IISelectPhoto;
    BOOL _IIISelectPhoto;
    
    float currentOffset ;//当前tableView偏移量
    NSInteger _selecCellIndex;
    CGRect _photoRect;//照片frame
}
@property (nonatomic,strong) UITableView * submitTableView;

@property (nonatomic,strong) NSArray * titleArr;

@property (nonatomic,strong)NSMutableArray * photoFrameArr;

@property (nonatomic,strong)NSArray * placeholdArr;
@end

@implementation SubmitMeetContentViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //设置返回按钮
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];
    
    //使用NSNotificationCenter 键盘出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    //使用NSNotificationCenter 键盘隐藏时
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];

}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = BGCOLOR;
    self.title = @"会提提交";
    self.photoFrameArr = [[NSMutableArray alloc]init]   ;
    [self createRightCompeteButton];
    [self.view addSubview:self.submitTableView];
}

#pragma mark == 导航右边按钮
-(void)createRightCompeteButton{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 35);
    [btn setTitle:@"完 成" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)submit{
    NSLog(@"提交");
}

#pragma mark == 初始化 tableView
-(UITableView *)submitTableView{
    if (!_submitTableView) {
        _submitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64) style:UITableViewStylePlain];
        _submitTableView.delegate =self;
        _submitTableView.dataSource = self;
        _submitTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _submitTableView.estimatedRowHeight = 50;
        _submitTableView.rowHeight = UITableViewAutomaticDimension;
        [_submitTableView registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
        [_submitTableView registerNib:[UINib nibWithNibName:@"MeetSubmitCell" bundle:nil] forCellReuseIdentifier:@"MeetSubmitCell"];
        [_submitTableView registerNib:[UINib nibWithNibName:@"SubmitPhotoCell" bundle:nil] forCellReuseIdentifier:@"SubmitPhotoCell"];
        _submitTableView.tableFooterView = [self customFooter];
    }
    return _submitTableView;
}

#pragma mark == 表尾
-(UIView *)customFooter{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 220)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_width/3, 30)];
    label.text = [self.titleArr lastObject];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 50, SCREEN_width-20, 170)];
    textView.text = @"您对本次会议的总结感想，限500字以内";
    textView.textColor = [UIColor grayColor];
    textView.delegate =self;
    [view addSubview:textView];
    
    return view;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count-1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<7) {
        MeetSubmitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MeetSubmitCell" forIndexPath:indexPath];
        cell.textFiledCell.delegate = self;
        cell.titleLabel.text = self.titleArr[indexPath.row];
        cell.textFiledCell.placeholder = self.placeholdArr[indexPath.row ];
        if (indexPath.row == 0||(indexPath.row >1 && indexPath.row<5) ) {
            cell.rightLogo.hidden = YES;
        }
        return cell;
    }
    CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.tag = 7859+indexPath.row;
    cell.UploadPhoto.tag = cell.tag + 100;
    [cell.UploadPhoto addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    return cell;

}

#pragma mark == 点击图片选择头像
-(void)selectPhoto:(UIButton *)btn{
    
    _selecCellIndex = btn.tag - 100;
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self pikePhoto:UIImagePickerControllerSourceTypeCamera];
        }else{
            NSLog(@"没有找到相关设备");
        }
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self pikePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(void)pikePhoto:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}

#pragma mark ==代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    CDCardCell * cell = [self.view viewWithTag:_selecCellIndex];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    cell.photoImg.image = image;
    [cell.UploadPhoto setTitle:@"重新上传" forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



#pragma mark == 初始化数组
-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [[NSArray alloc]initWithObjects:@"会议名称",@"会议地区",@"会议地点",@"主办人",@"讲师",@"会议时间",@"参会人员",@"会前照片",@"会中照片",@"会后照片",@"会议总结", nil];
    }
    return _titleArr;
}

-(NSArray *)placeholdArr{
    if (!_placeholdArr) {
        _placeholdArr = [[NSArray alloc]initWithObjects:@"会议的主题名称",@"选择省市区",@"",@"",@"",@"",@"张三、李四",@"会前照片",@"会中照片",@"会后照片",@"会议总结", nil];
    }
    return _placeholdArr;
}

#pragma mark  ==键盘收起
//textfiled 防范
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (textView.text.length>100) {
        textView.textColor = [UIColor redColor];
    }else{
        textView.textColor = [UIColor grayColor];
    }
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark == 处理键盘覆盖问题  textfiled代理方法
//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    //kbSize即为键盘尺寸 (有width, height)
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到键盘的高度
    currentOffset = self.submitTableView.contentOffset.y;
    
    float time = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:time animations:^{
        self.submitTableView.contentOffset =CGPointMake(0,  currentOffset+kbSize.height);
    }];
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.submitTableView.contentOffset =CGPointMake(0,  currentOffset);

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
