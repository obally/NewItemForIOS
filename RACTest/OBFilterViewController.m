//
//  OBFilterViewController.m
//  RACTest
//
//  Created by obally on 2017/8/24.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBFilterViewController.h"
#import <ReactiveCocoa/RACSignalSequence.h>
@interface OBFilterViewController ()

@property(nonatomic,copy) NSString *abc;

@end

@implementation OBFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self filter];
    //    [self ignoreValues];
    //    [self ignore];
    //    [self distinctUntilChanged];
    //    [self take];
    //    [self takeLast];
    //    [self takeUntilBlock];
    //    [self takeWhileBlock];
    //    [self takeUntil];
    //    [self takeUntilReplacement];
    //    [self skip];
    //    [self skipUntilBlock];
    //    [self skipWhileBlock];
    //    [self groupByTransform];
//    [self groupBy];
    [self flatten];
    // Do any additional setup after loading the view.
}
- (void)filter
{
    //10.过滤
    RACSignal *signalf = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(15)];
        [subscriber sendNext:@(18)];
        [subscriber sendNext:@(13)];
        [subscriber sendNext:@(19)];
        [subscriber sendNext:@(20)];
        [subscriber sendNext:@(22)];
        return nil;
    }];
    [[signalf filter:^BOOL(NSNumber *value) {
        return value.integerValue > 18;
    }]subscribeNext:^(id x) {
        NSLog(@"过滤---------%@",x);
    }];
}
//忽略
- (void)ignoreValues
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@"C"];
        [subscriber sendNext:@"D"];
        return nil;
    }]ignoreValues]subscribeNext:^(id x) {
        NSLog(@"ignoreValues忽略结果----%@",x);
    }];
    
}

- (void)ignore
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }]ignore:@1]subscribeNext:^(id x) {
        NSLog(@"ignore忽略之后的值 ----%@",x);
    }];
}
//与上一次信号比较，相同的丢弃，不同的发出
- (void)distinctUntilChanged
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }]distinctUntilChanged]subscribeNext:^(id x) {
        NSLog(@"distinctUntilChanged ----%@",x);
    }];
}
- (void)take
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }]take:2]subscribeNext:^(id x) {
        NSLog(@"take(2) ----%@",x);
    }];
}
- (void)takeLast
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return nil;
    }]takeLast:2]subscribeNext:^(id x) {
        NSLog(@"-takeLast-----%@",x);
    }];
}
//take原信号的值，Until直到闭包满足条件
- (void)takeUntilBlock
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return nil;
    }]takeUntilBlock:^BOOL(id x) {
        return [x isEqual:@1];
    }]subscribeNext:^(id x) {
        NSLog(@"-takeUntilBlock-----%@",x);
    }];
}
- (void)takeWhileBlock
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendCompleted];
        return nil;
    }]takeWhileBlock:^BOOL(id x) {
        return [x isEqual:@1];
    }]subscribeNext:^(id x) {
        NSLog(@"-takeWhileBlock-----%@",x);
    }];
    
}
//给takeUntil传的是哪个信号，那么当这个信号发送信号或sendCompleted，就不能再接受源信号的内容了。
- (void)takeUntil
{
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject1 = [RACSubject subject];
    [[subject takeUntil:subject1]subscribeNext:^(id x) {
        NSLog(@"takeUntil-----%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject1 sendNext:@3];
    [subject sendNext:@2];
}
//一旦replacement信号sendNext，那么原信号就会取消订阅，接下来的事情就会交给replacement信号了。
- (void)takeUntilReplacement
{
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject1 = [RACSubject subject];
    [[subject takeUntilReplacement:subject1]subscribeNext:^(id x) {
        NSLog(@"takeUntil-----%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject1 sendNext:@3];
    [subject sendNext:@4];
    [subject1 sendNext:@5];
    
}
- (void)skip
{
    RACSubject *subject = [RACSubject subject];
    [[subject skip:2]subscribeNext:^(id x) {
        NSLog(@"skip------%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@4];
    [subject sendNext:@5];
}
- (void)skipUntilBlock
{
    RACSubject *subject = [RACSubject subject];
    [[subject skipUntilBlock:^BOOL(id x) {
        return ([x integerValue] >2);
    }]subscribeNext:^(id x) {
        NSLog(@"skipUntilBlock------%@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@1];
    [subject sendNext:@5];
}
- (void)skipWhileBlock
{
    RACSubject *subject = [RACSubject subject];
    [[subject skipWhileBlock:^BOOL(id x) {
        return ([x integerValue] >2);
    }]subscribeNext:^(id x) {
        NSLog(@"skipWhileBlock------%@",x);
    }];
    [subject sendNext:@3];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@4];
    [subject sendNext:@5];
    /**
     signalGroup是原信号signalA经过groupBy:transform:得到的新的信号，这个信号是一个高阶的信号，因为它里面并不是直接装的是值，signalGroup这个信号里面装的还是信号。signalGroup里面有两个分组，分别是“good”分组和“bad”分组。
     
     想从中取出这两个分组里面的值，需要进行一次filter:筛选。筛选之后得到对应分组的高阶信号。这时还要再进行一个flatten操作，把高阶信号变成低阶信号，再次订阅才能取到其中的值。
     */
}
- (void)groupByTransform
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        [subscriber sendNext:@3];
        [subscriber sendNext:@4];
        [subscriber sendNext:@5];
        [subscriber sendNext:@6];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"dispose signal");
        }];
    }];
    RACSignal *signalGroup = [signal groupBy:^id<NSCopying>(NSNumber *object) {
        return object.integerValue > 3?@"good":@"bad";
    } transform:^id(NSNumber *object) {
        return @(object.integerValue * 10);
    }];
    [[[signalGroup filter:^BOOL(RACGroupedSignal *value) {
        return [(NSString *)value.key isEqualToString:@"good"];
    }]flatten]subscribeNext:^(id x) {
        NSLog(@"groupBy ----%@",x);
    }];
}
//flatten是把高阶信号变换成低阶信号的常用操作。flattenMap:具体实现上篇文章分析过了
- (void)flatten
{
    //21.flatten 压平信号中的信号，信号中的信号成为子信号，，flatten可以拿到所有子信号发送的值。switchToLatest：与flatten相同，压平信号中的信号，不同的是，在存在多个子信号时候只会拿到最新的子信号，然后输出最新的子信号的值。
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
    RACSubject *subject3 = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"subject------%@",x);
    }];
    [subject.flatten subscribeNext:^(id x) {
        NSLog(@"subject.flatten ------%@",x);
    }];
    [subject.switchToLatest subscribeNext:^(id  _Nullable x) {
        //输出22, switchToLatest只会拿到最新的子信号发送的值
        NSLog(@"switchToLatest-------%@",x);
    }];
    [subject sendNext:subject3];
    [subject sendNext:subject1];
    [subject sendNext:subject2];
    
    [subject1 sendNext:@1];
    [subject1 sendNext:@11];
    [[RACScheduler mainThreadScheduler]afterDelay:2 schedule:^{
        [subject2 sendNext:@22];
        [subject2 sendNext:@33];
    }];
    [[RACScheduler mainThreadScheduler]afterDelay:3 schedule:^{
        [subject3 sendNext:@44];
        [subject3 sendNext:@44];
    }];
    
    
}
- (void)groupBy
{
    RACSignal *signal = @[@1, @2, @3, @4,@2,@3,@3,@4,@4,@4].rac_sequence.signal;
    NSArray *array = [[[[signal groupBy:^id<NSCopying>(id object) {
        return [NSString stringWithFormat:@"%@",object];
    }]map:^id(RACGroupedSignal *value) {
        return [value sequence];
    }]sequence]map:^id(RACSequence *value) {
        return value.array;
    }].array;
    for (NSArray *subArray in array ) {
        NSLog(@"subArray-------%@",subArray);
    }

    //     通过map 转化为RACSequence 数组 在调用sequence 得到RACSequence的数组 存的是RACSignalSequence
//    NSArray *array = [[[[signal groupBy:^id<NSCopying>(id object) {
//        return [NSString stringWithFormat:@"%@",object];
//    }]map:^id(RACGroupedSignal *value) {
//        return [value sequence];
//    }]sequence]map:^id(RACSignalSequence *value) {
//        return value.array;
//    }].array;
//    for (NSNumber *num in array ) {
//        NSLog(@"最后的数组%@",num);
//    }
}
- (void)add
{
    NSArray *array=@[@"1",@"1",@"3",@"9",@"5",@"5",@"5",@"8",@"8",@"1",@"1",@"2",@"2",@"2"];
    NSMutableArray *array1=[NSMutableArray array];;
    for(int i=0;i<array.count-1;i++){
        int a=[array[i] intValue]+[array[i+1] intValue];
        [array1 addObject:[NSString stringWithFormat:@"%d",a]];
    }
    int max=0;
    for(int i=0;i<array1.count;i++){
        if(max<=[array1[i] intValue]){
            max=[array1[i] intValue];
        }
    }
    NSLog(@"%d",max);
}
-(long long)getDateTimeTOMilliSeconds:(NSDate *)datetime
{
    NSTimeInterval interval = [datetime timeIntervalSince1970];
    NSLog(@"转换的时间戳=%f",interval);
    long long totalMilliseconds = interval*1000 ;
    NSLog(@"totalMilliseconds=%llu",totalMilliseconds);
    return totalMilliseconds;
    
}
- (void)swapAB
{
    int a = 10;int b = 5;
    a = a+b;
    b = a-b;
    a = a-b;
    NSLog(@"%d%d",a,b);
}

@end
