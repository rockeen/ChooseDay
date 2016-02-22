//
//  WeatherViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/16.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "WeatherViewController.h"
#import "OutCollectionView.h"
#import "GUNMMAFN.h"
#import "OutModel.h"
#import "WeatherModel.h"

#import "GUNMMCityVC.h"
#import "GUNMMCityMangerVc.h"


#import "MJExtension.h"



@interface WeatherViewController ()
{
    
    //_outCollectionView  的数据
    NSMutableArray *_dataList;
    
    //用来  加载城市
    NSString *_city;
    
    //用来给  kHistoryData  赋值
    NSMutableArray *_cityName;
    
    //最外层CollectionView
    OutCollectionView *_outCollectionView;
    
    //推出的城市VC
    GUNMMCityVC *_cityVc;
    
    
    //分页控制器
    UIPageControl *_pageC;
    
    
    //用来标记  kHistoryData
    NSInteger _assign;
    
    //加载中显示的view
    UIView *_loadView;
    
    
    
    //编码管理者
    CLGeocoder *_geoCoder;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏不透明
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _dataList = [NSMutableArray array];
    
    _cityName = [NSMutableArray array];
    
    
    _geoCoder = [[CLGeocoder alloc]init];
    
    _city = @"济南";
    
    _assign = 1;
    
    
    
    NSLog(@"精度：%f,纬度：%f",_coordinate.longitude,_coordinate.latitude);
    
    
    //反地理编码
    [self reverseCode];
    
    //创建加载中显示的view
    [self createLoadingView];
    
    //创建添加城市的左侧按钮
    [self addLeftBtn];
    
    //添加分页控制器
    [self addPageControl];
    
    //创建外层collectionview
    [self createOutCollectV];
    
    
    
    
    
}


//反地理编码
- (void)reverseCode{
    //初始化CLLocation对象
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:_coordinate.latitude longitude:_coordinate.longitude];
    
    //反编码
    [_geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error) {
            NSLog(@"输入的地址在火星");
            return;
        }
        else
        {
            //获取到反编码对象
            CLPlacemark *pm = [placemarks firstObject];
            /*
             pm.country  国家
             pm.locality 城市
             pm.subLocality 子城市
             pm.thoroughfare 街道
             pm.subThoroughfare 子街道
             */
            
            NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@ %@",pm.country,pm.locality,pm.subLocality,pm.thoroughfare,pm.subThoroughfare];
            
            NSLog(@"addrss is:%@",address);
            
            NSLog(@"pm.name :%@",pm.name);
            
            
            NSRange range = [pm.locality rangeOfString:@"市"];
            
            //            NSString *a = @"jinan";
            
            NSMutableString *city = [NSMutableString stringWithString:pm.locality];
            
            [city deleteCharactersInRange:range];
            
            
            _city = city;
            
            //加载当前需要天气数据
            [self loadCurrentDay];
            
        }
        
        
    }];
    
    
}




//创建加载中显示的view
- (void)createLoadingView{
    
    _loadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
    
    _loadView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    
    
    [self.view addSubview:_loadView];
    
    
    //创建风火轮
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    
    
    
    //开启风火轮  默认是关闭状态并且关闭状态时不显示
    [activity startAnimating];
    
    
    //    activity.backgroundColor = [UIColor redColor];
    
    [_loadView addSubview:activity];
    
    activity.center = CGPointMake(_loadView.center.x, _loadView.center.y-50);
    
    
    //添加label
    UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 20)];
    
    loadLabel.top = activity.bottom+10;
    
    loadLabel.text = @"正在加载......";
    
    loadLabel.font = [UIFont systemFontOfSize:14];
    
    loadLabel.textColor = [UIColor whiteColor];
    
    loadLabel.textAlignment = NSTextAlignmentCenter;
    
    [_loadView addSubview:loadLabel];
    
    
    
}

//加载历史天气
- (void)loadHistoryWeather{
    for (NSString *city in kHistoryData) {
        _city = city;
        
        [self loadCurrentDay];
        
    }
}



//添加分页控制器
- (void)addPageControl{
    
    _pageC = [[UIPageControl alloc] initWithFrame:CGRectMake(kScreenW - 80, 90, 70, 10)];
    
    //    _pageC.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:_pageC];
    
}


//加载当前需要天气数据
- (void)loadCurrentDay{
    
    _loadView.hidden = NO;
    
    
    NSString *urlstr = @"http://op.juhe.cn/onebox/weather/query";
    
    
    NSDictionary *parameters = @{@"cityname":_city,@"key":@"8c091c43a938fe2c5c80bd67a2eeb65c"};
    
    [GUNMMAFN getDataWithParameters:parameters withUrl:urlstr withBlock:^(id result) {
        //        NSLog(@"%@",result);
        
        NSDictionary *resu= [result objectForKey:@"result"];
        
        NSDictionary *data = [resu objectForKey:@"data"];
        
        [OutModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"weather":@"WeatherModel"};
        }];
        
        OutModel *outModel = [OutModel mj_objectWithKeyValues:data];
        
        
        [_dataList addObject:outModel];
        
        //设置_pageC的总显示页和右边靠屏幕
        _pageC.numberOfPages = _dataList.count;
        //        [_pageC sizeToFit];
        //        _pageC.left = 20;
        
        
        
        //数据加载完成 _outCollectionView重新加载数据
        [_outCollectionView reloadData];
        
        
        
        
        //        [_cityVc dismissViewControllerAnimated:YES completion:nil];
        
        
        if (_assign) {
            
            //加载历史天气
            [self loadHistoryWeather];
            
            _assign = 0;
            
            _pageC.currentPage = 0;
            
            
        }
        
        
        _loadView.hidden = YES;
        
    }];
    
    
}


//创建外层collectionview
- (void)createOutCollectV{
    
    _outCollectionView = [[OutCollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-64-49)];
    
    _outCollectionView.dataList = _dataList;
    
    _outCollectionView.pageC = _pageC;
    
    [self.view addSubview:_outCollectionView];
    
    //将分页控制器移动到最顶层
    [self.view bringSubviewToFront:_pageC];
    
    
    [self.view bringSubviewToFront:_loadView];
    
}


//创建添加城市的左侧按钮
- (void)addLeftBtn{
    
    //初始化按钮
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"fun_ic_add"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftBtnAct) forControlEvents:UIControlEventTouchUpInside];
    
    //将按钮添加到 左侧导航栏
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
}

//导航栏添加城市按钮点击事件
- (void)leftBtnAct{
    
    
    
    
    _cityVc = [[GUNMMCityVC alloc]init];
    
    
    
    GUNMMCityMangerVc *cityManger = [[GUNMMCityMangerVc alloc]init];
    
    
    
    cityManger.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:cityManger animated:NO];
    
    
    [_cityVc getBlock:^(NSString *cityName) {
        
        
        
        if (_cityName.count == 0) {
            
            NSArray *arr = kHistoryData;
            
            [_cityName insertObjects:kHistoryData atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, arr.count)]];
        }
        
        //下面这些代码的功能  后来用 GUNMMCityVC 里的 点击方法实现了
        //用来标记是否在原数组中查找到这个名字  如果查找到 则 不将这个名字写入_cityName 不更新数据loadCurrentDay
        //        int a = 1;
        //
        //        for (NSString *str in _cityName) {
        //            if ([str isEqualToString:cityName]) {
        //                //如果查到
        //                a = 0;
        //
        //                break;
        //            }
        //        }
        //
        //        if (a) {
        //如果没查到
        //            _city = cityName;
        //
        //
        //            NSLog(@"是新的");
        //            [_cityName addObject:_city];
        //
        //
        //
        //            [self loadCurrentDay];
        //
        //
        //            //持久化保存
        //            [[NSUserDefaults standardUserDefaults] setObject:_cityName forKey:@"historyData"];
        //
        //        }
        
        
        _city = cityName;
        
        
        [_cityName addObject:_city];
        
        
        
        [self loadCurrentDay];
        
        
        //持久化保存
        [[NSUserDefaults standardUserDefaults] setObject:_cityName forKey:@"historyData"];
        
    }];
    
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
