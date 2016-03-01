//
//  MatterViewController.m
//  ChooseDay
//
//  Created by Vivian on 16/1/18.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ThemeViewController.h"
#import "AppDelegate.h"

@interface ThemeViewController ()
{

    NSMutableArray *dic;
}
@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"主题切换";
    
    self.view.backgroundColor = kBgColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    self.tableView.backgroundColor = kBgColor;
    
    self.label1.backgroundColor = [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1];
    
    self.label2.backgroundColor = [UIColor colorWithRed:158/255.0 green:122/255.0 blue:64/255.0 alpha:1];
    
    self.label3.backgroundColor = [UIColor colorWithRed:242/255.0 green:134/255.0 blue:10/255.0 alpha:1];
    
    self.label4.backgroundColor = [UIColor colorWithRed:27/255.0 green:30/255.0 blue:37/255.0 alpha:1];
    
    self.label5.backgroundColor = [UIColor colorWithRed:20/255.0 green:100/255.0 blue:145/255.0 alpha:1];
    
    self.label6.backgroundColor = [UIColor colorWithRed:134/255.0 green:76/255.0 blue:27/255.0 alpha:1];
    
    self.label7.backgroundColor = [UIColor colorWithRed:90/255.0 green:35/255.0 blue:134/255.0 alpha:1];
    
    self.label8.backgroundColor = [UIColor colorWithRed:32/255.0 green:158/255.0 blue:141/255.0 alpha:1];
    
    dic = [NSMutableArray array];
//    [NSDictionary dictionary];
    
//    [dic setValue:[UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1] forKey:@"label1"];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (cell.tag) {
        case 1:
            
//            NSString *color = (NSString *)[UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1];
        
//            [UIColor colorWithRed:250/255.0 green:128/255.0 blue:114/255.0 alpha:1]
            [dic removeAllObjects];

            
            [dic addObject:@(250/255.0)];
            [dic addObject:@(128/255.0)];

            [dic addObject:@(114/255.0)];


            
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 2:
//            [UIColor colorWithRed:158/255.0 green:122/255.0 blue:64/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(158/255.0)];
            [dic addObject:@(122/255.0)];
            
            [dic addObject:@(64/255.0)];

            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 3:
//            [UIColor colorWithRed:242/255.0 green:134/255.0 blue:10/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(242/255.0)];
            [dic addObject:@(134/255.0)];
            
            [dic addObject:@(10/255.0)];

            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 4:
//            [UIColor colorWithRed:27/255.0 green:30/255.0 blue:37/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(27/255.0)];
            [dic addObject:@(30/255.0)];
            
            [dic addObject:@(37/255.0)];

            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 5:
//            [UIColor colorWithRed:20/255.0 green:100/255.0 blue:145/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(20/255.0)];
            [dic addObject:@(100/255.0)];
            
            [dic addObject:@(145/255.0)];

            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 6:
//            [UIColor colorWithRed:134/255.0 green:76/255.0 blue:27/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(134/255.0)];
            [dic addObject:@(76/255.0)];
            
            [dic addObject:@(27/255.0)];

            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 7:
//            [UIColor colorWithRed:90/255.0 green:35/255.0 blue:134/255.0 alpha:1]
            [dic removeAllObjects];
            
            [dic addObject:@(90/255.0)];
            [dic addObject:@(35/255.0)];
            
            [dic addObject:@(134/255.0)];
            


            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;
        case 8:
//            [UIColor colorWithRed:32/255.0 green:158/255.0 blue:141/255.0 alpha:1]
//            UIColor *color = [UIColor];
            
            [dic removeAllObjects];
            
            [dic addObject:@(32/255.0)];
            [dic addObject:@(158/255.0)];
            
            [dic addObject:@(141/255.0)];
            
            


            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            break;

            
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"mainColor"];



}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    
    AppDelegate *application = [UIApplication sharedApplication].delegate;
    
    [application loadNewView];

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
