//
//  MTTimeSetView.h
//  UIPickerViewDemo
//
//  Created by mttgcc on 11/14/21.
//  Copyright © 2021 Bulet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MTTimePickView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MTTimeSetViewDelegate <NSObject>

- (void)confirmStartDate:(NSDate*)date showTime:(NSString *)showTime;

- (void)confirmEndDate:(NSDate*)date showTime:(NSString *)showTime;

@end

@interface MTTimeSetView : UIView
@property (nonatomic,weak)id <MTTimeSetViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
