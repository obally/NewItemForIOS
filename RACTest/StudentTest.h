//
//  StudentTest.h
//  RACTest
//
//  Created by obally on 2017/8/31.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^Study)();
@interface StudentTest : NSObject
@property(nonatomic,copy)Study study;
@property(nonatomic,copy) NSString *name;

@end
