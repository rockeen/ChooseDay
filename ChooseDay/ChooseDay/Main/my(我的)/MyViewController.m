//
//  MyViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "MyViewController.h"
#import "EnterViewController.h"
//#import "MatterViewController.h"
#import "PeriodViewController.h"
#import "InstallViewController.h"
#import "AboutViewController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "InfoViewController.h"
#import "ZXYGtasksViewController.h"


@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    //设置用户头像的属性
    self.userImg.layer.borderWidth = 1.f;
    
    self.userImg.layer.borderColor = [[UIColor grayColor]CGColor];
    
    self.userImg.layer.cornerRadius = 50.f;
    
    self.userImg.clipsToBounds = YES;
    
    //更新数据
//    [self updateData];

    //接收更新数据的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateData) name:@"updateWeiboData" object:nil];
    
//    [self updateQQData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateQQData) name:@"exitLogin" object:nil];
    
}

//更新数据
-(void)updateQQData{

    if (kQQOpenID) {
        
        //加载QQ数据
        [self loadQQData];
        
        [self.tableView reloadData];

    }else {
    
        self.userName.text = @"登录";
        
        self.userImg.image = [UIImage imageNamed:@"myImage"];
        
    }

}

//加载QQ数据
-(void)loadQQData{

    NSString *url = @"https://graph.qq.com/user/get_user_info";
    
    NSDictionary *parameters = @{@"access_token":kQQAccessToken,@"oauth_consumer_key":kAppID,@"openid":kQQOpenID};
    
    //管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *userName = [responseObject objectForKey:@"nickname"];
        
        NSString *userImg = [responseObject objectForKey:@"figureurl_qq_2"];
        
        self.userName.text = userName;
        
        [self.userImg setImageWithURL:[NSURL URLWithString:userImg]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"____%@",error);
    }];

}

//更新微博数据
-(void)updateData{

    //判断是否授权
    if (kAccessToken) {
        
        [self loadData];
        
        [self createNavigationBarItem];
        
        [self.tableView reloadData];
        
    }else {
    
        self.userName.text = @"登录";
        
        self.userImg.image = [UIImage imageNamed:@"myImage"];
    
    }

}

//加载微博数据
-(void)loadData{

    //url
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    
//    NSLog(@"token===%@   id = %@",kAccessToken,kUserID);
    
    NSDictionary *parameters = @{@"access_token":kAccessToken,@"uid":kUserID};
    
    //管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *userName = [responseObject objectForKey:@"name"];
        
        NSLog(@"name is %@",userName);
        
        NSString *userImg = [responseObject objectForKey:@"profile_image_url"];
        
        self.userName.text = userName;
        
        [self.userImg setImageWithURL:[NSURL URLWithString:userImg]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"____%@",error);
    }];

}

//cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    //根据cell不同的tag值推出显示不同的页面
    if (cell.tag == 100) {
        
        //判断是否授权
        if (kQQOpenID || kAccessToken) {
            
            //个人信息页面
            InfoViewController *infoVC = [[InfoViewController alloc]init];
            
            [self.navigationController pushViewController:infoVC animated:YES];
            
        }else {
        
            //登录
//            EnterViewController *enterVC = [[EnterViewController alloc]initWithBlock:^(id result) {
//                
//                self.userName.text = [NSString stringWithFormat:@"%@",[result objectForKey:@"nickname"]];
//                
//                NSString *imgName = [result objectForKey:@"figureurl_qq_2"];
//                
//                [self.userImg setImageWithURL:[NSURL URLWithString:imgName]];
//                
//                [self.tableView reloadData];
//                
//            }];
            
            EnterViewController *enterVC = [[EnterViewController alloc]init];
            
            [self.navigationController pushViewController:enterVC animated:YES];
        
        }
        
    }else if (cell.tag == 110) {
    
        //待办事项
        ZXYGtasksViewController *matterVC = [[ZXYGtasksViewController alloc]init];
        
        [self.navigationController pushViewController:matterVC animated:YES];
    
    }else if (cell.tag == 111) {
    
        //生理期
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"PeriodViewController" bundle:nil];
        
        PeriodViewController *periodVC = [story instantiateInitialViewController];
        
        [self.navigationController pushViewController:periodVC animated:YES];
    
    }else if (cell.tag == 120) {
    
        //设置
        InstallViewController *installVC = [[InstallViewController alloc]init];
        
        [self.navigationController pushViewController:installVC animated:YES];
    
    }else {
    
        //关于
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"AboutViewController" bundle:nil];
        
        AboutViewController *aboutVC = [story instantiateInitialViewController];
        
//        AboutViewController *aboutVC = [[AboutViewController alloc]init];
        
        [self.navigationController pushViewController:aboutVC animated:YES];
    
    }

}

//自定义导航项
-(void)createNavigationBarItem{

    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    
//    NSLog(@"------is :%@",kQQOpenID);
    
//    NSLog(@"------to--is %@",kAccessToken);
    
    if (kQQOpenID || kAccessToken) {
        
        [rightBtn setTitle:@"切换账号" forState:UIControlStateNormal];
        
        [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [rightBtn addTarget:self action:@selector(rightBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
    
        [rightBtn setTitle:@"" forState:UIControlStateNormal];
    
    }
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;

}

//切换账号的点击方法
-(void)rightBtnAct:(UIButton *)btn{

    EnterViewController *enterVC = [[EnterViewController alloc]init];
    
    [self.navigationController pushViewController:enterVC animated:YES];
    

}

//销毁通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    [self updateQQData];
    
    [self updateData];

    //添加切换账号
    [self createNavigationBarItem];

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
