//
//  ChangePWDViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ChangePWDViewController.h"

@interface ChangePWDViewController ()<UITextFieldDelegate>
{

    UITextField *newPwd2;

}

@end

@implementation ChangePWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改密码";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //创建输入框
    [self createTextField];
    
    //创建确认btn
    [self createCertainBtn];
    
}

//创建textField
-(void)createTextField{

    UITextField *oldPwd = [[UITextField alloc]initWithFrame:CGRectMake(30, 30, kScreenW-60, 30)];
    
    oldPwd.placeholder = @"请输入旧密码";
    
    oldPwd.layer.borderWidth = .5;
    
    oldPwd.layer.borderColor = [[UIColor grayColor]CGColor];
    
    oldPwd.layer.cornerRadius = 5.f;
    
    oldPwd.clearButtonMode = UITextFieldViewModeAlways;
    
    oldPwd.delegate = self;

    [self createClearView:oldPwd];
    
    [self.view addSubview:oldPwd];
    
    UITextField *newPwd = [[UITextField alloc]initWithFrame:CGRectMake(oldPwd.origin.x, oldPwd.bottom+10, oldPwd.width, oldPwd.height)];
    
    newPwd.placeholder = @"请输入新密码";
    
    newPwd.layer.borderWidth = .5;
    
    newPwd.layer.borderColor = [[UIColor grayColor]CGColor];
    
    newPwd.layer.cornerRadius = 5.f;
    
    newPwd.clearButtonMode = UITextFieldViewModeAlways;
    
    newPwd.delegate = self;
    
    [self createClearView:newPwd];
    
    [self.view addSubview:newPwd];
    
    newPwd2 = [[UITextField alloc]initWithFrame:CGRectMake(oldPwd.origin.x, newPwd.bottom+10, oldPwd.width, oldPwd.height)];
    
    newPwd2.placeholder = @"请确认新密码";
    
    newPwd2.layer.borderWidth = .5;
    
    newPwd2.layer.borderColor = [[UIColor grayColor]CGColor];
    
    newPwd2.layer.cornerRadius = 5.f;
    
    newPwd2.clearButtonMode = UITextFieldViewModeAlways;
    
    newPwd2.delegate = self;
    
    [self createClearView:newPwd2];

    [self.view addSubview:newPwd2];

}

//创建空白view
-(void)createClearView:(UITextField *)text{

    //设置输入光标不靠左
    UIView *pwdView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, text.height)];
    
    pwdView.backgroundColor = [UIColor clearColor];
    
    text.leftView = pwdView;
    
    text.leftViewMode = UITextFieldViewModeAlways;
    
    [text addSubview:pwdView];

}

//创建确认btn
-(void)createCertainBtn{

    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(88, newPwd2.bottom+50, kScreenW-88*2, 50)];
    
    btn.backgroundColor = kMainColor;
    
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    btn.layer.cornerRadius = 10.f;
    
    [btn addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];


}

-(void)btnAct:(UIButton *)btn{

    

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    
    return YES;

}

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
