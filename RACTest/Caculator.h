//
//  Caculator.h
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject
@property(nonatomic,assign) BOOL isEqule;
@property(nonatomic,assign) int result;
- (Caculator *)caculator:(int (^)(int result))caculator;
- (BOOL)equle:(BOOL (^)(int result))operation;
+ (int)makeCalculator:(void (^)(Caculator *make))caculator;
- (Caculator *(^)(int))add;
- (Caculator *(^)(int))sub;
- (Caculator *(^)(int))muti;
- (Caculator *(^)(int))devide;
@end
