//
//  TableViewCell.h
//  RACTest
//
//  Created by obally on 2017/8/2.
//  Copyright © 2017年 obally. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
@interface TableViewCell : UITableViewCell
- (void)configureCellWithSignal:(RACSignal *)singal;
+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
