//
//  MTTimeSetView.m
//  UIPickerViewDemo
//
//  Created by mttgcc on 11/14/21.
//  Copyright © 2021 Bulet. All rights reserved.
//

#import "MTTimeSetView.h"
#import "MTSeatCountView.h"
@interface MTTimeSetView ()
@property (nonatomic,strong)UIScrollView * scrolleView;
@property (nonatomic,strong)MTTimePickView * timeView1;
@property (nonatomic,strong)MTTimePickView * timeView2;
@property (nonatomic,strong)NSDate * date1;
@property (nonatomic,strong)NSDate * date2;
@property (nonatomic,strong)NSString * timeString1;
@property (nonatomic,strong)NSString * timeString2;
@end

@implementation MTTimeSetView
 

- (void)layoutSubviews {
    [super layoutSubviews];

    [self addSubview:self.scrolleView];
    [self.scrolleView setFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height)];
    
}

- (void)setUpTimePickView {
    UIView * startView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width, 35)];
    titleLabel.text = @"请选择最早出发时间";
    [startView addSubview:titleLabel];
    titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
    MTTimePickView * timeView1 = [[MTTimePickView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 180)];
    timeView1.delegate = self;
    [startView addSubview:timeView1];
    _timeView1 = timeView1;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(15,CGRectGetMaxY(timeView1.frame)+20,self.frame.size.width -30,54);
    button.backgroundColor = [UIColor colorWithRed:58/255.0 green:227/255.0 blue:170/255.0 alpha:1.0];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button addTarget:self action:@selector(confirmStartTime) forControlEvents:UIControlEventTouchUpInside];
    [startView addSubview:button];
    
    [self.scrolleView addSubview:startView];
    
    
    UIView * endView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    
    UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width, 35)];
    titleLabel2.text = @"请选择最晚出发时间";
    titleLabel2.font = [UIFont boldSystemFontOfSize:22];
    [endView addSubview:titleLabel2];
    
    
    MTTimePickView * timeView2 = [[MTTimePickView alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 180)];
    timeView2.delegate = self;
    [endView addSubview:timeView2];
    _timeView2 = timeView2;
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(15,CGRectGetMaxY(timeView2.frame)+20,115,54);
    button2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [button2 setTitleColor:[UIColor colorWithRed:189/255.0 green:196/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button2 setTitle:@"上一步" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button2 addTarget:self action:@selector(backToStatTime) forControlEvents:UIControlEventTouchUpInside];
    [endView addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(CGRectGetMaxX(button2.frame)+15,CGRectGetMaxY(timeView1.frame)+20,self.frame.size.width -30-15-button2.frame.size.width,54);
    button3.backgroundColor = [UIColor colorWithRed:58/255.0 green:227/255.0 blue:170/255.0 alpha:1.0];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 setTitle:@"确定" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button3 addTarget:self action:@selector(confirmEndTime) forControlEvents:UIControlEventTouchUpInside];
    [endView addSubview:button3];
    
    [self.scrolleView addSubview:endView];
    
    
    MTSeatCountView* seatView = [[MTSeatCountView alloc ] init];
    [seatView setFrame:CGRectMake(2*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self.scrolleView addSubview:seatView];
    
    
}

- (void)confirmStartTime {
    [self.scrolleView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:YES];
    if([self.delegate respondsToSelector:@selector(confirmStartDate:showTime:)]){
        [self.delegate confirmStartDate:self.date1 showTime:self.timeString1];
    }
}

- (void)backToStatTime {
    [self.scrolleView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)confirmEndTime {
    [self.scrolleView setContentOffset:CGPointMake(2*self.frame.size.width, 0) animated:YES];
    if([self.delegate respondsToSelector:@selector(confirmStartDate:showTime:)]){
        [self.delegate confirmStartDate:self.date2 showTime:self.timeString2];
    }
}

- (void)pickView:(MTTimePickView*)pickView pickedDate:(NSDate *)date andTimeString:(NSString *)timeString {
    if([pickView isEqual:self.timeView1 ]){
        self.date1 = date;
        self.timeString1 = timeString;
    }else if([pickView isEqual:self.timeView2]){
        self.date2 = date;
        self.timeString2 = timeString;
    }
}


- (UIScrollView *)scrolleView {
    if(!_scrolleView){
        UIScrollView * scrolleView = [[UIScrollView alloc] init];
//        scrolleView.backgroundColor = [UIColor linkColor];
        scrolleView.scrollEnabled = YES;
        scrolleView.contentSize = CGSizeMake(scrolleView.bounds.size.width*3, scrolleView.bounds.size.height);
        scrolleView.delegate = self;
        scrolleView.pagingEnabled = YES;
        scrolleView.showsHorizontalScrollIndicator = NO;
        scrolleView.scrollEnabled = NO;
        _scrolleView = scrolleView;
        [self setUpTimePickView];
        
        
    }
    return _scrolleView;
}


@end
