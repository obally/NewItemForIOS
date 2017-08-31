//
//  Caculator.m
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator
- (Caculator *)caculator:(int (^)(int result))caculator
{
    self.result = caculator(self.result);
    return self;
}
- (BOOL)equle:(BOOL (^)(int result))operation
{
    return operation(self.result);
}
+ (int)makeCalculator:(void (^)(Caculator *make))caculator
{
    Caculator *cal = [[Caculator alloc]init];
    caculator(cal);
    return cal.result;
}
- (Caculator *(^)(int))add
{
    return ^(int num){
        self.result += num;
        return self;
    };
}
- (Caculator *(^)(int))sub
{
    return ^(int num){
        self.result -= num;
        return self;
    };
}
- (Caculator *(^)(int))muti
{
    return ^(int num){
        self.result *= num;
        return self;
    };
}
- (Caculator *(^)(int))devide
{
    return ^(int num){
        self.result /= num;
        return self;
    };
}
@end
