//
//  ConstellationViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ConstellationViewController.h"
#import "GUNMMAFN.h"

#import "MJExtension.h"
#import "ConstellationModel.h"

#import "iCarousel.h"


#import "CellView.h"


#import "PushViewController.h"


#import "AFNetworking.h"


@interface ConstellationViewController ()<iCarouselDataSource,iCarouselDelegate>
{
    //data
    NSMutableArray *_dataList;
    
    
    iCarousel *_icarous;
    
    
    NSInteger _assign;
    
    NSArray *_photoArr;
    
    NSArray *_monthArr;
}

@end

@implementation ConstellationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataList = [NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    
    

    _photoArr = @[@"aries",@"taurus",@"gemini",@"cancer",@"leo",@"virgo",@"libra",@"scorpio",@"sagittarius",@"aquarius",@"capricorn",@"pisces"];
    _monthArr = @[@"(3.21~4.19)",@"(4.20~5.20)",@"(5.21~6.21)",@"(6.22~7.22)",@"(7.23~8.22)",@"(8.23~9.22)",@"(9.23~10.23)",@"(10.24~11.22)",@"(11.23~12.21)",@"(12.22~1.19)",@"(1.20~2.18)",@"(2.19~3.20)"];

    
    
    
    //设置标题颜色
    [self setTitleColor];
    
    
    //创建collectionView
    [self createCollection];

    
    //判断是否有网
    [self  judgeTheNet];
    
    
    
    
    
}


//判断是否有网
- (void)judgeTheNet{
    
    
    AFNetworkReachabilityManager *reManager = [AFNetworkReachabilityManager sharedManager];
    
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [reManager startMonitoring];
    
    
    [reManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status) {
            //请求数据
            [self loadData];
            
        }
        else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法连接到互联网" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            alert.alertViewStyle = UIAlertViewStyleDefault;
            
            alert.tag = 11;
            
            [alert show];
        }
    }];
    

    
    
    
    
}

//创建collectionView
- (void)createCollection{
    

    _icarous = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-49-64)];
    
    _icarous.backgroundColor= kBgColor;
    _icarous.delegate = self;
    _icarous.dataSource = self;
    
    _icarous.type = iCarouselTypeCoverFlow2;
    
    _icarous.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_icarous];
    

}


//设置标题颜色
- (void)setTitleColor{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"星座" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = item;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, nil]];
    
    
    UIImageView *backgroundImgV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    
    backgroundImgV.image = [UIImage imageNamed:@"afc0ca93e673abd3f0a2f5bd60eabea6.jpg"];
    
    
    [self.view addSubview:backgroundImgV];
}


//请求数据
- (void)loadData{
    
    //存放星座名称的数组
    NSArray *constellationArr = @[@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    
    //清空数组
    [_dataList removeAllObjects];
    
    //按十二星座先后顺序给_dataList赋值，用于添加model时候排序
    for (int i = 0; i < constellationArr.count; i++) {
        [_dataList addObject:constellationArr[i]];
    }
    
    //url
    NSString *urlstr = @"http://web.juhe.cn:8080/constellation/getAll";
    
    //遍历数组获取星座数据
    for (int i = 0; i < constellationArr.count; i++) {
        
        NSDictionary *parameters = @{@"key":@"12bb68a2f0a5b97bed27d660ef23229f",@"consName":constellationArr[i],@"type":@"today"};
        
        
        [GUNMMAFN getDataWithParameters:parameters withUrl:urlstr withBlock:^(id result) {
            
            ConstellationModel *model = [ConstellationModel mj_objectWithKeyValues:result];
            //根据星座相应的排序将model添加到对应位置
            for (int j = 0; j <_dataList.count; j++) {
                if ([model.name isEqualToString:_dataList[j]]) {
                    [_dataList replaceObjectAtIndex:j withObject:model];
                    
                    _assign++;
                }
            }
            
            
            
            //如果十二个model添加完整了
            if (_assign == 12) {
                
                for (ConstellationModel *model1 in _dataList) {
                    NSLog(@"money = %@,work = %@ ",model1.name,model1.work);
                    
                }
                
                //重新加载数据
                [_icarous reloadData];
                
            }
            
        }];
        
        
        
    }
    
    
    
    
    
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}



#pragma mark-----iCarousel   代理
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return _dataList.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
//        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        view = [[[NSBundle mainBundle]loadNibNamed:@"CellView" owner:nil options:nil]lastObject];
        

        view.contentMode = UIViewContentModeCenter;
        
        view.backgroundColor = [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:.3];
        
    }
    
    if (_dataList.count == 12) {
        

        ((CellView *)view).model = _dataList[index];
        
        ((CellView *)view).image = [UIImage imageNamed:_photoArr[index]];
        
        ((CellView *)view).constellationData = _monthArr[index];
        
        
        
    }
    else{
        ((CellView *)view).image = [UIImage imageNamed:@"placeholder"];
        
    }
    
    
    return view;

}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1;
    }
    return value;
}


- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
    if (_dataList.count == 12) {
        PushViewController *pushV = [[PushViewController alloc]init];
        
        pushV.model = _dataList[index];
        pushV.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pushV animated:NO];
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
