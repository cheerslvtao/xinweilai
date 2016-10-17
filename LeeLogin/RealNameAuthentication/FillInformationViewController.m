//
//  FillInformationViewController.m
//  ShiMingRenZheng
//
//  Created by 吕涛 on 16/8/1.
//  Copyright © 2016年 吕涛. All rights reserved.
//

#import "FillInformationViewController.h"
#import "CDCardCell.h"
@interface FillInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField * _nameField;
    UITextField * _IDcardField;
    
    NSInteger _selecCellIndex;
}

@property (nonatomic,strong) UITableView * fillInfoTable;


@end

@implementation FillInformationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"提交认证";
    self.view.backgroundColor = BGCOLOR;
    
    //设置返回按钮  不放在ViewWillappear里面 这是最后一个页面了
    NvigationItemSingle * single = BACK_NAVIGATION;
    [single setNavigationBackItem:self];


    [self.view addSubview:self.fillInfoTable];
    [self createSubmitButton];
}


#pragma mark == 提交审核按钮 & 点击事件
-(void)createSubmitButton{
    UIButton * btn = [LeeAllView BigButton:CGRectMake(10, SCREEN_height-64, SCREEN_width-20, 40) withTitel:@"提交审核"];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
}

-(void)submitInfo{
    NSNotification * notification = [NSNotification notificationWithName:@"statusChanged" object:nil userInfo:@{@"status":@"Authenticationing",@"sectionNum":@1}];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark == 初始化tableView
-(UITableView * )fillInfoTable{
    if (!_fillInfoTable) {
        _fillInfoTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height-64-84) style:UITableViewStylePlain];
        _fillInfoTable.delegate= self;
        _fillInfoTable.dataSource =self;
        _fillInfoTable.showsVerticalScrollIndicator = NO;
        _fillInfoTable.estimatedRowHeight = 200;
        _fillInfoTable.rowHeight = UITableViewAutomaticDimension;
        _fillInfoTable.tableHeaderView = [self headerView]; //表头
        [_fillInfoTable registerNib:[UINib nibWithNibName:@"CDCardCell" bundle:nil] forCellReuseIdentifier:@"CDCardCell"];
    }
    return _fillInfoTable;
}

-(UIView *)headerView{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_width, 160)];
    view.backgroundColor = BGCOLOR;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(registeFirstResponder)];
    [view addGestureRecognizer:tap];

    _nameField = [self customTextFieldWithFrame:CGRectMake(10, 20, SCREEN_width-20, 40) title:@" 姓名"];
    _IDcardField = [self customTextFieldWithFrame:CGRectMake(10, 70, SCREEN_width-20, 40) title:@" 身份证号"];
    _IDcardField.keyboardType = UIKeyboardTypeNamePhonePad;
    
    _IDcardField.delegate =self;
    _nameField.delegate = self;
    
    UILabel * alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 120, SCREEN_width-20, 40)];
    alertLabel.textColor = [UIColor grayColor];
    alertLabel.text = @" 身份证照支持jpg/png格式";
    
    [view addSubview:alertLabel];
    [view addSubview:_nameField];
    [view addSubview:_IDcardField];
    return view;
}


#pragma mark == 自定义textFiled
-(UITextField * )customTextFieldWithFrame:(CGRect)rect title:(NSString *)title{
    
    UITextField * field = [[UITextField  alloc]initWithFrame:rect];
    field.layer.borderWidth = 0.4;
    field.borderStyle = UITextBorderStyleRoundedRect;
    field.layer.cornerRadius = 5;
    field.adjustsFontSizeToFitWidth = YES;
    field.layer.borderColor = [UIColor grayColor].CGColor;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 80, rect.size.height)];
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.layer.borderWidth = 0.2;
    label.backgroundColor = [UIColor colorWithRed:251/255.0 green:251/255.0 blue:252/255.0 alpha:1];
    label.adjustsFontSizeToFitWidth = YES;
    
    field.leftView = label;
    field.leftViewMode = UITextFieldViewModeAlways;
    return field;
}

#pragma mark ==textfield delegate && 收起键盘操作

-(void)registeFirstResponder{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (_IDcardField == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 18) { //如果输入框内容大于20则弹出警告
            
            textField.text = [toBeString substringToIndex:18];
            [textField resignFirstResponder];
            return NO;
        }
    }
    return YES;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CDCardCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CDCardCell" forIndexPath:indexPath];
    cell.tag = 8989+indexPath.row;
    cell.UploadPhoto.tag = cell.tag+100;
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




@end
