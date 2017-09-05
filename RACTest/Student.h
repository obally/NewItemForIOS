//
//  Student.h
//  RACTest
//
//  Created by obally on 2017/8/15.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) CGFloat score;

+ (Student *)personWithName:(NSString *)name age:(NSInteger)age score:(CGFloat)score;

/*按名字比较大小*/
- (NSComparisonResult)compareWithName:(Student *)stu;
/*按年龄比较大小*/
- (NSComparisonResult)compareWithAge:(Student *)stu;
/*按分数比较大小*/
- (NSComparisonResult)compareWithScore:(Student *)stu;
+ (void)study;
- (void)run;
@end
