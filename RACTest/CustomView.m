//
//  CustomView.m
//  RACTest
//
//  Created by obally on 2017/8/2.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
//        self.delegate = self;
        [self addView];
    }
    return self;
}
- (void)addView
{
    UIButton *button = [[UIButton alloc]initWithFrame:self.bounds];
    [button addTarget:self action:@selector(buttonAction1) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)buttonAction1
{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonAction)]) {
//        [self.delegate respondsToSelector:@selector(buttonAction)];
//    }
    self.index = 100;
}
@end
