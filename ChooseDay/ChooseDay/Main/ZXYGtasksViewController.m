//
//  ZXYGtasksViewController.m
//  ChooseDay
//
//  Created by Rockeen on 16/1/19.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "ZXYGtasksViewController.h"
#import "UIImage+RTTint.h"
#import "GtasksData.h"
#import "CslendarCell.h"

@interface ZXYGtasksViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

static const NSInteger rangeTop=20;

@implementation ZXYGtasksViewController{

    UITableView *_storyView;
    
//    UIView *_finishView;

    NSInteger x;


    UIScrollView *_bgScrollView;
    
    NSArray *_willArray;
    NSArray *_FinishArray;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    self.view.backgroundColor=kMainColor;
    
    //获取数据
    [self addData];

    [self haveData];

    
    //导航项设置
    [self navagationItem];
    
    
   
    //添加textView
    [self creatTextView];
    
    //添加两个视图
    [self addTowView];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}





- (void)addData{
    
    //1.获取文件路径
    NSString *jsonPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/gtasks.json"];
    
//    NSLog(@"%@",jsonPath);
    
    //2.获取文件中内容
    NSData *jsondata = [NSData dataWithContentsOfFile:jsonPath];
    
    
    
    //3.解析json数据
    _gtasksAllDayDic = [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingAllowFragments error:nil];
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{



    [_zxyTextView resignFirstResponder];


}


//顶部视图
- (void)navagationItem{

    
    UIView *itemView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
    
    itemView.backgroundColor=kMainColor;
    
    self.navigationItem.titleView=itemView;
    
    
    UILabel *itemLable=[[UILabel alloc]initWithFrame:CGRectMake(0, 12, kScreenW, 64)];
    
    itemLable.text=_dataStr;
    itemLable.font=[UIFont systemFontOfSize:20];
    itemLable.textColor=[UIColor whiteColor];
    itemLable.textAlignment=NSTextAlignmentCenter;
    
    [itemView addSubview:itemLable];
    
    
    //创建第二个左侧btn项
    //使用系统的添加图片的方法 需要注意设置图片类型UIImageRenderingModeAlwaysOriginal（不经过渲染的原生图片）
    UIImage *image=[[UIImage imageNamed:@"fun_ic_forward_left"] rt_tintedImageWithColor:[UIColor whiteColor] level:0 ];
    
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];

    [leftBtn setImage:image forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(leftbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [itemView addSubview:leftBtn];
    
    
    
    //创建第二个右侧的btn项  自定义
    UIButton *rightBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW-80, 30, 30, 30)];

    
    UIImage *image2=[[UIImage imageNamed:@"fun_ic_detail"] rt_tintedImageWithColor:[UIColor whiteColor] level:0 ];
    

    [rightBtn2 setImage:image2 forState:UIControlStateNormal];

    
    [rightBtn2 addTarget:self action:@selector(rightBtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    [itemView addSubview:rightBtn2];

    
    
    

    
    UIButton *rightBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(kScreenW-40, 30, 30, 30)];

    
    UIImage *image3=[[UIImage imageNamed:@"fun_ic_share"] rt_tintedImageWithColor:[UIColor whiteColor] level:0 ];
    
    
    [rightBtn3 setImage:image3 forState:UIControlStateNormal];
    
    [rightBtn3 addTarget:self action:@selector(rightBtn3:) forControlEvents:UIControlEventTouchUpInside];
    
    [itemView addSubview:rightBtn3];
    
    [self.view addSubview:itemView];
    
}

- (void)leftbtn:(UIButton *)btn{


    [self.navigationController popToRootViewControllerAnimated:YES];





}

- (void)rightBtn2:(UIButton *)btn{






}

- (void)rightBtn3:(UIButton *)btn{
    
    
    
    
    
    
}



#pragma mark-----scrollView





#pragma mark-----creatTextView
- (void)creatTextView{


    
    _zxyTextView=[[ZXYTextView alloc]init];
    
    _zxyTextView.delegate=self;
    

    
    
    //KVO
//    [_zxyTextView addObserver:self forKeyPath:@"textViewHeight" options:NSKeyValueObservingOptionNew context:nil];
    
    _zxyTextView.frame=CGRectMake(10, 64+rangeTop, kScreenW-20, 36.5);
    
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(twoViewLaout) name:@"heightChange" object:nil];
    
    
    
    
    
    [self.view addSubview:_zxyTextView];
    
    
//    //mas布局
//    [_zxyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        
//        make.left.equalTo(self.view).with.offset(10);
//        
//        make.right.equalTo(self.view).with.offset(-10);
//        
//        make.top.equalTo(self.view).with.offset(64+20);
//        
//        make.height.mas_equalTo(40);
//        
//        
//        
//    }];


}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    
//    
//    NSLog(@"bianhuale");
//    
//    
//    
//}


#pragma mark - UITextView Delegate

//回车保存
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        
        GtasksData *gtd=[GtasksData new];
        
        [gtd insertOneDayWillArray:_dataStr content:textView.text];
        
        
        
        [self.navigationController popViewControllerAnimated:YES];
        
        textView.text=nil;
        return NO;
        
   
    }
    return YES;
}


- (void)addTowView{

    _storyView=[UITableView new];
    
    _storyView.delegate=self;
    _storyView.dataSource=self;
    
    _storyView.backgroundColor=[UIColor clearColor];
    
    _storyView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    
    _storyView.showsVerticalScrollIndicator=NO;
    
    
    [self.view addSubview:_storyView];
    
    [self twoViewLaout];


}



- (void)twoViewLaout{


    
    
//    [_willView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.mas_equalTo(self.view);
//        
//        make.left.equalTo(self.view);
//        
//        //        make.right.equalTo(self.view);
//        
//        make.top.equalTo(_zxyTextView.mas_bottom).with.offset(20);
//        
//        
//        
//        CGFloat h=(kScreenH-64-49-_zxyTextView.height-rangeTop*8)/2;
//        
//        make.height.mas_equalTo(100);
//        
//    }];
    
    
    _storyView.frame=CGRectMake(0, _zxyTextView.bottom+20, kScreenW, kScreenH-_zxyTextView.bottom-20-49);
    
    
//    _finishView.frame=CGRectMake(0, _willView.bottom+20, kScreenW, 100);
    
    
    
//    [_finishView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerX.mas_equalTo(self.view);
//        
//        make.left.equalTo(self.view);
//        
//        make.top.equalTo(_willView.mas_bottom).with.offset(20);
//        
//        
//        
//        CGFloat h=(kScreenH-64-49-_zxyTextView.height-rangeTop*8)/2;
//        
//        make.height.mas_equalTo(100);
//        
//        
//    }];
    



}


- (void)haveData{


    GtasksData *gtd=[GtasksData new];

    //获得willarray
     _gtasksOneDayWillArray=[gtd getOneDayWillArray:self.dataStr];

    
    //获得FinishArray
     _gtasksOneDayFinishArray=[gtd getOneDayFinishArray:self.dataStr];
    
    



}

#pragma mark-----UITableViewDataSource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return 2;


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (section==0) {
        

        return _gtasksOneDayWillArray.count;
        

        
    }else{
    

        return _gtasksOneDayFinishArray.count;
    
    }

    




}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    static NSString *identifer=@"Cell";
    
    CslendarCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    
    
    if (!cell) {
        
        cell=[[ NSBundle mainBundle]loadNibNamed:@"CslendarCell" owner:nil options:nil].lastObject;
    }
    
    //黄色原点
    cell.circleView.layer.cornerRadius=2.5;
    cell.circleView.layer.masksToBounds=YES;
    cell.circleView.backgroundColor=[UIColor yellowColor];
    
    
    //倒序排列
    
    if (indexPath.section==0) {
        
        x=_gtasksOneDayWillArray.count-1-indexPath.row;
        cell.textLable.text=_gtasksOneDayWillArray[x];
        
        UIButton *btn=[UIButton new];
        
        
        
        
        
        
        btn.backgroundColor=[UIColor clearColor];
        
        [btn setImage:[UIImage imageNamed:@"check_false.png"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"check_true.png"] forState:UIControlStateHighlighted];
        
        
        [btn addTarget:self action:@selector(yesBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [cell addSubview:btn];
        
        cell.tag=_gtasksOneDayWillArray.count-1-indexPath.row;
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell).with.offset(-10);
            
            make.top.equalTo(cell).with.offset(10);
            
            
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(20);
            
            
        }];

    }else{
    
        x=_gtasksOneDayFinishArray.count-1-indexPath.row;
        cell.textLable.text=_gtasksOneDayFinishArray[x];
    
    }
    
    cell.backgroundColor=kMainColor;

    cell.textLable.textColor=[UIColor whiteColor];

    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    
    //选中按钮
    cell.yesBtn.hidden=YES;
    //    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(cell.width-10-20, 10, 20, 20)];
    
    
    return cell;



}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{


    return 40;


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{


    UILabel *sectionHeader=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
    
    if (section==0) {
        
        sectionHeader.text=@"未完成事项";
        
        
    }else{
        
    
        sectionHeader.text=@"已完成事项";
    }
    
    sectionHeader.textColor=[UIColor whiteColor];
    
    sectionHeader.backgroundColor=kMainColor;
    
    sectionHeader.textAlignment=NSTextAlignmentCenter;
    
    return sectionHeader;






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
