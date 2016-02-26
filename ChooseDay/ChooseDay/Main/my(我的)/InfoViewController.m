//
//  InfoViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/2/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "InfoViewController.h"
#import "GUNMMAFN.h"
#import <MaxLeap/MaxLeap.h>
#import "UIImageView+WebCache.h"

@interface InfoViewController ()
{

    UIImageView *imgV;
    
    UILabel *nameLabel;
    
    UILabel *sexLabel;
    
    UILabel *addLabel;
}

@property (nonatomic, strong) NSMutableArray *lists;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人信息";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    [self loadInfoView];
    
    //判断当前的登录账号
    if (kAccessToken) {
        
        [self loadWeiBoInformation];
        
    }else if (kQQOpenID) {
    
        [self loadQQInformation];
    
    }else {
    
        [self loadChooseDayInformation];
    
    }
    
}

//加载微博信息数据
-(void)loadWeiBoInformation{

    //url
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    
    //    NSLog(@"token===%@   id = %@",kAccessToken,kUserID);
    
    NSDictionary *parameters = @{@"access_token":kAccessToken,@"uid":kUserID};
    
    [GUNMMAFN getDataWithParameters:parameters withUrl:url withBlock:^(id result) {
        
        //设置信息显示
        NSString *img = [result objectForKey:@"profile_image_url"];
        
        [imgV setImageWithURL:[NSURL URLWithString:img]];
        
        nameLabel.text = [result objectForKey:@"name"];
        
        NSString *sex = [result objectForKey:@"gender"];
        
        if ([sex isEqual:@"m"]) {
            
            sex = @"男";
            
        }else if ([sex isEqual:@"f"]) {
        
            sex = @"女";
        
        }else {
        
            sex = @"未知";
        
        }
        
        sexLabel.text = sex;
        
        addLabel.text = [result objectForKey:@"location"];
        
    }];

}

//加载QQ信息数据
-(void)loadQQInformation{

    NSString *url = @"https://graph.qq.com/user/get_user_info";
    
    NSDictionary *parameters = @{@"access_token":kQQAccessToken,@"oauth_consumer_key":kAppID,@"openid":kQQOpenID};
    
    [GUNMMAFN getDataWithParameters:parameters withUrl:url withBlock:^(id result) {
        
        //设置显示信息
        NSString *img = [result objectForKey:@"figureurl_qq_2"];
        
        [imgV setImageWithURL:[NSURL URLWithString:img]];
        
        nameLabel.text = [result objectForKey:@"nickname"];
        
        sexLabel.text = [result objectForKey:@"gender"];
        
        NSString *country = [result objectForKey:@"country"];
        
        NSString *province = [result objectForKey:@"province"];
        
        NSString *city = [result  objectForKey:@"city"];
        
        if (country != nil) {
            
            addLabel.text = [NSString stringWithFormat:@"%@%@省%@市",country,province,city];
            
        }else if (province != nil) {
        
            addLabel.text = [NSString stringWithFormat:@"%@省%@市",province,city];
        
        }else {
        
            addLabel.text = [NSString stringWithFormat:@"%@市",city];
        
        }
    
    }];

}

//加载自行注册的信息数据
-(void)loadChooseDayInformation{
    
    NSLog(@"%@",[MLUser currentUser]);
    
    nameLabel.text = kUserName;
    
    sexLabel.text = [MLUser currentUser][@"sex"];
    
    addLabel.text = [MLUser currentUser][@"address"];
    
//    NSLog(@"jjjjk%@",addLabel.text);
    
    //获取MaxLeap中的设置的Photo类
    MLQuery *queryPhoto = [MLQuery queryWithClassName:@"Photo"];
    
    //查找Name列中的用户名
    [queryPhoto whereKey:@"Name" equalTo:kUserName];
    
    if (queryPhoto) {
        
        //查询数据
        [queryPhoto findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            //                NSLog(@"obj %@",objects);
            
            self.lists = [NSMutableArray array];
            
            //Objects是只读，用一个可变数组接收
            [self.lists addObjectsFromArray:objects];
            
            //                NSLog(@"count %ld",self.lists.count);
            
            //判断是否有头像
            if (self.lists.count == 0) {
                
                imgV.image = [UIImage imageNamed:@"myImage"];
                
            }else{
                
                MLObject *list = self.lists[0];
                
                MLFile *userImgFile = list[@"image"];
                
                //获取图片数据
                [userImgFile getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
                    
                    if (!error) {
                        
                        UIImage *img = [UIImage imageWithData:data];
                        
                        //判断是否存在头像
                        if (img) {
                            
                            imgV.image = img;
                            
                        }else {
                            
                            imgV.image = [UIImage imageNamed:@"myImage"];
                            
                        }
                        
                    }
                    
                }];
                
            }
            
        }];
        
    }

}


//显示信息详情
-(void)loadInfoView{

    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-300)];
    
    [self.view addSubview:infoView];
    
    imgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, 100, 100)];
    
    imgV.layer.borderWidth = 1;
    
    imgV.layer.borderColor = [[UIColor grayColor]CGColor];
    
    imgV.layer.cornerRadius = 50;
    
    imgV.clipsToBounds = YES;
    
    imgV.image = [UIImage imageNamed:@"myImage"];
    
    [infoView addSubview:imgV];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgV.origin.x+imgV.width+10, 50, 200, 30)];
    
    nameLabel.text = @"未知";
    
    [infoView addSubview:nameLabel];
    
    sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.origin.y+nameLabel.height+5, nameLabel.width, nameLabel.height)];
    
    sexLabel.text = @"未知";
    
    [infoView addSubview:sexLabel];
    
    UILabel *birthdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(sexLabel.origin.x+sexLabel.width+60, sexLabel.origin.y, kScreenW-sexLabel.origin.x+sexLabel.width, sexLabel.height)];
    
    birthdayLabel.text = @"1992-01-12";
    
//    [infoView addSubview:birthdayLabel];
    
    addLabel = [[UILabel alloc]initWithFrame:CGRectMake(sexLabel.origin.x, sexLabel.origin.y+sexLabel.height+5, nameLabel.width, nameLabel.height)];
    
    addLabel.text = @"未知";
    
    [infoView addSubview:addLabel];

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
