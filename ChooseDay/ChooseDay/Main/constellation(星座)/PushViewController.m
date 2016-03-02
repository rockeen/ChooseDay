//
//  PushViewController.m
//  ChooseDay
//
//  Created by 闵哲 on 16/2/27.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    imgV.image = self.backgroundImg;
    
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view insertSubview:imgV atIndex:0];

    // Do any additional setup after loading the view from its nib.
    
    _constellationName.text = _model.name;
    
    _data.text = _model.datetime;
    
    _summary.text = _model.summary;
    
    _health.text = _model.health;
    
    _QFriend.text = _model.QFriend;
    
    _money.text = _model.money;
    
    _work.text = _model.work;
    
    _all.text = _model.all;
    
    _color.text = _model.color;
    
    _love.text = _model.love;
    
    _number.text = [NSString stringWithFormat:@"%@",_model.number];
    
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
