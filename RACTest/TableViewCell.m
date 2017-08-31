//
//  TableViewCell.m
//  RACTest
//
//  Created by obally on 2017/8/2.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "TableViewCell.h"
#import "Model.h"

@interface TableViewCell ()

//@property(nonatomic,strong) UILabel *title;

@end
@implementation TableViewCell
+ (instancetype)cellWithTabelView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cellID";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addView];
    }
    return self;
}
- (void)addView
{
    
}
- (void)configureCellWithSignal:(RACSignal *)singal
{
    @weakify(self);
    [singal subscribeNext:^(Model *model) {
        @strongify(self);
        self.textLabel.text = model.title;
        self.detailTextLabel.text = model.subTitle;
        
    }];
}
@end
