//
//  FoundDetailViewController.m
//  Finance
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "FoundDetailViewController.h"

#import "UILabel+Extension.h"
#import "BaseTableView.h"
#import "MainPageService.h"

#define Vc_Title @"基金详情页"

@interface FoundDetailViewController ()

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, assign) BOOL isFirst;

@end

@implementation FoundDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initConfig];
    
    [self setupNavigationTitle:Vc_Title];
    
    [self setupUI];
    
    self.isFirst = YES;
    [self getDataFromServer:ADD_RECORD_BY_INIT];
}

#pragma mark - initConfig

- (void)initConfig {
    
}

#pragma mark - setup ui

- (void)setupUI {
    //all goods list
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth-32, 100)];
    tipLabel.center = self.view.center;
    [tipLabel setText:@"公式:n1*(x1-x2)*(x2/(x2-x4) -1)"];
    [tipLabel setTextColor:[HexColor colorWithHexString:@"666666"]];
    [tipLabel setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:tipLabel];
    
    
}

#pragma mark - sub event method

- (void)enterGoodsDetailVc:(NSInteger) infoID {
    //TODO: detail vc
}

#pragma mark - get data

- (void)sendCollectShopReq:(BOOL) isCollected companyID:(NSInteger) companyID{
    //TODO: service
    
}


- (void)getDataFromServer:(AddRecordType) type {
    //: 发送请求
    
    [MainPageService getDetailInfoWithClass:@"FoundModel" key:@"" parameter:nil URL:nil success:^(BaseModel *detailInfo) {
        
        
    } fail:^(NSString *reason) {
       
    }];
}

#pragma mark - life method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.isFirst) {
        self.isFirst = NO;
        [self getDataFromServer:ADD_RECORD_BY_RELOAD];
    }
    
//    [MobClick beginEvent:Vc_Title];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.title = @"";
    
//    [MobClick endEvent:Vc_Title];
}

@end
