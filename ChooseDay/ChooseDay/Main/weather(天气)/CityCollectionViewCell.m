//
//  CityCollectionViewCell.m
//  ChooseDay
//
//  Created by 闵哲 on 16/1/20.
//  Copyright © 2016年 DreamThreeMusketeers. All rights reserved.
//

#import "CityCollectionViewCell.h"


@implementation CityCollectionViewCell{
    

}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        _label = [[UILabel alloc]initWithFrame:self.bounds];
        
        _label.textAlignment = NSTextAlignmentCenter;
        
        _label.backgroundColor = [UIColor grayColor];
        
        _label.layer.cornerRadius = 15;
        _label.layer.masksToBounds = YES;
        
        
        _label.layer.borderColor = kMainColor.CGColor;

        _label.layer.borderWidth = 2;
        
        [self addSubview:_label];
    }
    return self;
}


- (void)setCityName:(NSString *)cityName{
    _cityName = cityName;
    
    //a用来标记是否查找到
    int a = 0;
    
    for (NSString *str in kHistoryData) {
        if ([str isEqualToString:_cityName]) {
            a = 1;
            break;
        }
    }
    
    
    if (a) {
        _label.textColor = [UIColor whiteColor];
    }
    
    
    
    _label.text = _cityName;
    
    
}

@end
