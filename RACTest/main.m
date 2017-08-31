//
//  main.m
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//


#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        void (^block)() = ^{
            NSLog(@"block");
        };
        block();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

void test1() {
    int m = 10;
    void (^block)() = ^{
        NSLog(@"test1 = %d",m);
    };
    m = 20;
    block();
}
void test2() {
    __block int m = 10;
    void (^block)() = ^{
        NSLog(@"test1 = %d",m);
    };
    m = 20;
    block();
}
void test3() {
    static int m = 10;
    void (^block)() = ^{
        NSLog(@"test1 = %d",m);
    };
    m = 20;
    block();
}
