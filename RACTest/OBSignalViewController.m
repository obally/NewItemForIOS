//
//  OBSignalViewController.m
//  RACTest
//
//  Created by obally on 2017/8/22.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBSignalViewController.h"
#import <libkern/OSAtomic.h>

@interface OBSignalViewController ()
@property(nonatomic,copy) NSString *valueA;
@property(nonatomic,copy) NSString *valueB;
@end

@implementation OBSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self test];
//    [self test1];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self test5];
    [self mutiConnect];
    // Do any additional setup after loading the view.
}

- (void)test
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendCompleted];
        return nil;
    }];
    NSLog(@"signal was created");
    [[RACScheduler mainThreadScheduler] afterDelay:0.1 schedule:^{
       [signal subscribeNext:^(id x) {
           NSLog(@"Subscribe 1 receive :%@",x);
       }];
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
       [signal subscribeNext:^(id x) {
           NSLog(@"Subscribe 2 receive :%@",x);
       }];
    }];
    
}
- (void)test1
{
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
            [subscriber sendNext:@"wo"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"shi"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
            [subscriber sendNext:@"xiao"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:4 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }] publish];
    [connection connect];
    RACSignal *signal = connection.signal;
    NSLog(@"signal was created");
    [[RACScheduler mainThreadScheduler]afterDelay:1.1 schedule:^{
       [signal subscribeNext:^(id x) {
           NSLog(@"subscribe 1 receive:%@",x);
       }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 recveive: %@", x);
        }];
    }];
}
- (void)test2
{
    RACMulticastConnection *connection = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@1];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@2];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@3];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }] publish];
    [connection connect];
    RACSignal *signal = connection.signal;
    
    NSLog(@"Signal was created.");
    [[RACScheduler mainThreadScheduler] afterDelay:1.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 1 recveive: %@", x);
        }];
    }];
    
    [[RACScheduler mainThreadScheduler] afterDelay:2.1 schedule:^{
        [signal subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 recveive: %@", x);
        }];
    }];
}
- (void)test3
{
    RACSubject *subject = [RACSubject subject];
    RACSubject *replaySubject = [RACReplaySubject subject];
    [[RACScheduler mainThreadScheduler]afterDelay:0.1 schedule:^{
        // Subscriber 1
        [subject subscribeNext:^(id x) {
            NSLog(@"subscribe 1 get a next value :%@ from subject",x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"subscribe 1 get a next value :%@ from replay subject",x);
        }];
        
        // Subscriber 2
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 get a next value: %@ from replay subject", x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
        [subject sendNext:@"send package 1"];
        [replaySubject sendNext:@"send package 1"];
        
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
        // Subscriber 3
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 3 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 3 get a next value: %@ from replay subject", x);
        }];
        
        // Subscriber 4
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 4 get a next value: %@ from subject", x);
        }];
        [replaySubject subscribeNext:^(id x) {
            NSLog(@"Subscriber 4 get a next value: %@ from replay subject", x);
        }];
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:4 schedule:^{
        [subject sendNext:@"send package 2"];
        [replaySubject sendNext:@"send package 2"];
    }];
}
- (void)test4
{
    RACSignal *coldSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"Cold signal be subscribed.");
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@"A"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:3 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendCompleted];
        }];
        
        return nil;
    }];
    
    RACSubject *subject = [RACSubject subject];
    NSLog(@"Subject created.");
    
    [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
        [coldSignal subscribe:subject];
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"Subscriber 1 recieve value:%@.", x);
    }];
    [[RACScheduler mainThreadScheduler] afterDelay:6 schedule:^{
        [subject subscribeNext:^(id x) {
            NSLog(@"Subscriber 2 recieve value:%@.", x);
        }];
    }];
    
}
- (void)test5
{
    RACSignal *codeSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"Cold signal be subscribed.");
        [[RACScheduler mainThreadScheduler] afterDelay:1 schedule:^{
            [subscriber sendNext:@"A"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:1.5 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        [[RACScheduler mainThreadScheduler] afterDelay:2 schedule:^{
            [subscriber sendNext:@"C"];
        }];
        
        [[RACScheduler mainThreadScheduler] afterDelay:5 schedule:^{
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    //方案一： 将冷信号转化为热信号
//    RACSubject *subject = [RACSubject subject];
//    NSLog(@"subject created");
//    RACMulticastConnection *connection = [codeSignal multicast:subject];
//     RACSignal *hotSignal = connection.signal;
//    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
//        [connection connect];
//    }];
    
    //方案二  不需要再创建 RACSubject publish内部创建
//    RACMulticastConnection *connection = [codeSignal publish];
//    RACSignal *hotSignal = connection.signal;
//    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
//        [connection connect];
//    }];
    //方案三 自动连接 不需要再调 connect方法
//    RACSubject *subject = [RACSubject subject];
//    RACMulticastConnection *connection = [codeSignal multicast:subject];
//    RACSignal *hotSignal = connection.autoconnect;
//    
    //方案四 内部调用RACReplaySubject 保存之前的值
//    RACSignal *hotSignal = [codeSignal replay];
    //方案五 内部调用RACReplaySubject 保存最后的那个值
//    RACSignal *hotSignal = [codeSignal replayLast];
    //方案六 replayLazily会在第一次订阅的时候才订阅sourceSignal 创建一个新的信号
    RACSignal *hotSignal = [codeSignal replayLazily];
    [hotSignal subscribeNext:^(id x) {
        NSLog(@"Subscribe 1 recieve value:%@.", x);
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:4.1 schedule:^{
        [hotSignal subscribeNext:^(id x) {
            NSLog(@"Subscribe 2 recieve value:%@.", x);
        }];
        
    }];
    
}
//双边响应
- (void)mutiConnect
{
    //3.双边响应
    RACChannelTerminal *channelA = RACChannelTo(self,valueA);
    RACChannelTerminal *channelB = RACChannelTo(self,valueB);
    [[channelA map:^id(NSString *value) {
        if ([value isEqualToString:@"西"]) {
            return @"东";
        }
        return value;
    }]subscribe:channelB];
    [[channelB map:^id(NSString *value) {
        if ([value isEqualToString:@"南"]) {
            return @"北";
        }
        return value;
    }]subscribe:channelA];
    
    [[RACObserve(self, valueA) filter:^BOOL(id value) {
        return value?YES:NO;
    }]subscribeNext:^(NSString *value) {
        NSLog(@"valueA向%@",value);
    }];
    [[RACObserve(self, valueB) filter:^BOOL(id value) {
        return value?YES:NO;
    }]subscribeNext:^(NSString *value) {
        NSLog(@"valueB向%@",value);
    }];
    self.valueA = @"西";
    self.valueB = @"南";

}
@end
