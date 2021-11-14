//
//  MTTimePickView.m
//  UIPickerViewDemo
//
//  Created by mttgcc on 11/13/21.
//  Copyright © 2021 Bulet. All rights reserved.
//

#import "MTTimePickView.h"
#import "ZGPickerView.h"





@interface MTTimePickView ()<ZGPickerViewDelegate>

@property (nonatomic,strong) ZGPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray* pickerDataSource;
@property (nonatomic,strong) NSMutableDictionary *selectedCache;
@property (nonatomic,assign) BOOL hasSetSelectedRow;
@property (nonatomic,strong) NSNumber *dayIndex;
@property (nonatomic,strong) NSNumber *hourIndex;
@property (nonatomic,strong) NSNumber *minIndex;


@end
@implementation MTTimePickView
 
 
-(void)layoutSubviews {
    [super layoutSubviews];
    [self.pickerView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self caculateResult];
}

#pragma mark - zgpickerview delegate
- (void)ZGPickerView:(ZGPickerView *)pickerView currentComponent:(NSInteger)currentComponent currentRow:(NSInteger)currentRow
{

    if (currentComponent == 0) {
        self.dayIndex = [NSNumber numberWithInteger:currentRow];
    } else if (currentComponent == 1) {
        self.hourIndex= [NSNumber numberWithInteger:currentRow];
    } else {
        self.minIndex = [NSNumber numberWithInteger:currentRow];
    }
   
    [self caculateResult];
    
}

- (void)caculateResult {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    NSString *nowDateStr = [format stringFromDate:[NSDate date]];
    //找出今天0点的时间
    NSDate *date = [format dateFromString:nowDateStr];

    //用户选择的时间  (天  小时  分钟 )
    NSDate *userSelectDate = [date dateByAddingTimeInterval:60 * 60 * 24 * self.dayIndex.integerValue + 60 * 60 *self.hourIndex.integerValue + 60  * self.minIndex.integerValue];

   

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString * showTimeString = [NSString stringWithFormat:@"%@ %@:%@",self.pickerDataSource[0][self.dayIndex.integerValue],self.pickerDataSource[1][self.hourIndex.integerValue],self.pickerDataSource[2][self.minIndex.integerValue]];
    
    if([self.delegate respondsToSelector:@selector(pickView:pickedDate:andTimeString:)]){
        [self.delegate pickView:self pickedDate:userSelectDate andTimeString:showTimeString];
    }
    //    NSLog(@"%@,%@",[fmt stringFromDate:userSelectDate],showTimeString);
}

 
- (NSMutableArray *)pickerDataSource {
    if(!_pickerDataSource){
        NSMutableArray* arr = [NSMutableArray new];
         NSArray * arrDays = @[
                @"今天",
                @"明天",
                @"后天"
        ];
        [arr addObject:arrDays];

         NSArray * arrHours = @[
                @"00",
                @"01",
                @"02",
                @"03",
                @"04",
                @"05",
                @"06",
                @"07",
                @"08",
                @"09",
                @"10",
                @"11",
                @"12",
                @"13",
                @"14",
                @"15",
                @"16",
                @"17",
                @"18",
                @"19",
                @"20",
                @"21",
                @"22",
                @"23"
        ];
        [arr addObject:arrHours];
        NSMutableArray * minus = [NSMutableArray new];
        for (int i = 0; i < 60; ++i) {
            [minus addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [arr addObject:minus];
        _pickerDataSource =  [arr copy];
    }
    return _pickerDataSource;
}
 

- (ZGPickerView *)pickerView {
    if (!_pickerView) {
        
        _pickerView = [[ZGPickerView alloc] init];
        _pickerView.dataArr =  self.pickerDataSource;
        _pickerView.defaultSelectedRow = @[@(0),@(12),@(30)];
        _pickerView.selectedBackgroudColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    //    self.pickerView.selectedTextColor = [UIColor blueColor];
    //    self.pickerView.normalTextColor = [UIColor redColor];
        _pickerView.pvDelegate = self;
        [self addSubview:_pickerView];
        [_pickerView reloadAllComponents];
    }
    return _pickerView;
}

- (NSNumber *)dayIndex {
    if (!_dayIndex) {
        _dayIndex = [NSNumber numberWithInteger:0];
    }
    return _dayIndex;
}

- (NSNumber*)hourIndex {
    if(!_hourIndex){
        _hourIndex = [NSNumber numberWithInteger:12];
    }
    return  _hourIndex;
}

- (NSNumber *)minIndex {
    if(!_minIndex){
        _minIndex = [NSNumber numberWithInteger:30];
    }
    return _minIndex;
}

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end
