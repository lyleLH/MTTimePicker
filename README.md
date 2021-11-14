# MTTimePicker
 
## Example

![demo](https://github.com/lyleLH/MTTimePicker/blob/master/%E5%B1%8F%E5%B9%95%E5%BD%95%E5%88%B62021-11-14%20%E4%B8%8B%E5%8D%884.12.29.gif)


## Usage

code 

```objc
#import <MTTimePicker/MTTimeSetView.h>
#define kScreenSize [UIScreen mainScreen].bounds.size

```

```objc
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
```

```objc

#pragma mark -- MTTimeSetViewDelegate

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
```

output

```shell
2021-11-14 16:20:15.851593+0800 MTTimePicker_Example[43166:1330998] 最早时间:2021-11-14 12:30:00,今天 12:30
2021-11-14 16:20:22.800675+0800 MTTimePicker_Example[43166:1330998] 最早时间:2021-11-16 19:30:00,后天 19:30

```

## Installation
 

```ruby
pod 'MTTimePicker'
```

## Author

Tom.Liu, v2top1lyle@gmail.com

## License

MTTimePicker is available under the MIT license. See the LICENSE file for more info.
