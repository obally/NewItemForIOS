//
//  TwoViewController.m
//  RACTest
//
//  Created by obally on 2017/8/7.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)buttonAction
{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
