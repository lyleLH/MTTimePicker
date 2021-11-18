//
//  MTTimePickView.h
//  UIPickerViewDemo
//
//  Created by mttgcc on 11/13/21.
//  Copyright © 2021 Bulet. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MTTimePickView;
@protocol MTTimePickViewDelegate <NSObject>

- (void)pickView:(MTTimePickView*)pickView pickedDate:(NSDate *)date andTimeString:(NSString *)timeString;

@end

@interface MTTimePickView : UIView

@property (nonatomic,weak)id <MTTimePickViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
