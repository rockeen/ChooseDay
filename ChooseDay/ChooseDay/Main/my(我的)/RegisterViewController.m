//
//  RegisterViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    
    UIImageView *_imgV;
    
    UIButton *_imgBtn;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册账号";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    [self createRegisterTextField];
    
    [self createRegisterBtn];
    
}

//创建注册textField
-(void)createRegisterTextField{

    //用户名
    UITextField *nameText = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, kScreenW-60, 30)];
    
    nameText.placeholder = @"用户名 2-20位字符";
    
    nameText.layer.borderWidth = .5;
    
    nameText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    nameText.layer.cornerRadius = 5.f;
    
    nameText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *nameView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, nameText.height)];
    
    nameView.backgroundColor = [UIColor clearColor];
    
    nameText.leftView = nameView;
    
    nameText.leftViewMode = UITextFieldViewModeAlways;
    
    nameText.delegate = self;
    
    [self.view addSubview:nameText];
    
    //密码
    UITextField *pwdText = [[UITextField alloc]initWithFrame:CGRectMake(nameText.frame.origin.x, nameText.bottom+20, nameText.width, nameText.height)];
    
    pwdText.placeholder = @"密码 6-20位字符";
    
    pwdText.layer.borderWidth = .5;
    
    pwdText.layer.borderColor = [[UIColor grayColor]CGColor];
    
    pwdText.layer.cornerRadius = 5.f;
    
    pwdText.clearButtonMode = UITextFieldViewModeAlways;
    
    //设置输入光标不靠左
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, pwdText.height)];
    
    pwdView.backgroundColor = [UIColor clearColor];
    
    pwdText.leftView = pwdView;
    
    pwdText.leftViewMode = UITextFieldViewModeAlways;
    
    pwdText.delegate = self;
    
    [self.view addSubview:pwdText];
    
    //上传图片
    _imgV = [[UIImageView alloc]initWithFrame:CGRectMake(pwdText.origin.x, pwdText.bottom+20, pwdText.width, pwdText.width)];
    
    _imgV.layer.borderWidth = 1;
    
    _imgV.layer.borderColor = [[UIColor grayColor]CGColor];
    
    _imgV.layer.cornerRadius = 5.f;
    
    _imgV.userInteractionEnabled = YES;
    
    _imgV.clipsToBounds = YES;
    
    [self.view addSubview:_imgV];
    
    _imgBtn = [[UIButton alloc]initWithFrame:_imgV.bounds];
    
    [_imgBtn setTitle:@"上传头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_imgBtn addTarget:self action:@selector(imgBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [_imgV addSubview:_imgBtn];
    
}

//创建注册按钮
-(void)createRegisterBtn{
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, _imgV.bottom+30, kScreenW-88*2, 50)];
    
    btn.backgroundColor = kMainColor;
    
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}


//注册btn的点击方法
-(void)btnAct:(UIButton *)btn{
    
    
    
}

//上传图片的点击方法
-(void)imgBtnAct:(UIButton *)btn{

    UIAlertController *imgAlertController = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *openPhotosAction = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开相册
        [self openPhotos];
        
    }];
    
    UIAlertAction *openCameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //打开相机
        [self openCamera];
        
    }];
    
    [imgAlertController addAction:cancleAction];
    
    [imgAlertController addAction:openPhotosAction];
    
    [imgAlertController addAction:openCameraAction];
    
    [self presentViewController:imgAlertController animated:YES completion:nil];

}

//打开相册
-(void)openPhotos{

    UIImagePickerController *pickerC = [[UIImagePickerController alloc]init];
    
    //类型
    pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //设置代理
    pickerC.delegate = self;
    
    //推出
    [self presentViewController:pickerC animated:YES completion:nil];
    
}

//图片被选中后调用
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //获取点击的图片
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    _imgV.image = img;
    
    //相册界面消失
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    [_imgBtn setTitle:@"更改头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
}

//打开相机
-(void)openCamera{

    UIImagePickerController *pickerC = [[UIImagePickerController alloc]init];
    
    pickerC.delegate = self;
    
    //设置摄像头是否可用--前置摄像头
    BOOL isFrontCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
    
    BOOL isPostCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    
    if (!isFrontCamera && !isPostCamera) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
        
    }else if (!isFrontCamera) {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有前置摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
    
    }else if (!isPostCamera) {
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有后置摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        alert.alertViewStyle = UIAlertViewStyleDefault;
        
        [alert show];
        
        return;
    
    }
    
    //设置类型是相机
    pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //推出
    [self presentViewController:pickerC animated:YES completion:nil];
    
    [_imgBtn setTitle:@"更改头像" forState:UIControlStateNormal];
    
    [_imgBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

}

//return后收起键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
    
}

//点击空白背景收起键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
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
