//
//  LoginViewModel.m
//  RACTest
//
//  Created by obally on 2017/8/9.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel ()
@property(nonatomic,strong) RACCommand *loginCommand;

@end
@implementation LoginViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        RAC(self,access_token) = [[[self.loginCommand executionSignals]switchToLatest]deliverOn:[RACScheduler mainThreadScheduler]];
        self.errorSubject = [RACSubject subject];
    }
    return self;
}
- (RACSignal *)validLoginSignal
{
    return [[RACSignal combineLatest:@[RACObserve(self, userName),RACObserve(self, passWord)] reduce:^(NSString *userName,NSString *passWord){
        if (![self isvalidUserName:userName]) {
            [self.errorSubject sendNext:@"电话格式不对"];
            return @0;
        } else if (![self isvalidPassWord:passWord]) {
            [self.errorSubject sendNext:@"请输入密码"];
            return @0;
        } else {
            [self.errorSubject sendNext:@""];
            return @([self isvalidUserName:userName] && [self isvalidPassWord:passWord]);
        }
        
    }]distinctUntilChanged];
}
- (BOOL)isvalidUserName:(NSString *)userName
{
    BOOL result = false;
    if (userName.length == 11) {
        result = true;
    }
    return result;
}
- (BOOL)isvalidPassWord:(NSString *)passWord
{
    BOOL result = false;
    if (passWord.length >0) {
        result = true;
    }
    return result;
}

- (RACCommand *)loginCommand
{
    if (_loginCommand == nil) {
        _loginCommand = [[RACCommand alloc]initWithEnabled:self.validLoginSignal signalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSDictionary *userDic = @{@"mobile":self.userName,
                                          @"loginPwd":self.passWord,
                                          @"tradeId":@"userLogin"};
               [OBDataRequest requestWithURL:@"https://bracelet.xzxpay.com:8887/user/userLogin" params:userDic httpMethod:@"POST" progressBlock:^(NSProgress * _Nonnull downloadProgress) {
                   
               } completionblock:^(id  _Nonnull result) {
                   if ([result[@"success"] boolValue]) {
                       [subscriber sendNext:result];
                       [self.errorSubject sendNext:@"登录成功"];
                   } else {
                       [self.errorSubject sendNext:result[@"resultMsg"]];
                   }
                    [subscriber sendCompleted];
               } failedBlock:^(id  _Nonnull error) {
                   [self.errorSubject sendNext:error];
                   [subscriber sendCompleted];
               }];
                return nil;
            }];
            
        }];
    }
    return _loginCommand;
}
@end
