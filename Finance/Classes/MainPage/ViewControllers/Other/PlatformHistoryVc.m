//
//  PlatformHistoryVc.m
//  Finance
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

//平台持有历史记录

#import "PlatformHistoryVc.h"

@interface PlatformHistoryVc ()

@end

@implementation PlatformHistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:@"持有记录"];
    [self setupUI];
    [self getDataFromServer];
}

- (void)setupUI {
    //编辑/添加 功能
    //列表展示 和 折线展示
}

- (void)getDataFromServer {
    // 获取 数据
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
