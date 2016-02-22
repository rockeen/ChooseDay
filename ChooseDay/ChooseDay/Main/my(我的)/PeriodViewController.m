//
//  PeriodViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "PeriodViewController.h"
#import "ZHPickView.h"
#import "MDPickerView.h"

@interface PeriodViewController ()<UITableViewDelegate,ZHPickViewDelegate,MDPickerViewDelegate>
{

    ZHPickView *_pickerView;
    
    MDPickerView *_dayPickerView;
    
    NSArray *_intervalArr;
    NSArray *_realityArr;

}

@end

@implementation PeriodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"生理期";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    _finishBtn.backgroundColor = kMainColor;
    
    _finishBtn.layer.cornerRadius = 5.f;
    
    //加载数据
    [self loadData];
    
}

- (IBAction)finishBtnAct:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"设置成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.alertViewStyle = UIAlertActionStyleDefault;
    
    [alert show];
    
}

//加载数据
-(void)loadData{

    //获取数据源
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"DayPlist" ofType:@"plist"];
    
    //获取字典
    NSDictionary *dayDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    //获取天数数组
    _intervalArr = [dayDic objectForKey:@"intervalDay"];
    
    _realityArr = [dayDic objectForKey:@"realityDay"];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //获取cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.tag == 1) {
        
        [_pickerView remove];
        
        [_dayPickerView remove];
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1970];
        
        _pickerView = [[ZHPickView alloc]initDatePickWithDate:date datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
        
        _pickerView.delegate = self;
        
        [_pickerView show];
        
    }else if (cell.tag == 2) {
        
        [_pickerView remove];
    
        [_dayPickerView remove];
        
        _dayPickerView = [[MDPickerView alloc]initWithFrame:CGRectMake(0, kScreenH-256, kScreenW, 256) WithDataList:_intervalArr];
        
        _dayPickerView.delegate = self;
        
        _dayPickerView.tag = 10;
        
        [_dayPickerView show];
    
    }else {
    
        [_dayPickerView remove];
        
        _dayPickerView = [[MDPickerView alloc]initWithFrame:CGRectMake(0, kScreenH-256, kScreenW, 256) WithDataList:_realityArr];
        
        _dayPickerView.delegate = self;
        
        _dayPickerView.tag = 11;
        
        [_dayPickerView show];

    }

}

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{

    _dateLabel.text = [resultString substringToIndex:10];

}

-(void)tooBarDonBtnHaveClick:(MDPickerView *)pickView resultString:(NSString *)resultString{

    if (pickView.tag == 10) {
        
        _intervalLabel.text = resultString;
        
    }else {

        _realityLabel.text = resultString;
        
    }

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
