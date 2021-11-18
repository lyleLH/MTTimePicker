//
//  MTSeatCell.m
//  MTTimePicker
//
//  Created by Tom.Liu on 2021/11/18.
//

#import "MTSeatCell.h"

@interface MTSeatCell()

@property (nonatomic,strong)CAShapeLayer *maskLayer;
@property (nonatomic,strong)UIColor *deselectedColor;
@property (nonatomic,strong)UIColor *selectedColor;

@end


@implementation MTSeatCell



- (CAShapeLayer *)maskLayer {
    if(!_maskLayer) {
        UIBezierPath *maskPath;
        CGRect boardRect;
        boardRect = self.bounds;
        maskPath = [[UIBezierPath bezierPathWithRoundedRect:self.bounds
                                          byRoundingCorners:UIRectCornerAllCorners
                                                cornerRadii:CGSizeMake(10, 10)]
                    bezierPathByReversingPath];

//        for (CALayer *layer in self.contentView.layer.sublayers) {
//            if ([layer.name isEqualToString:@"maskLayer"]) {
//                [layer removeFromSuperlayer];
//            }
//        }
 
 
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.name = @"maskLayer";
        maskLayer.frame = boardRect;
        maskLayer.path = maskPath.CGPath;
        maskLayer.strokeColor = self.deselectedColor.CGColor;
    //    maskLayer.lineDashPattern = @[@4, @2];
        maskLayer.lineWidth = 1.0f;
        maskLayer.fillColor = [UIColor clearColor].CGColor;
        maskLayer.masksToBounds = YES;
        _maskLayer = maskLayer;
    }
    return _maskLayer;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.countLabel];
    [self.countLabel setFrame:self.bounds];
    [self.contentView.layer insertSublayer:self.maskLayer atIndex:0];
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
     
    UIColor *fillColor = (selected == YES) ? self.selectedColor : self.deselectedColor;
    self.maskLayer.strokeColor = fillColor.CGColor;
    self.countLabel.textColor = fillColor;
    
}


- (UILabel *)countLabel {
    if(!_countLabel){
        UILabel * label = [[UILabel alloc] init];
        label.textColor = self.deselectedColor;
        label.textAlignment = 1;
        _countLabel = label;
    }
    return _countLabel;
}


- (UIColor *)selectedColor {
    if(!_selectedColor) {
        _selectedColor = [UIColor colorWithRed:58/255.0 green:227/255.0 blue:170/255.0 alpha:1.0];
    }
    return _selectedColor;
}

- (UIColor *)deselectedColor {
    if(!_deselectedColor) {
        _deselectedColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    }
    return _deselectedColor;
}

@end
