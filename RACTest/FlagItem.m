//
//  FlagItem.m
//  RACTest
//
//  Created by obally on 2017/8/7.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "FlagItem.h"

@implementation FlagItem
+ (id)flagWithDict:(NSDictionary *)dic
{
    FlagItem *item = [[FlagItem alloc]init];
    item.name = dic[@"name"];
    item.age = dic[@"age"];
    return item;
}
@end
