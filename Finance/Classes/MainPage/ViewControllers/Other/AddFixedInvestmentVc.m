//
//  AddFixedInvestmentVc.m
//  Finance
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "AddFixedInvestmentVc.h"

#import "InfoPropertyView.h"
#import "UILabel+Extension.h"
#import "GradientView.h"

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
    CGFloat height = 90;
    CGFloat sep = 5;
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
    
    CGFloat sepWidth = 50;
    UIView *cycleView = [self setupCycleView];
    [container addSubview:cycleView];
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(container.mas_right).offset(-sepWidth);
        make.left.equalTo(container.mas_left).offset(sepWidth);
        make.top.equalTo(holdInfoView.mas_bottom).offset(sep + 15);
        make.height.mas_equalTo(height - 30);
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
        make.width.equalTo(@200);
        make.top.equalTo(cycleView.mas_bottom).offset(80);
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
}

- (UIView *)setupCycleView {
    UIView *cycleView = [[UIView alloc] initWithFrame:CGRectZero];
    cycleView.layer.cornerRadius = 5;
    cycleView.layer.masksToBounds = YES;
    [cycleView setBackgroundColor:[UIColor whiteColor]];

    
    CGFloat labelW = (4 + 2) * DefaultMainFontSize;

    UILabel *tipLable = [UILabel labelWithName:@"定投周期" fontSize:DefaultMainFontSize fontColor:[UIColor lightGrayColor]];
    [tipLable setTextAlignment:NSTextAlignmentCenter];
    [cycleView addSubview:tipLable];
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cycleView.mas_left);
        make.bottom.top.equalTo(cycleView);
        make.width.mas_equalTo(labelW);
    }];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectZero];
    [sepView setBackgroundColor:rgba(51, 51, 51, 0.2)];
    [tipLable addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tipLable.mas_centerY);
        make.right.equalTo(tipLable.mas_right).offset(DefaultMainFontSize/2);
        make.width.mas_equalTo(0.5);
        make.height.equalTo(tipLable.mas_height).multipliedBy(1-0.618);
    }];
    
    UILabel *perTib = [UILabel labelWithName:@"每" fontSize:DefaultMainFontSize fontColor:[UIColor lightGrayColor]];
    [cycleView addSubview:perTib];
    [perTib mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tipLable);
        make.left.equalTo(tipLable.mas_right).offset(5);
        make.width.mas_equalTo(30);
    }];
    
    
    UILabel *perValueTip = [UILabel labelWithName:@"" fontSize:DefaultMainFontSize fontColor:DefaultFontColor];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped:)];
    [perValueTip addGestureRecognizer:gesture];
    perValueTip.userInteractionEnabled = YES;
    perValueTip.tag = 0;
    [perValueTip setTextAlignment:NSTextAlignmentCenter];
    perValueTip.layer.cornerRadius = 5;
    perValueTip.layer.masksToBounds = YES;
    perValueTip.layer.borderColor = rgba(51, 51, 51, 0.2).CGColor;
    perValueTip.layer.borderWidth = 0.5;
    [cycleView addSubview:perValueTip];
    [perValueTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cycleView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(30);
        make.left.equalTo(perTib.mas_right);
    }];
    
    
    UILabel *moneyTip = [UILabel labelWithName:@"定投" fontSize:DefaultMainFontSize fontColor:[UIColor lightGrayColor]];
    [moneyTip setTextAlignment:NSTextAlignmentCenter];
    [cycleView addSubview:moneyTip];
    [moneyTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(cycleView);
        make.width.mas_equalTo(60);
        make.left.equalTo(perValueTip.mas_right);
    }];
    
    UILabel *moneyValueTip = [UILabel labelWithName:@"" fontSize:DefaultMainFontSize fontColor:DefaultFontColor];
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewDidTapped:)];
    [moneyValueTip addGestureRecognizer:gesture1];
    moneyValueTip.userInteractionEnabled = YES;
    moneyValueTip.layer.cornerRadius = 5;
    moneyValueTip.layer.masksToBounds = YES;
    moneyValueTip.layer.borderColor = rgba(51, 51, 51, 0.2).CGColor;
    moneyValueTip.layer.borderWidth = 0.5;
    moneyValueTip.tag = 1;
    [cycleView addSubview:moneyValueTip];
    [moneyValueTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cycleView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(50);
        make.left.equalTo(moneyTip.mas_right);
    }];
    
    UILabel *moneyUnit = [UILabel labelWithName:@"元" fontSize:DefaultMainFontSize fontColor:[UIColor lightGrayColor]];
    [moneyUnit setTextAlignment:NSTextAlignmentCenter];
    [cycleView addSubview:moneyUnit];
    [moneyUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(cycleView);
        make.width.mas_equalTo(30);
        make.left.equalTo(moneyValueTip.mas_right);
    }];
    
    return cycleView;
}

- (void)viewDidTapped:(UITapGestureRecognizer *) gesture {
    NSInteger tag = gesture.view.tag;
    NSLog(@"tag = %d",tag);
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
