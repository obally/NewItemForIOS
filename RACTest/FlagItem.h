//
//  FlagItem.h
//  RACTest
//
//  Created by obally on 2017/8/7.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlagItem : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSNumber *age;
+ (id)flagWithDict:(NSDictionary *)dic;
@end
