//
//  AddHoldingViewController.m
//  Finance
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "AddHoldingViewController.h"
#import "InfoPropertyView.h"

#define Vc_Title @"添加持有"

@interface AddHoldingViewController ()

@end

@implementation AddHoldingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:Vc_Title];
    
    [self setupUI];
}

- (void)setupUI {
    //all list
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.view = scrollView;
    [scrollView setBackgroundColor:DefaultBGColor];
    
    UIView *container = [[UIView alloc] init];
    [container setBackgroundColor:DefaultBGColor];
    [scrollView addSubview:container];
    
    CGFloat topSep = 30;
    CGFloat height = 100;
    CGFloat sep = 20;
    InfoPropertyView *baseInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"1.基金信息"];
    [container addSubview:baseInfoView];
    [baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(container.mas_top).offset(topSep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *holdInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"2.买入信息"];
    [container addSubview:holdInfoView];
    [holdInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(baseInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *saleInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"3.卖出信息"];
    [container addSubview:saleInfoView];
    [saleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(holdInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *computeInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"4.计算信息"];
    [container addSubview:computeInfoView];
    [computeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(saleInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.width.mas_equalTo(kDeviceWidth);
        make.bottom.equalTo(computeInfoView.mas_bottom).offset(topSep);
    }];
    
    [container layoutIfNeeded];
    baseInfoView.propertyInfos = @[@{@"tipStr":@"基金名称",@"placeholder":@"请输入基金名称"},
                                   @{@"tipStr":@"基金代码",@"placeholder":@"请输入基金代码"},
                                   ];
    holdInfoView.propertyInfos = @[@{@"tipStr":@"买入金额",@"placeholder":@"请输入买入金额"},
                                   @{@"tipStr":@"买入时间",@"placeholder":@"请输入买入时间"},
                                   ];
    saleInfoView.propertyInfos = @[@{@"tipStr":@"赎回收益",@"placeholder":@"请输入赎回收益"},
                                   @{@"tipStr":@"赎回时间",@"placeholder":@"请输入赎回时间"},
                                   ];
    computeInfoView.propertyInfos =  @[@{@"tipStr":@"持有时长",@"placeholder":@""},
                                       @{@"tipStr":@"年化收益",@"placeholder":@""},
                                       ];
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

