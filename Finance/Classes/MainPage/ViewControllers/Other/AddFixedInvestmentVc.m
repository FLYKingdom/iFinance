//
//  AddFixedInvestmentVc.m
//  Finance
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "AddFixedInvestmentVc.h"

#import "InfoPropertyView.h"


@interface AddFixedInvestmentVc ()

@end

@implementation AddFixedInvestmentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the
    
    [self setupNavigationTitle:@"添加定投"];
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
    InfoPropertyView *baseInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@""];
    [container addSubview:baseInfoView];
    [baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(container.mas_top).offset(topSep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *holdInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@""];
    [container addSubview:holdInfoView];
    [holdInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(baseInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *saleInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@""];
    [container addSubview:saleInfoView];
    [saleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(holdInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];

    UIButton *finishBtn = [[UIButton alloc] init];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn.titleLabel setFont:[UIFont fontWithName:FontName size:16]];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn setBackgroundColor:DefaultMainColor];
    finishBtn.layer.masksToBounds = YES;
    finishBtn.layer.cornerRadius = 5;
    [container addSubview:finishBtn];
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(container);
        make.width.equalTo(@180);
        make.top.equalTo(saleInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(50);
    }];
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.width.mas_equalTo(kDeviceWidth);
        make.bottom.equalTo(finishBtn.mas_bottom).offset(topSep);
    }];
    
    [container layoutIfNeeded];
    baseInfoView.propertyInfos = @[@{@"tipStr":@"平台名称",@"placeholder":@"请输入基金名称"}
                                   ];
    holdInfoView.propertyInfos = @[@{@"tipStr":@"基金名称",@"placeholder":@"请输入基金名称"}
                                   ];
    saleInfoView.propertyInfos = @[@{@"tipStr":@"定投周期",@"placeholder":@"请输入周期"}
                                   ];

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
