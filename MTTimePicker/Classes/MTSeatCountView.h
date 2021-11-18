//
//  MTSeatCountView.h
//  MTTimePicker
//
//  Created by Tom.Liu on 2021/11/18.
//

#import <UIKit/UIKit.h>

@protocol MTSeatCountViewProtocol<NSObject>

- (void)confirmSeatNumber:(NSInteger)count;

- (void)cancleSeatChoose;

- (void)backToTimeSetting;

@end

NS_ASSUME_NONNULL_BEGIN

@interface MTSeatCountView : UIView

@property (nonatomic,weak) id <MTSeatCountViewProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
