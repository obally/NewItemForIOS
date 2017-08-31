//
//  TableViewModel.h
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell,RACSignal *signal);
@interface TableViewModel : NSObject<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *dataSource;
- (void)configCellBlock:(CellConfigureBlock)aConfigureCellBlock;
@end
