//
//  OBLoginViewController.m
//  RACTest
//
//  Created by obally on 2017/8/9.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBLoginViewController.h"
#import "LoginViewModel.h"
@interface OBLoginViewController ()
@property(nonatomic,strong) UITextField *userNameField,*pwdField;
@property(nonatomic,strong) UIButton *loginButton;
@property(nonatomic,strong) UILabel *myTokenLabel;
@property(nonatomic,strong) LoginViewModel *loginModel;

@end

@implementation OBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    if (!self.loginModel) {
        self.loginModel = [[LoginViewModel alloc]init];
    }
    RAC(self.loginModel,userName) = self.userNameField.rac_textSignal;
    RAC(self.loginModel,passWord) = self.pwdField.rac_textSignal;
    @weakify(self);
    self.loginButton.rac_command = self.loginModel.loginCommand;
    //处理响应事件 executing 当前时间是否在执行
    [[self.loginButton.rac_command executing]subscribeNext:^(id x) {
        NSLog(@"当前时间的执行状态是：%d",[x intValue]);
        if ([x boolValue]) {
            //正在请求中
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        } else {
            //请求完成
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
    
    [[self.loginButton.rac_command.executionSignals switchToLatest]subscribeNext:^(NSDictionary *dic) {
       //
        NSLog(@"成功登陆");
    }];
    //处理错误
    [[self.loginModel errorSubject] subscribeNext:^(id error) {
        @strongify(self)
        self.myTokenLabel.text=error;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    [[self.userNameField.rac_textSignal takeWhileBlock:^BOOL(NSString *value) {
        return YES;
    }] subscribeNext:^(NSString *value) {
        NSLog(@"current value is not `stop`: %@", value);
    }];
}

- (void)addView
{
    if (!self.userNameField) {
        self.userNameField = [[UITextField alloc]init];
        self.userNameField.backgroundColor = [UIColor whiteColor];
        self.userNameField.placeholder = @"输入用户名";
        [self.view addSubview:self.userNameField];
        [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(15);
            make.top.mas_equalTo(self.view.mas_top).with.offset(70);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
            make.height.mas_equalTo(@40);
        }];
    }
    if (!self.pwdField) {
        self.pwdField = [[UITextField alloc]init];
        self.pwdField.backgroundColor = [UIColor whiteColor];
        self.pwdField.placeholder = @"输入密码";
        [self.view addSubview:self.pwdField];
        [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(15);
            make.top.mas_equalTo(self.userNameField.mas_bottom).with.offset(10);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
            make.height.mas_equalTo(@40);
        }];
    }
    if (!self.loginButton) {
        self.loginButton = [[UIButton alloc]init];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.view addSubview:self.loginButton];
        self.loginButton.backgroundColor = [UIColor blueColor];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(15);
            make.top.mas_equalTo(self.pwdField.mas_bottom).with.offset(20);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
            make.height.mas_equalTo(@40);
        }];
    }
    if (!self.myTokenLabel) {
        self.myTokenLabel=[[UILabel alloc]init];
        self.myTokenLabel.text=@"当前还没有登录";
        [self.view addSubview:self.myTokenLabel];
        [self.myTokenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view.mas_left).with.offset(15);
            make.top.mas_equalTo(self.loginButton.mas_bottom).with.offset(20);
            make.right.mas_equalTo(self.view.mas_right).with.offset(-15);
            make.height.mas_equalTo(@40);
        }];
    }

}

@end
