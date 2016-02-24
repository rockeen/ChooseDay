//
//  InfoViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/2/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人信息";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    [self loadInfo];
    
}

//显示信息详情
-(void)loadInfo{

    UIView *infoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-300)];
    
    [self.view addSubview:infoView];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(30, 50, 100, 100)];
    
//    imgV.image = [UIImage imageNamed:@""];
    
//    imgV.backgroundColor = [UIColor redColor];
    
    imgV.layer.borderWidth = 1;
    
    imgV.layer.borderColor = [[UIColor grayColor]CGColor];
    
    imgV.layer.cornerRadius = 50;
    
    [infoView addSubview:imgV];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgV.origin.x+imgV.width+10, 50, 200, 30)];
    
    nameLabel.text = @"name";
    
    [infoView addSubview:nameLabel];
    
    UILabel *sexLabel = [[UILabel alloc]initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.origin.y+nameLabel.height+5, 30, nameLabel.height)];
    
    sexLabel.text = @"sex";
    
    [infoView addSubview:sexLabel];
    
    UILabel *birthdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(sexLabel.origin.x+sexLabel.width+60, sexLabel.origin.y, kScreenW-sexLabel.origin.x+sexLabel.width, sexLabel.height)];
    
    birthdayLabel.text = @"1992-01-12";
    
    [infoView addSubview:birthdayLabel];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(sexLabel.origin.x, sexLabel.origin.y+sexLabel.height+5, nameLabel.width, nameLabel.height)];
    
    addLabel.text = @"address";
    
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
