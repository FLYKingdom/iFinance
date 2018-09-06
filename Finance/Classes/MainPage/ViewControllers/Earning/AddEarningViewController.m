//
//  AddEarningViewController.m
//  Finance
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "AddEarningViewController.h"

#define Vc_Title @"添加收益"

#import "InfoPropertyView.h"
#import "InfoDisplayView.h"
#import "PGDatePickManager.h"

@interface AddEarningViewController ()<PGDatePickerDelegate>

@end

@implementation AddEarningViewController

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
    __weak typeof(self) weakSelf = self;
    void (^eventBack)(NSString *key,NSInteger event) = ^(NSString *key,NSInteger event){
        if (event == 1) {
            [weakSelf wakeupPicker];
        }
    };
    
    InfoPropertyView *baseInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"1.基金信息"];
    [container addSubview:baseInfoView];
    [baseInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(container.mas_top).offset(topSep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *platformInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"2.平台信息"];
    [container addSubview:platformInfoView];
    [platformInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(baseInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *holdInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"3.买入信息"];
    [container addSubview:holdInfoView];
    [holdInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(platformInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoPropertyView *saleInfoView = [[InfoPropertyView alloc] initWithFrame:CGRectZero tip:@"4.卖出信息"];
    [container addSubview:saleInfoView];
    [saleInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(holdInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(height);
    }];
    
    InfoDisplayView *computeInfoView = [[InfoDisplayView alloc] initWithFrame:CGRectZero tip:@"5.计算信息"];
    [container addSubview:computeInfoView];
    [computeInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(container);
        make.top.equalTo(saleInfoView.mas_bottom).offset(sep);
        make.height.mas_equalTo(155);
    }];
    
    CGFloat btnH = 44;
    UIButton *sureBtn = [[UIButton alloc] init];
    sureBtn.layer.cornerRadius = btnH/2;
    sureBtn.layer.masksToBounds = YES;
    [sureBtn setBackgroundColor:[UIColor blueColor]];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(btnH);
        make.width.mas_equalTo(kDeviceWidth - 80*2);
        make.centerX.equalTo(container.mas_centerX);
        make.top.equalTo(computeInfoView.mas_bottom).offset(45);
    }];
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sureBtn.mas_bottom).offset(topSep);
    }];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    [container layoutIfNeeded];
    baseInfoView.propertyInfos = @[@{@"key":@"foundName",@"tipStr":@"基金名称",@"placeholder":@"请输入基金名称"},
                                   @{@"key":@"foundNum",@"tipStr":@"基金代码",@"placeholder":@"请输入基金代码"},
                                   ];
    baseInfoView.callback = eventBack;
    platformInfoView.propertyInfos = @[@{@"key":@"platform",@"tipStr":@"平台名称",@"placeholder":@"请输入基平台名称"}
                                   ];
    platformInfoView.callback = eventBack;
    holdInfoView.propertyInfos = @[@{@"key":@"money",@"tipStr":@"买入金额",@"placeholder":@"请输入买入金额"},
                                   @{@"key":@"created",@"type":@(InfoInputTypeButton),@"tipStr":@"买入时间",@"placeholder":@"请输入买入时间"},
                                   ];
    holdInfoView.callback = eventBack;
    saleInfoView.propertyInfos = @[@{@"key":@"earnmMoney",@"tipStr":@"赎回收益",@"placeholder":@"请输入赎回收益"},
                                   @{@"key":@"outTime",@"type":@(InfoInputTypeButton),@"tipStr":@"赎回时间",@"placeholder":@"请输入赎回时间"},
                                   ];
    saleInfoView.callback = eventBack;
    computeInfoView.propertyInfos =  @[@{@"tipStr":@"持有时长",@"placeholder":@""},
                                       @{@"tipStr":@"年化收益",@"placeholder":@""},
                                       ];
    saleInfoView.callback = eventBack;
}


#pragma mark - event

- (void)sureBtnClicked {
    NSLog(@"123 = %@",@"456 hhe");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wakeupPicker {
    PGDatePickManager *datePickManager = [[PGDatePickManager alloc]init];
    datePickManager.isShadeBackgroud = true;
    PGDatePicker *datePicker = datePickManager.datePicker;
    datePicker.delegate = self;
    datePicker.datePickerType = PGPickerViewType1;
    datePicker.isHiddenMiddleText = false;
    datePicker.isHiddenWheels = false;
    datePicker.datePickerMode = PGDatePickerModeDate;
    
    [self presentViewController:datePickManager animated:false completion:nil];
}

#pragma PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSLog(@"dateComponents = %@", dateComponents);
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
