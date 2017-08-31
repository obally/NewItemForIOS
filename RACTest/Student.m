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

@end
