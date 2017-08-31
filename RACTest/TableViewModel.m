//
//  TableViewModel.m
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "TableViewModel.h"
#import "TableViewCell.h"
@interface TableViewModel()
@property(nonatomic,strong) RACSignal *signal;
@property(nonatomic,copy) CellConfigureBlock configureBlock;

@end
@implementation TableViewModel
- (void)configCellBlock:(CellConfigureBlock)aConfigureCellBlock
{
    _configureBlock = [aConfigureCellBlock copy];
    _signal = RACObserve(self, dataSource);
}
- (id)itemAtIndexPath:(NSIndexPath *)indexpath
{
    if (self.dataSource.count > indexpath.row) {
         return self.dataSource[(NSUInteger)indexpath.row];
    } else
        return nil;
   
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    if (self.configureBlock) {
        @weakify(self);
        self.configureBlock(cell, [self.signal map:^id(NSArray *array) {
            @strongify(self);
            return [self itemAtIndexPath:indexPath];
        }]);
    }

    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}
@end
