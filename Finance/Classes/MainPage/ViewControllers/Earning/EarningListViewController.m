//
//  EarningListViewController.m
//  Finance
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "EarningListViewController.h"

#define Vc_Title @"收益列表"

#import "BaseTableView.h"
#import "EarningListCell.h"

#import "AddEarningViewController.h"

@interface EarningListViewController ()

@property (nonatomic, strong) BaseTableView *tableView;

@end

@implementation EarningListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationTitle:Vc_Title];
    
    [self setupNavigationBar];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationBar {
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [addBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    
    UIImage *itemImg = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60a", 25, LightFontColor)];
    [addBtn setImage:itemImg forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewRecord) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
}

- (void)setupUI {
    BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped cellClass:@"EarningListCell"];
    [self.view addSubview:tableView];
    [tableView setBackgroundColor:DefaultBGColor];
    
    EarningModel *model1 = [[EarningModel alloc] init];
    model1.foundName = @"国泰国证食品";
    model1.foundNum = 1;
    
    model1.money = 8000;
    model1.earnmMoney = 965.80;
    model1.yearEarnRatio = 15.0;
    model1.earningRatio = 13.2;
    model1.remark = @"不错的定投策略，目标盈体验";
    model1.created = 1517414400;
    model1.outTime = 1529769936;
    
    EarningModel *model2 = [[EarningModel alloc] init];
    model2.foundName = @"国泰国证有色金属";
    model2.foundNum = 1;
    
    model2.money = 13000;
    model2.earnmMoney = -1400;
    model2.yearEarnRatio = -15.0;
    model2.earningRatio = -13.2;
    model2.remark = @"现在看来亏大了，看下行曲线，上涨多少时 再投";
    model2.created = 1525104000;
    model2.outTime = 1529769936;
    NSArray *earnList = @[model1,model2];
    tableView.dataArray = [BaseTableView getDateMatrixWithArr:earnList];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)addNewRecord {
    AddEarningViewController *vc = [[AddEarningViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
