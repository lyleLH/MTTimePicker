//
//  MTSeatCountView.m
//  MTTimePicker
//
//  Created by Tom.Liu on 2021/11/18.
//

#import "MTSeatCountView.h"
#import "MTSeatCell.h"
@interface MTSeatCountView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView * seatCountView;

@end

@implementation MTSeatCountView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width, 35)];
    titleLabel2.text = @"请选择最晚出发时间";
    titleLabel2.font = [UIFont boldSystemFontOfSize:22];
    [self addSubview:titleLabel2];
    
    
    
    [self.seatCountView setFrame: CGRectMake(0, 50, self.frame.size.width, 180)];

    [self addSubview:self.seatCountView];
 
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(15,CGRectGetMaxY(self.seatCountView.frame)+20,115,54);
    button2.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [button2 setTitleColor:[UIColor colorWithRed:189/255.0 green:196/255.0 blue:206/255.0 alpha:1.0] forState:UIControlStateNormal];
    [button2 setTitle:@"上一步" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button2 addTarget:self action:@selector(backToSetTime) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button2];
    
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(CGRectGetMaxX(button2.frame)+15,CGRectGetMaxY(self.seatCountView.frame)+20,self.frame.size.width -30-15-button2.frame.size.width,54);
    button3.backgroundColor = [UIColor colorWithRed:58/255.0 green:227/255.0 blue:170/255.0 alpha:1.0];
    [button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button3 setTitle:@"确定" forState:UIControlStateNormal];
    button3.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [button3 addTarget:self action:@selector(confirmSeatCount) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button3];
}
 
- (void)backToSetTime {
    
}

- (void)confirmSeatCount {
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTSeatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kMTSeatCell" forIndexPath:indexPath];
    cell.countLabel.text = [NSString stringWithFormat:@"%ld人",(long)indexPath.item];
    
    return cell;
}

- (UICollectionView *)seatCountView   {
    if(!_seatCountView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView * seatCountView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _seatCountView = seatCountView;
        [seatCountView registerClass:[MTSeatCell class] forCellWithReuseIdentifier:@"kMTSeatCell"];
        seatCountView.delegate = self;
        seatCountView.dataSource = self;
        
        
    }
    return _seatCountView;
}
@end
