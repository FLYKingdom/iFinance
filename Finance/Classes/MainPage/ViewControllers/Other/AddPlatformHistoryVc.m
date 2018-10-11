//
//  AddPlatformHistoryVc.m
//  Finance
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "AddPlatformHistoryVc.h"

@interface AddPlatformHistoryVc ()

@end

@implementation AddPlatformHistoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:@"添加月度记录"];
    [self setupUI];
    
    [self getDataFromServer];
}

- (void)setupUI {
    //编辑 总资产total 当前收益earning 添加时间 created
    //注意 不满一月 不能新增 数据记录
}

- (void)getDataFromServer {
    //获取 数据
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
