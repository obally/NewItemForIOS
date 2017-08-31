//
//  LoginViewModel.h
//  RACTest
//
//  Created by obally on 2017/8/9.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *passWord;
@property(nonatomic,copy,readonly) NSString *access_token;
@property(nonatomic,strong,readonly) RACCommand *loginCommand; //登录事件响应
@property(nonatomic,strong) RACSignal *validLoginSignal;//登录验证  是否能登录
//处理错误
@property(nonatomic,strong)RACSubject *errorSubject;


@end
