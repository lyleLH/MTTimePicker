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
@property (nonatomic,assign)NSInteger seatCount;
@end

@implementation MTSeatCountView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (NSInteger)seatCount {
    if(!_seatCount) {
        _seatCount  = 1;
    }
    return _seatCount;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.frame.size.width, 35)];
    titleLabel2.text = @"请选择乘车人数";
    titleLabel2.font = [UIFont boldSystemFontOfSize:22];
    [self addSubview:titleLabel2];
    [self.seatCountView setFrame: CGRectMake(0, 50, self.frame.size.width, 180)];
    [self addSubview:self.seatCountView];
    [self.seatCountView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    dispatch_block_t descBlock = ^(){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(30,45,self.frame.size.width,20);
        label.numberOfLines = 0;
  

        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]
                                             initWithString:@"若有婴幼儿，需计入乘车人数"
                                             attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:140/255.0 green:145/255.0 blue:152/255.0 alpha:1.0]}];

        label.attributedText = string;
        label.textColor = [UIColor colorWithRed:140/255.0 green:145/255.0 blue:152/255.0 alpha:1.0];
        label.alpha = 1.0;
        [self addSubview:label];
    };
    
    descBlock();
    
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
    if([self.delegate respondsToSelector:@selector(backToTimeSetting)]){
        [self.delegate backToTimeSetting];
    }
}

- (void)confirmSeatCount {
    if([self.delegate respondsToSelector:@selector(confirmSeatNumber:)]){
        [self.delegate confirmSeatNumber:self.seatCount];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}


/**
 cell的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width -60 -20)/3.0;
    return CGSizeMake(itemW, 40);
}

/**
 每个分区的内边距（上左下右）
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(40, 30, 40, 30);
}

/**
 分区内cell之间的最小行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

/**
 分区内cell之间的最小列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MTSeatCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kMTSeatCell" forIndexPath:indexPath];
    cell.countLabel.text = [NSString stringWithFormat:@"%ld人",(long)(indexPath.item+1)];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.seatCount = indexPath.row +1;
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
