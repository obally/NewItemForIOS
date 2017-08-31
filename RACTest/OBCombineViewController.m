//
//  OBCombineViewController.m
//  RACTest
//
//  Created by obally on 2017/8/25.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBCombineViewController.h"

@interface OBCombineViewController ()

@end

@implementation OBCombineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self startWith];
//    [self concat];
//    [self merge];
//    [self zip];
//    [self zipReduce];
//    [self combineLastest];
//    [self combinePreviousWithStart];
//    [self scanWithStart];
    [self sample];
}
//就是先构造一个只发送一个value的信号，然后这个信号发送完毕之后接上原信号。得到的新的信号就是在原信号前面新加了一个值。
- (void)startWith
{
   [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"liu"];
        [subscriber sendNext:@"jiao"];
        return nil;
    }]startWith:@"huang"]subscribeNext:^(id x) {
        NSLog(@"startWith--------%@",x);
    }];
}
- (void)concat
{
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    [[subject1 concat:subject2]subscribeNext:^(id x) {
        NSLog(@"concat---%@",x);
    }];
    [subject1 sendNext:@"woshi"];
    [subject1 sendNext:@"huang"];
    [subject1 sendCompleted];
    [subject2 sendNext:@"liu"];
    [subject2 sendNext:@"jiao"];
    [subject2 sendCompleted];
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"woshi"];
        [subscriber sendNext:@"huang"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"liu"];
        [subscriber sendNext:@"jiao"];
        [subscriber sendCompleted];
        return nil;
    }];
    [[signalA concat:signalB]subscribeNext:^(id x) {
        NSLog(@"signalConcat---%@",x);
    }];
}
- (void)merge
{
    //6.并联
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"纸厂污水"];
        return nil;
    }];
    RACSignal *signalD = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"点赌城污水"];
        return nil;
    }];
    RACSignal *mergeSignal = [RACSignal merge:@[signalD,signalC]];
    [mergeSignal subscribeNext:^(id x) {
        NSLog(@"并联---------%@",x);
    }];
}
//最后输出的信号以时间最长的为主，最后接到的信号是一个元组，里面依次包含zip:数组里每个信号在一次“压”缩周期里面的值。
- (void)zip
{
    RACSignal *signalA = [RACSignal interval:3 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0];
    RACSignal *signalB = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0];
    RACSignal *signalC = [RACSignal interval:4 onScheduler:[RACScheduler mainThreadScheduler] withLeeway:0];
    RACSignal *zipSignal = (RACSignal *)[RACStream zip:@[signalA,signalB,signalC]];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"zipSignal-----%@",x);
    }];
}
- (void)zipReduce
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@20];
        [subscriber sendNext:@10];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@10];
        return nil;
    }];
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@5];
        return nil;
    }];
    RACSignal *zipSignal = (RACSignal *)[RACStream zip:@[ signalA, signalB,signalC ] reduce:^(NSNumber *numA, NSNumber *numB,NSNumber *numC) {
        return @(numA.integerValue + numB.integerValue + numC.integerValue);
    }];
    [zipSignal subscribeNext:^(id x) {
        NSLog(@"zipSignal-----%@",x);
    }];
  
}
//每个信号每发送出来一个新的值，都会去找另外一个信号上一个最新的值进行结合。
- (void)combineLastestWith
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
           [subscriber sendNext:@"1"];
       }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"2"];
        }];

        [[RACScheduler mainThreadScheduler]afterDelay:4 schedule:^{
            [subscriber sendNext:@"3"];
        }];

        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"4"];
        }];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
            [subscriber sendNext:@"C"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"D"];
        }];
        return nil;
    }];
    [[signalA combineLatestWith:signalB]subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSString *a,NSString*b) = x;
        NSLog(@"combineLatestWith-----%@ %@",a,b);
        
    }];
}
- (void)combineLastest
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
            [subscriber sendNext:@"1"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"2"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:4 schedule:^{
            [subscriber sendNext:@"3"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"4"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:7 schedule:^{
            [subscriber sendNext:@"5"];
        }];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
            [subscriber sendNext:@"C"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"D"];
        }];
        return nil;
    }];
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我"];
        
        [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
            [subscriber sendNext:@"是"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:5 schedule:^{
            [subscriber sendNext:@"小"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:7 schedule:^{
            [subscriber sendNext:@"五"];
        }];
        return nil;
    }];
//    [[RACSignal combineLatest:@[signalA,signalB,signalC]]subscribeNext:^(RACTuple *x) {
//        RACTupleUnpack(NSString *a,NSString*b,NSString *c) = x;
//        NSLog(@"combineLatest-----%@ %@ %@",a,b,c);
//    }];
//    [[RACSubject combineLatest:@[letters,numbers] reduce:^(NSString *letter,NSString *number){
//        return [letter stringByAppendingString:number];
//    }]subscribeNext:^(id x) {
//        NSLog(@"组合拼接后的值------%@",x);
//    }];
    [[RACSignal combineLatest:@[signalA,signalB,signalC] reduce:^(NSString *a,NSString *b,NSString *c){
        return [NSString stringWithFormat:@"%@ %@ %@",a,b,c];
        
    }]subscribeNext:^(id x) {
        NSLog(@"combineLatest---%@",x);
    }];
}
- (void)combinePreviousWithStart
{
    RACSequence *numbers = @[@1,@2,@3,@4].rac_sequence;
    RACSignal *signal = [numbers combinePreviousWithStart:@1 reduce:^id(NSNumber *previous, NSNumber *current) {
        return @(previous.integerValue * current.integerValue);
    }].signal;
    [signal subscribeNext:^(id x) {
        NSLog(@"combinePreviousWithStart--%@",x);
    }];
}
- (void)scanWithStart
{
    RACSequence *numbers = @[@1,@2,@3,@4].rac_sequence;
    RACSignal *signal = [numbers scanWithStart:@1 reduce:^id(NSNumber *previous, NSNumber *current) {
        return @(previous.integerValue * current.integerValue);
    }].signal;
    [signal subscribeNext:^(id x) {
        NSLog(@"combinePreviousWithStart--%@",x);
    }];
}
- (void)sample
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RACScheduler mainThreadScheduler]afterDelay:1 schedule:^{
            [subscriber sendNext:@"1"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"2"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:4 schedule:^{
            [subscriber sendNext:@"3"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"4"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:7 schedule:^{
            [subscriber sendNext:@"5"];
        }];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        
        [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
            [subscriber sendNext:@"B"];
        }];
        
        [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
            [subscriber sendNext:@"C"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:5 schedule:^{
            [subscriber sendNext:@"D"];
        }];
        [[RACScheduler mainThreadScheduler]afterDelay:6 schedule:^{
            [subscriber sendNext:@"E"];
        }];
        return nil;
    }];
    [[signalA sample:signalB]subscribeNext:^(id x) {
        NSLog(@"sample ----%@",x);
    }];
}
@end
