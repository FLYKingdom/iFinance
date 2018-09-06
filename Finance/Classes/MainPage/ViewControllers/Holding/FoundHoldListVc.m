//
//  FoundHoldListVc.m
//  Finance
//
//  Created by mac on 2018/6/24.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "FoundHoldListVc.h"

#define Vc_title @"持有基金列表"

#import "AddHoldingViewController.h"

@interface FoundHoldListVc ()

@end

@implementation FoundHoldListVc

- (void)viewDidLoad {
    [super viewDidLoad];
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
    AddHoldingViewController *vc = [[AddHoldingViewController alloc] init];
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
