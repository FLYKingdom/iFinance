//
//  CollectFoundListVc.m
//  Finance
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "CollectFoundListVc.h"

#define Vc_title @"收藏的基金"

@interface CollectFoundListVc ()

@end

@implementation CollectFoundListVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationTitle:Vc_title];
    // Do any additional setup after loading the view.
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
