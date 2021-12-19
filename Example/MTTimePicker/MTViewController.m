//
//  MTViewController.m
//  MTTimePicker
//
//  Created by Tom.Liu on 11/14/2021.
//  Copyright (c) 2021 Tom.Liu. All rights reserved.
//

#define kScreenSize [UIScreen mainScreen].bounds.size


#import "MTViewController.h"
#import <MTTimePicker/MTTimeSetView.h>
@interface MTViewController () <MTTimeSetViewDelegate>

@end

@implementation MTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 350;
    CGFloat originX = (kScreenSize.width - width)*0.5;
    CGFloat originY = (kScreenSize.height - height)*0.5;
    MTTimeSetView * timeSetView =[[MTTimeSetView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
    timeSetView.delegate = self;
    [self.view addSubview:timeSetView];
    
 
}
 
- (void)confirmStartDate:(NSDate *)date showTime:(NSString *)showTime {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSLog(@"最早时间:%@,%@",[fmt stringFromDate:date],showTime);

}

- (void)confirmEndDate:(NSDate *)date showTime:(NSString *)showTime {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSLog(@"最晚时间:%@,%@",[fmt stringFromDate:date],showTime);
}

- (void)cancleSeatChoose {
    
}

- (void)confirmSeatNumber:(NSInteger)count {
    
    NSLog(@"当前选中的人数 %ld",count);
}

@end
