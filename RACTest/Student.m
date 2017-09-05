//
//  Student.m
//  RACTest
//
//  Created by obally on 2017/8/15.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "Student.h"

@implementation Student
- (Student *)initWithName:(NSString *)name age:(NSInteger)age score:(CGFloat)score{
    //No.1
    //开始写代码，完成Student类的初始化函数
    if(self = [super init]) {
        
        _name = name;
        
        _score = score;
        
        _age = age;
        
    }
    
    return self;
    
}

+ (Student *)personWithName:(NSString *)name age:(NSInteger)age score:(CGFloat)score {
    return [[Student alloc] initWithName:name age:age score:score];
}

//No.2
//开始写代码，完成头文件中的三个实例函数
- (NSComparisonResult)compareWithName:(Student *)stu
{
    return [self.name caseInsensitiveCompare:stu.name];
}

/*按年龄比较大小*/
- (NSComparisonResult)compareWithAge:(Student *)stu
{
    if (self.age == stu.age) {
        //年纪相等
        return NSOrderedSame;
    }else if (self.age > stu.age) {
        //年纪比他大
        return NSOrderedDescending;
    }else
        return NSOrderedAscending;
}
/*按分数比较大小*/
- (NSComparisonResult)compareWithScore:(Student *)stu
{
    if (self.score == stu.score) {
        //年纪相等
        return NSOrderedSame;
    }else if (self.score > stu.score) {
        //年纪比他大
        return NSOrderedDescending;
    }else
        return NSOrderedAscending;
}
+ (void)study
{
    NSLog(@"student -------study");
    [self instanceVariables];
    [self ClassMethodNames];
}
- (void)run
{
    NSLog(@"student-------run");
}
+(NSArray *)instanceVariables
{
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList(self, &outCount);
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i < outCount; i++) {
        NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *name =  [NSString stringWithCString:ivar_getName(ivars[i]) encoding:NSUTF8StringEncoding];
        NSString *ivarDec = [NSString stringWithFormat:@"%@--%@",type,name];
        [result addObject:ivarDec];
    }
    free(ivars);
    NSLog(@"instanceVariables-----%@",result);
    return result.count ? [result copy] : nil;
}
+ (NSArray *)ClassMethodNames
{
    NSMutableArray * array = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method * methodList = class_copyMethodList([self class], &methodCount);
    unsigned int i;
    for(i = 0; i < methodCount; i++) {
        [array addObject: NSStringFromSelector(method_getName(methodList[i]))];
    }
    NSLog(@"ClassMethodNames-----%@",array);
    free(methodList);
    return array;
}

@end
