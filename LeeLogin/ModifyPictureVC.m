




//
//  ModifyPictureVC.m
//  LeeLogin
//
//  Created by 李雪虎 on 16/8/2.
//  Copyright © 2016年 Leexiaohu. All rights reserved.
//

#import "ModifyPictureVC.h"

@interface ModifyPictureVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ModifyPictureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改头像";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(SCREEN_width-50, 24, 40, 40);
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = BGCOLOR;
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
    _herdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _herdButton.frame = CGRectMake((SCREEN_width/3)/2, 100, SCREEN_width/3*2, SCREEN_width/3*2);
    _herdButton.backgroundColor = [UIColor redColor];
    [_herdButton addTarget:self action:@selector(herdButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_herdButton];
    // Do any additional setup after loading the view.
}
- (void)buttonClick
{
    NSLog(@"完成");
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)herdButtonClick
{
    NSLog(@"换头像");
    //弹框
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self pikePhoto:UIImagePickerControllerSourceTypeCamera];
        }else{
            NSLog(@"没有找到相关设备");
        }
        NSLog(@"相机");
        
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"相册");
        [self pikePhoto:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    
    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"换头像");
}
//调用相机
-(void)pikePhoto:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    [_herdButton.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_herdButton setImage:image forState:UIControlStateNormal];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:image forKey:@"头像"];
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
