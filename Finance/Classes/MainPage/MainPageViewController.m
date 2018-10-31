//
//  MainPageViewController.m
//  MyAppFactory
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 FlyYardAppStore. All rights reserved.
//

#import "MainPageViewController.h"

#import "UIColor+Chameleon.h"

#import "FoundDetailViewController.h"
#import "EarningListViewController.h"
#import "FoundHoldListVc.h"
#import "PlatformHoldListVc.h"
#import "AddEarningViewController.h"

#import "HomeBoardView.h"

#import "ComputerViewController.h"

@interface MainPageViewController ()<UIScrollViewDelegate>

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:@"iFinace"];
    
    [self setupNavigationBar];
    
    [self setupUI];
    
//    [self showPasscodeView];
}

#pragma mark - setupUI

- (void)setupNavigationBar {
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    UIImage *itemImg = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60a", 25, LightFontColor)];
    [addBtn setImage:itemImg forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addInfoClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [editBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [editBtn setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e642", 25, LightFontColor)] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(computeClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithCustomView:editBtn];
    self.navigationItem.rightBarButtonItems = @[addItem,editItem];
}

- (void)setupUI {
    NSArray *infos = @[@{@"title":@"平台",@"vcClass":@"PlatformHoldListVc",@"subTitle":@"说明: 现有支付宝、微信、天天基金、理财魔方、京东等平台"},@{@"title":@"基金",@"vcClass":@"FoundHoldListVc",@"subTitle":@"说明: 用于更好的管理基金组合"},@{@"title":@"股票",@"vcClass":@"StockHoldListVc",@"subTitle":@"说明: 现持有通威股份股票"},@{@"title":@"定投",@"vcClass":@"FixedInvestmentVc",@"subTitle":@"说明: 现有定投方案，计算每月投资支出"},@{@"title":@"收藏",@"vcClass":@"CollectFoundListVc",@"subTitle":@"说明: 收藏牛熊以及振荡期表现不错的基金"},@{@"title":@"收益",@"vcClass":@"EarningListViewController",@"subTitle":@"说明: 落袋为安，才是真的受益，否则你看到的只是个数字而已"}];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.scrollEnabled = YES;
    self.view = scrollView;
    
    [self.view setBackgroundColor:DefaultBGColor];
    int index = 0;
    
    UIView *container = [[UIView alloc] init];
    [self.view addSubview:container];
    
    CGFloat horSep = 50;
    CGFloat verSep = 50;
    CGFloat leftSep = 30;
    CGFloat startX = leftSep;
    CGFloat startY = horSep;
    CGFloat width = (kDeviceWidth - 2*leftSep - 60)/2;
    UIView *bottomView = nil;
    __weak typeof(self) weakSelf = self;
    for (NSDictionary *infoDict  in infos) {
        HomeBoardView *boardView = [[HomeBoardView alloc] init];
        boardView.callBack = ^(NSString *vcClass) {
            [weakSelf gotoVcWithName:vcClass];
        };
        [container addSubview:boardView];
        
        UIScrollView *scrollView = boardView.scrollView;
        [boardView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(scrollView.mas_bottom);
            make.width.mas_equalTo(width);
            make.top.mas_equalTo(startY);
            make.left.mas_equalTo(startX);
        }];
        
        [container layoutIfNeeded];
        boardView.infoDict = infoDict;
        
        index ++;
        if (index % 2 ) {
            startX += horSep + width;
        }else{
            startY += verSep + CGRectGetHeight(boardView.frame);
            startX = leftSep;
        }
        
        bottomView = boardView;
    }
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_bottom).offset(horSep);
    }];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
}

#pragma mark - Event

- (void)computeClicked {
    ComputerViewController *vc = [[ComputerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoVcWithName:(NSString *) vcName{
    Class myClass = NSClassFromString(vcName);
    BaseViewController *vc = [[myClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addInfoClicked {
    AddEarningViewController *vc = [[AddEarningViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - life method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - other life method

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
