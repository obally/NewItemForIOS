//
//  OBTableViewController.m
//  RACTest
//
//  Created by obally on 2017/8/1.
//  Copyright © 2017年 obally. All rights reserved.
//

#import "OBTableViewController.h"
#import "TableViewModel.h"
#import "TableViewCell.h"
#import "Model.h"
typedef NSArray *(^blcok) (NSString *str ,NSString *str2);
@interface OBTableViewController ()

@property(nonatomic,strong) TableViewModel *viewModel;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,assign) blcok hahh;

@end

@implementation OBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRightItem];
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tableView.estimatedRowHeight = 60;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    [self.viewModel configCellBlock:^(id cell, RACSignal *signal) {
        [cell configureCellWithSignal:signal];
    }];
    Model *model = [[Model alloc]init];
    model.title = @"title";
    model.subTitle = @"subTitle";
    Model *model1 = [[Model alloc]init];
    model1.title = @"title1";
    model1.subTitle = @"subTitle1";
    Model *model2 = [[Model alloc]init];
    model2.title = @"title2";
    model2.subTitle = @"subTitle2";
    Model *model3 = [[Model alloc]init];
    model3.title = @"title3";
    model3.subTitle = @"subTitle3";
    Model *model4 = [[Model alloc]init];
    model4.title = @"title4";
    model4.subTitle = @"subTitle4";
    Model *model5 = [[Model alloc]init];
    model5.title = @"title5";
    model5.subTitle = @"subTitle5";
    Model *model6 = [[Model alloc]init];
    model6.title = @"title6";
    model6.subTitle = @"subTitle6";
    self.viewModel.dataSource = @[model,model1,model2,model3,model4,model5,model6];
    tableView.dataSource = self.viewModel;
    tableView.delegate = self.viewModel;
    // Do any additional setup after loading the view.
}
- (void)createRightItem
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"done" style:UIBarButtonItemStyleDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = item;
    
}
- (void)doneAction
{
    Model *model = [[Model alloc]init];
    model.title = @"title修改";
    model.subTitle = @"subTitle修改";
//    Model *model1 = [[Model alloc]init];
//    model1.title = @"title修改";
//    model1.subTitle = @"subTitle修改";
    self.viewModel.dataSource = @[model];
}
- (TableViewModel *)viewModel
{
    if (_viewModel == nil) {
        _viewModel = [[TableViewModel alloc]init];
    }
    return _viewModel;
}

@end
