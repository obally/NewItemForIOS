//
//  OBTimeSignalViewController.m
//  RACTest
//
//  Created by obally on 2017/8/23.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBTimeSignalViewController.h"

@interface OBTimeSignalViewController ()

@end

@implementation OBTimeSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self throttle];
    [self bufferWithTime];
    self.view.backgroundColor = [UIColor whiteColor];
  
}
- (void)throttle
{
    //18.节流
    RACSignal *signalTime = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"旅客A"];
        [subscriber sendNext:@"旅客AA"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"旅客B"];
            [subscriber sendNext:@"旅客BB"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"旅客C"];
            [subscriber sendNext:@"旅客D"];
            [subscriber sendNext:@"旅客EE"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@"旅客F"];
            [subscriber sendNext:@"旅客FF"];
        });
        return nil;
    }];
    //获取两秒钟内最新的那个信号值
    //    [[signalTime throttle:2]subscribeNext:^(id x) {
    //        NSLog(@"%@通过了",x);
    //    }];
    [[signalTime throttle:2 valuesPassingTest:^BOOL(id next) {
        
        if ([next isEqualToString:@"旅客A"]) {
            return YES;
        }
        return NO;
        
    }]subscribeNext:^(id x) {
        NSLog(@"%@通过了",x);
    }];
}
//在未来的一段时间内缓冲信号值,然后到时间后发放,如果多个值则用RACTuple
- (void)bufferWithTime
{
     [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [subscriber sendNext:@"A"];
             [subscriber sendNext:@"B"];
         });
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [subscriber sendNext:@"C"];
             [subscriber sendNext:@"D"];
         });
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [subscriber sendNext:@"E"];
             [subscriber sendNext:@"F"];
         });
        return nil;
    }]bufferWithTime:3 onScheduler:[RACScheduler mainThreadScheduler]]subscribeNext:^(id x) {
        NSLog(@"bufferWithTime ----%@",x);
    }];
}
@end
