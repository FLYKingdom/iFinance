//
//  FixedInvestmentVc.m
//  Finance
//
//  Created by mac on 2018/10/31.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "FixedInvestmentVc.h"
#import "AddFixedInvestmentVc.h"

#define Vc_title @"定投管理"

@interface FixedInvestmentVc ()

@end

@implementation FixedInvestmentVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:Vc_title];
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
    
}

- (void)addNewRecord {
    AddFixedInvestmentVc *vc = [[AddFixedInvestmentVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
