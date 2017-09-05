
//  ViewController.m
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "ViewController.h"
#import "Caculator.h"
#import "OBTableViewController.h"
#import "CustomView.h"
#import "TwoViewController.h"
#import "FlagItem.h"
#import "OBLoginViewController.h"
#import <ReactiveCocoa/RACReturnSignal.h>
#import "SubTextView.h"
#import "OXTouchTextView.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACSignalSequence.h>
#import "OBSignalViewController.h"
#import "OBTimeSignalViewController.h"
#import "OBFilterViewController.h"
#import "OBCombineViewController.h"
#import "StudentTest.h"
#import "Student.h"
@interface ViewController ()
//@property(nonatomic,strong) RACSignal *delegateSignal;
@property(nonatomic,copy) NSString *strValue;
@property(nonatomic,copy) NSString *valueA;
@property(nonatomic,copy) NSString *valueB;
@property(nonatomic,strong) RACCommand *command;
@property(nonatomic,copy) NSMutableArray *A;
@property(nonatomic,strong) UITextField *textFiled;

@property (copy,nonatomic) NSString *name;
@property (strong, nonatomic) StudentTest *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testStudent];
//    [self checkCycle];
//    [self addSignalButton];
//    [self addView];
//    [self test];
//    [self test2];
//    [self test3];
//    [self test4];
//    [self requestData];
//    [self bind];
//    [self ignore];
//    [self reduceEach];
//    [self startWith];
//    [self zip];
//    [self scanWithStart];
//    [self takeUntilBlock];
//    [self takeWhileBlock];
//    [self skipUntilBlock];
//    SubTextView *textView = [[SubTextView alloc]init];
//    [textView texta];
//    [self skipWhileBlock];
//    [self createSignal];
//    [self GCD];
//    [self bind2];
//    [self groupBy];
//    [self mapReplace];
//    [self collect];
//    [self throttle];
//    self.A  = [NSMutableArray array];
//    NSLog(@"=================4");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"=================5");
//    });
//    NSLog(@"=================6");
//    char s[]= "jobs\0";
//    printf("%d %d",strlen(s),sizeof(s));
//    NSTimer *time = nil;
       // Do any additional setup after loading the view, typically from a nib.
}
- (void)testStudent
{
    Student *student = [[Student alloc]init];
    [Student study];
    NSLog(@"student's class is %@",[student class]);
    NSLog(@"Student's meta class is %@", object_getClass([student class]));
    NSLog(@"Student's meta class's superClass is %@",object_getClass(object_getClass([student class])));
    Class currentClass = [Student class];
    for (int i=0; i < 5; i++) {
         NSLog(@"Following the isa pointer %d times gives %p %@", i, currentClass,currentClass);
        currentClass = object_getClass(currentClass);
    }
    NSLog(@"NSObject's class is %p", [NSObject class]);
    NSLog(@"NSObject's meta class is %p", object_getClass([NSObject class]));
}

- (void)checkCycle
{
    StudentTest *student = [[StudentTest alloc]init];
    student.name = @"hello world";
//    student.study = ^{
//        NSLog(@"my name is = %@",student.name);
//    };
//    student.study = ^(NSString * name){
//        NSLog(@"my name is = %@",name);
//    };
//    student.study(student.name);
//    self.name = @"halfrost";
//    self.stu = student;
//    
//    student.study = ^{
//        NSLog(@"my name is = %@",self.name);
//    };
//    
//    student.study();
    __block StudentTest *stu = student;
    student.name = @"Hello World";
    student.study = ^{
        NSLog(@"my name is = %@",stu.name);
        stu = nil;
    };
    
    student.study();
    
}
- (void)addSignalButton
{
    UIButton *button = [[UIButton alloc]init];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.equalTo(@250);
        make.height.equalTo(@40);
        make.top.mas_equalTo(self.view.mas_top).with.offset(70);
    }];
    
    [button setTitle:@"热信号和冷信号" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        OBSignalViewController *signalVC = [[OBSignalViewController alloc]init];
        [self.navigationController pushViewController:signalVC animated:YES];
    }];
    
    UIButton *button1 = [[UIButton alloc]init];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.equalTo(@250);
        make.height.equalTo(@40);
        make.top.mas_equalTo(button.mas_bottom).with.offset(30);
    }];
    
    [button1 setTitle:@"时间操作" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [[button1 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        OBTimeSignalViewController *signalVC = [[OBTimeSignalViewController alloc]init];
        [self.navigationController pushViewController:signalVC animated:YES];
    }];
    
    UIButton *button2 = [[UIButton alloc]init];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.equalTo(@250);
        make.height.equalTo(@40);
        make.top.mas_equalTo(button1.mas_bottom).with.offset(30);
    }];
    
    [button2 setTitle:@"筛选操作" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [[button2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        OBFilterViewController *signalVC = [[OBFilterViewController alloc]init];
        [self.navigationController pushViewController:signalVC animated:YES];
    }];
    UIButton *button3 = [[UIButton alloc]init];
    [self.view addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(15);
        make.width.mas_equalTo(button2.width);
        make.height.equalTo(button2.height);
        make.top.mas_equalTo(button2.mas_bottom).with.offset(30);
    }];
    
    [button3 setTitle:@"组合操作" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor redColor];
    [[button3 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
        @strongify(self);
        OBCombineViewController *signalVC = [[OBCombineViewController alloc]init];
        [self.navigationController pushViewController:signalVC animated:YES];
    }];
}
- (void)addView
{
     //代理
    NSMutableArray *array = [NSMutableArray array];
    array = self.A;
    
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:customView];
    @weakify(self);
   [[customView rac_signalForSelector:@selector(buttonAction1)]subscribeNext:^(id x) {
       //代理中要执行的方法
       NSLog(@"customView点击按钮代理中要执行的方法");
       [[NSNotificationCenter defaultCenter]postNotificationName:@"PostNotification" object:nil userInfo:@{@"test":@"notification"}];
       TwoViewController *tow = [[TwoViewController alloc]init];
       tow.delegateSignal = [RACSubject subject];
       [tow.delegateSignal subscribeNext:^(id x) {
           NSLog(@"-------点击了Two 控制器");
           customView.backgroundColor = [UIColor grayColor];
       }];
       @strongify(self);
       [self.navigationController pushViewController:tow animated:YES];
       
       
   }];
    [[customView rac_valuesAndChangesForKeyPath:@"index" options:NSKeyValueObservingOptionNew observer:nil]subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSInteger index,NSDictionary *dic) = x;
        NSLog(@"newIndex -------%ld\n ------%@",(long)index,dic);
    }];
    //多个请求
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       //发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1,request2]];
    

}

-(void)updateUIWithR1:(RACSignal *)r1 r2:(RACSignal *)r2
{

}
/**
 发送信号 执行createSignal这句话时 内部RACDynamicSignal 保存订阅者didSubscribe
 当执行subscribeNext时 首先将nextBlock 保存在了订阅者的next中 然后在内部的subscribe中回调didSubscribe 于是调用到了createSignal block中 当执行sendNext方法时回调订阅者的next 于是就到了subscribeNext block内部 输出x
 */
- (void)createSignal
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"haha"];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"输出=====%@",x);
    }];
    RACSignal *errorSignal = [RACSignal error:[NSError errorWithDomain:NSCocoaErrorDomain code:1 userInfo:@{@"error":@"out"}]];
    [errorSignal subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        NSLog(@"error =======%@",error);
    }];
}
- (NSInteger)sumWithCount:(NSInteger)n
{
    return n*(n+1)/2;
}
- (void)test4
{
    NSMutableArray *_arr = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i < 10; i ++) {
        [_arr addObject:[NSNumber numberWithInt:i]];
    }
    for (NSNumber *num in _arr) {
        [_arr removeObject:num];
    }
}
//链式编程与函数式编程
//- (void)test
//{
//    UIPageViewController
//    Caculator *c = [[Caculator alloc]init];
//    //链式编程
//    BOOL isequle = [[c caculator:^int(int result) {
//        result +=2;
//        result *= 5;;
//        return result;
//    }]equle:^BOOL(int result) {
//        return  result == 8;
//    }];
//    NSLog(@"%d",isequle);
//    int result0 = [c caculator:^int(int result) {
//        result +=2;
//        result *= 5;
//        result /= 2;
//        return result;
//    }].result;
//    NSLog(@"%d",result0);
//    //函数式编程
//    int result =  [Caculator makeCalculator:^(Caculator *make) {
//        make.add(3).muti(4).devide(2);
//    }];
//    NSLog(@"%d",result);
//
//}
//RAC
- (void)test2
{
    //1.观察值变化
    @weakify(self);
    [RACObserve(self, strValue) subscribeNext:^(NSString *x) {
        @strongify(self);
        NSLog(@"newStrValue ----%@",self.strValue);
    }];
    self.strValue = @"哈哈哈";
    //2.单边响应
    RACSignal *singleA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"唱歌"];
        [subscriber sendCompleted];
        return nil;
    }];
    RAC(self,strValue) = [singleA map:^id(NSString *value) {
        if ([value isEqualToString:@"唱歌"]) {
            return @"跳舞";
        }
        return @"";
    }];
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
   
    //4.广播
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PostNotification" object:nil]subscribeNext:^(NSNotification *x) {
        NSLog(@"%@ -----t通知",x.userInfo[@"test"]);
    }];
    //5.串联
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我结婚啦"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *singalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"我恋爱啦"];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *contactSingel = [singalA concat:signalB];
    [contactSingel subscribeNext:^(id x) {
        NSLog(@"串联--------%@",x);
    }];
    
    //7.组合
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    [[RACSubject combineLatest:@[letters,numbers] reduce:^(NSString *letter,NSString *number){
        return [letter stringByAppendingString:number];
    }]subscribeNext:^(id x) {
        NSLog(@"组合拼接后的值------%@",x);
    }];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"D"];
    [numbers sendNext:@"E"];
    [letters sendNext:@"F"];
    //8.合流压缩
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"绿"];
        [subscriber sendNext:@"白"];
        [subscriber sendNext:@"青"];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"红"];
//        [subscriber sendNext:@"白"];
//        [subscriber sendNext:@"蓝"];
        return nil;
    }];
    [[signal1 zipWith:signal2] subscribeNext:^(RACTuple *x) {
        //解压缩
        RACTupleUnpack(NSString *stringA,NSString *stringB) = x;
        NSLog(@"我们是%@%@的",stringA,stringB);
    }];
    //9.映射
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"石"];
        return nil;
    }];
    signal = [signal map:^id(NSString *value) {
        if ([value isEqualToString:@"石"]) {
            return @"金";
        }
        return value;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"映射-------%@",x);
    }];
    //11.秩序
    RACSignal *signalf0 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"打蛋液");
        [subscriber sendNext:@"蛋液"];
        return nil;
    }];
    signalf0 = [signalf0 flattenMap:^RACStream *(NSString *value) {
        NSLog(@"把%@倒进锅里面煎",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"煎蛋"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    signalf0 = [signalf0 flattenMap:^RACStream *(NSString *value) {
        NSLog(@"把%@装到盘子里",value);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"上菜"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [signalf0 subscribeNext:^(id x) {
        NSLog(@"秩序 ------%@",x);
    }];
    //12.命令
    RACCommand *acommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(NSString *input) {
        NSLog(@"%@我投降了",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [acommand execute:@"今天"];
    //13.延迟
    RACSignal *signalDe = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"等等我，我还有2秒钟就到了");
        [subscriber sendNext:@"篱笆房"];
        [subscriber sendCompleted];
        return nil;
    }];
    [[signalDe delay:5] subscribeNext:^(NSString *x) {
        NSLog(@"我到了%@",x);
    }];
    //14.重放
    RACSignal *signalRe = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"大导演拍了一部电影<我的女友是程序员>");
        [subscriber sendNext:@"<我的女友是程序员>"];
        return nil;
    }];
    RACSignal *signalReplay = [signalRe replay];
    [signalReplay subscribeNext:^(NSString *x) {
        NSLog(@"小红看了%@",x);
    }];
    [signalReplay subscribeNext:^(id x) {
        NSLog(@"小明看了%@",x);
    }];
    //15.定时
//    RACSignal *signalInterval = [RACSignal interval:5 onScheduler:[RACScheduler mainThreadScheduler]];
//    [signalInterval subscribeNext:^(id x) {
//        NSLog(@"吃药");
//    }];
    //16.超时
    RACSignal *singnalTimeOut = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"我快到了");
        RACSignal *sendSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> senSubscriber) {
            [senSubscriber sendNext:nil];
            [senSubscriber sendCompleted];
            return nil;
        }];
        [[sendSignal delay:10] subscribeNext:^(id x) {
            [subscriber sendNext:@"我到了"];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    [[singnalTimeOut timeout:12 onScheduler:[RACScheduler mainThreadScheduler]]subscribeError:^(NSError *error) {
        NSLog(@"等了12秒还没有到 我走了");
    }];
    //17.重试
    __block int failedCount = 0;
    RACSignal *signalRetry = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (failedCount < 10) {
            failedCount ++;
            NSLog(@"我失败了");
            [subscriber sendError:nil];
        } else {
            NSLog(@"经历了10次之后");
            [subscriber sendNext:@"我"];
        }
        return nil;
    }];
    RACSignal *signalRetry1 = [signalRetry retry];
    [signalRetry1 subscribeNext:^(NSString *x) {
        NSLog(@"%@终于成功了",x);
    }];
   
    //19.条件
    RACSignal *takeSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        RACSignal *signal = [RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]];
        [signal subscribeNext:^(id x) {
            [subscriber sendNext:@"直到世界的尽头才能把我们分开"];
        }];
        return nil;
    }];
    RACSignal *conditionSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"5秒，世界的尽头到了");
            [subscriber sendCompleted];
        });
        return nil;
    }];
    [[takeSignal takeUntil:conditionSignal]subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    //20.doNext
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@(1)];
        return nil;
    }]doNext:^(id x) {
        x = [NSString stringWithFormat:@"%@hahha",x];
        NSLog(@"---doNext=-----$%@",x);
    }]subscribeNext:^(id x) {
        NSLog(@"---doNext=-----$%@",x);
    }];
    //21.flatten 压平信号中的信号，信号中的信号成为子信号，，flatten可以拿到所有子信号发送的值。switchToLatest：与flatten相同，压平信号中的信号，不同的是，在存在多个子信号时候只会拿到最新的子信号，然后输出最新的子信号的值。
    RACSubject *subject = [RACSubject subject];
    RACSubject *subject1 = [RACSubject subject];
    RACSubject *subject2 = [RACSubject subject];
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
    [subject sendNext:subject1];
    [subject sendNext:subject2];
    [subject1 sendNext:@1];
    [subject2 sendNext:@22];
    //22.
    
}
- (void)test3
{
    //遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"------遍历数组-%@",x);
    }];
    //遍历字典
    NSDictionary *dic = @{@"name":@"xiaoming",@"age":@18};
    [dic.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"key = %@----value = %@",key,value);
    }];
    //字典转模型
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"flags.plist" ofType:nil];
    NSArray *dicArray = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *flags = [NSMutableArray array];
    [dicArray.rac_sequence.signal subscribeNext:^(id x) {
        //运用RAC遍历字典
        FlagItem *item = [FlagItem flagWithDict:x];
        [flags addObject:item];

    }];
    NSArray *newFlags = [[dicArray.rac_sequence map:^id(id value) {
        return [FlagItem flagWithDict:value];
    }] array];
    NSLog(@"------newFlags--%@",newFlags);
    
}
//RACReplaySubject
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
- (void)requestData
{
    //创建命令
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令 %@",input);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSLog(@"请求数据");
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    _command = command;
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"----subscribeNext----%@",x);
        }];
    }];
     // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"----switchToLatest最新信号----%@",x);
    }];
    
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号
    [[command.executing skip:1]subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            NSLog(@"正在执行");
        } else {
            NSLog(@"执行完成");
        }
    }];
//    [self.command execute:nil];
    //RACMulticastConnection
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送请求");
        [subscriber sendNext:nil];
        return nil;
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"接受数据");
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"接收数据2");
    }];
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"signal1发送请求");
        [subscriber sendNext:@1];
        return nil;
    }];
    RACMulticastConnection *connect = [signal1 publish];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者一信号");
    }];
    [connect.signal subscribeNext:^(id x) {
        NSLog(@"订阅者二信号");
    }];
    [connect connect];
    
}

/**
 绑定。使用思想跟hook(钩子)一样，都是拦截API从而可以对数据进行操作，而影响返回数据。
 bind方法使用步骤:
 1.传入一个返回值RACStreamBindBlock的block。
 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。
 3.描述一个返回结果的信号，作为bindBlock的返回值。
 注意：在bindBlock中做信号结果的处理。
 */
- (void)bind
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"first value"];
        [subscriber sendNext:@"second value"];
        [subscriber sendNext:@"third value"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *bindSignal = [signal bind:^RACStreamBindBlock{
        return  ^RACStream *(id value, BOOL *stop) {
            NSString *oValue = value;
            if ([oValue isEqualToString:@"first value"]) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:@"first value bind after"];
                    [subscriber sendCompleted];
                    return nil;
                }];
            }
            
            if ([oValue isEqualToString:@"second value"]) {
                *stop = YES;
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:@"second value bind after"];
                    [subscriber sendCompleted];
                    return nil;
                }];
            }
            
            if ([oValue isEqualToString:@"third value"]) {
                return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                    [subscriber sendNext:@"third value bind after"];
                    [subscriber sendCompleted];
                    return nil;
                }];
            }
            
            return nil;
        };
    }];
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"bind 输出 %@",x);
    }];
    
    [[self.textFiled.rac_textSignal bind:^RACStreamBindBlock{
        return ^RACStream *(id value, BOOL *stop){
            return [RACReturnSignal return:[NSString stringWithFormat:@"自己增加输出:%@",value]];
        };
    }]subscribeNext:^(id x) {
        NSLog(@"bind后的值：%@",x);
    }];
}
- (void)bind2
{
    RACSignal *signal = [RACSignal createSignal:
                         ^RACDisposable *(id<RACSubscriber> subscriber)
                         {
                             [subscriber sendNext:@1];
                             [subscriber sendNext:@2];
                             [subscriber sendNext:@3];
                             [subscriber sendCompleted];
                             return [RACDisposable disposableWithBlock:^{
                                 NSLog(@"signal dispose");
                             }];
                         }];
    
    RACSignal *bindSignal = [signal bind:^RACStreamBindBlock{
        return ^RACSignal *(NSNumber *value, BOOL *stop){
            value = @(value.integerValue * 2);
            return [RACSignal return:value];
        };
    }];
    
    [bindSignal subscribeNext:^(id x) {
        NSLog(@"subscribe value = %@", x);
    }];
    
}
- (void)ignore
{
    RACSubject *subject = [RACSubject subject];
    RACSignal *ignoreSignal = [subject ignore:@"HH"];
    [ignoreSignal subscribeNext:^(id x) {
        NSLog(@"忽略后的值%@",x);
    }];
    [subject sendNext:@"HHawo"];
    [subject sendNext:@"HH"];
}
- (void)reduceEach
{
    RACSignal *signalB = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:RACTuplePack(@2,@3)];
        return nil;
    }]reduceEach:^id(NSNumber *a,NSNumber *b){
        return @([a integerValue]+[b integerValue]);
    }];
    [signalB subscribeNext:^(id x) {
        NSLog(@"聚合之后的值%@",x);
    }];
}
- (void)groupBy
{
    RACSignal *signal = @[@1, @2, @3, @4,@2,@3,@3,@4,@4,@4].rac_sequence.signal;
    
    
    NSArray * array = [[[[signal groupBy:^NSString *(NSNumber *object) {
        return [NSString stringWithFormat:@"%@",object];
    }] map:^id(RACGroupedSignal *value) {
        return [value sequence];
    }] sequence] map:^id(RACSignalSequence *value) {
        return value.array;
    }].array;
    
    for (NSNumber * num in array) {
        NSLog(@"最后的数组%@",num);
    }
}
- (void)mapReplace
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"wo"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"mapReplace---disposable");
        }];
        
    }];
    RACSignal *signalB = [signalA mapReplace:@"liujiao"];
    [signalB subscribeNext:^(id x) {
        NSLog(@"mapReplace -----%@",x);
    }];
    
}
//- (void)reduceApply
//{
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        id block = ^id(NSNumber *first,NSNumber *second,NSNumber *third) {
//            return @(first.integerValue + second.integerValue + third.integerValue);
//        };
//        [subscriber sendNext:RACTuplePack(block,@2,@3,@4)];
//        [subscriber sendNext:RACTuplePack((id)(^id(NSNumber *x){return @(x.integerValue * 10);}),@9,@10,@30)];
//        [subscriber sendCompleted];
//        return [RACDisposable disposableWithBlock:^{
//            NSLog(@"signal disposed");
//        }];
//                                          
//    }];
////    RACSignal *signalB = [signal reduceApply];
//}
- (void)startWith
{
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"2"];
        return nil;
    }]startWith:@"3"]subscribeNext:^(id x) {
        NSLog(@"startwith:%@",x);
    }];
}
- (void)zip
{
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"2"];
        return nil;
    }];
    RACSignal *signalC = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"3"];
        return nil;
    }];
    RACSignal *signalD = (RACSignal *)[[RACStream zip:@[signalB,signalA,signalC]]reduceEach:^id(NSString *a,NSString *b,NSString *c){
        return [NSString stringWithFormat:@"%@,%@,%@",a,b,c];
    }];
    [signalD subscribeNext:^(id x) {
        NSLog(@"邮编:%@",x);
    }];
}
- (void)scanWithStart
{
    RACSequence *sequence = @[@1,@2,@3,@4].rac_sequence;
    RACSignal *signal0 = [sequence scanWithStart:@0 reduce:^id(NSNumber *previous, NSNumber *next) {
        return @(previous.integerValue + next.integerValue);
    }].signal;
    RACSignal *signal = [sequence combinePreviousWithStart:@0 reduce:^id(NSNumber *previous, NSNumber *next) {
        return @(previous.integerValue + next.integerValue);
    }].signal;
    [signal0 subscribeNext:^(id x) {
        NSLog(@"scanWithStart:%@",x);
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"combinePreviousWithStart:%@",x);
    }];
}
- (void)takeUntilBlock
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"4"];
        [subscriber sendCompleted];
        return nil;
    }]takeUntilBlock:^BOOL(NSString *x) {
        return [x isEqualToString:@"3"];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"takeUntilBlock:%@",x);
    }];
}
- (void)takeWhileBlock
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"4"];
        [subscriber sendCompleted];
        return nil;
    }]takeWhileBlock:^BOOL(NSString *x) {
        return [x isEqualToString:@"3"];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"takeWhileBlock:%@",x);
    }];
}
- (void)skipUntilBlock
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"1"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"4"];
        [subscriber sendCompleted];
        return nil;
    }]skipUntilBlock:^BOOL(NSString *x) {
        return [x isEqualToString:@"3"];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"skipUntilBlock:%@",x);
    }];
}
- (void)skipWhileBlock
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"2"];
        [subscriber sendNext:@"3"];
        [subscriber sendNext:@"4"];
        [subscriber sendCompleted];
        return nil;
    }]skipWhileBlock:^BOOL(NSString *x) {
        return [x isEqualToString:@"3"];
    }];
    [signal subscribeNext:^(id x) {
        NSLog(@"skipWhileBlock:%@",x);
    }];
}
- (void)collect
{
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"A"];
        [subscriber sendNext:@"B"];
        [subscriber sendNext:@"C"];
        [subscriber sendNext:@"D"];
        [subscriber sendCompleted];
        return nil;
    }]collect];
//    RACSignal *signalB = [signal collect];
//    NSLog(@"%@",signalB);
    [signal subscribeNext:^(id x) {
        NSLog(@"collect------%@",x);
    }];
}

/**
 dispatch_set_target_queue目的：一、设置dispatch_queue_create创建队列的优先级，二、建立队列的执行阶层
 */
- (void)GCD
{
    dispatch_queue_t targetQueue = dispatch_queue_create("targetQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(targetQueue,queue2);
    dispatch_set_target_queue(queue1, targetQueue);
    dispatch_async(targetQueue, ^{
        NSLog(@"target queue");
    });
    dispatch_async(queue2, ^{
        NSLog(@"queue2 1");
    });
    dispatch_async(queue2, ^{
        NSLog(@"queue2 2");
    });
    dispatch_async(queue1, ^{
        NSLog(@"queue1 1");
    });
    dispatch_async(queue1, ^{
        NSLog(@"queue1 2");
    });
   
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    OBLoginViewController *tableView = [[OBLoginViewController alloc]init];
    [self.navigationController pushViewController:tableView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
