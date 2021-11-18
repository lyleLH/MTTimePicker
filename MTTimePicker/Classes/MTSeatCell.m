//
//  MTSeatCell.m
//  MTTimePicker
//
//  Created by Tom.Liu on 2021/11/18.
//

#import "MTSeatCell.h"

@interface MTSeatCell()


@end


@implementation MTSeatCell

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.countLabel];
    self.layer.cornerRadius =10;
    self.clipsToBounds = YES;
    self.layer.borderColor = [UIColor redColor].CGColor;
}



- (UILabel *)countLabel {
    if(_countLabel){
        _countLabel = [[UILabel alloc] init];
        
    }
    return _countLabel;
}



@end
