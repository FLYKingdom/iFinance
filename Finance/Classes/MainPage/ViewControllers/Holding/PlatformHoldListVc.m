//
//  PlatformHoldListVc.m
//  Finance
//
//  Created by mac on 2018/6/24.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "PlatformHoldListVc.h"

#import "BaseTableView.h"
#import "AssetsCell.h"
#import "AddNewAssetsVc.h"
#import "UIColor+Chameleon.h"

#import "FoundDetailViewController.h"
#import "EarningListViewController.h"

#import "TOPasscodeViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface PlatformHoldListVc ()<UIScrollViewDelegate,TOPasscodeViewControllerDelegate>

@property (nonatomic, strong) BaseTableView *tableView;

@property (nonatomic, strong) LAContext *authContext;

@end

@implementation PlatformHoldListVc


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationBar];
    
    [self setupUI];
    
    [self getDataFromServer];
    
    [self showPasscodeView];
}

#pragma mark - setupUI

- (void)setupNavigationBar {
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [addBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    
    
    UIImage *itemImg = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60a", 25, LightFontColor)];
    [addBtn setImage:itemImg forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addNewRecord) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
    
}

- (void)setupUI {
    //    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg"]];
    //    bgView.contentMode = UIViewContentModeScaleAspectFill;
    //    [self.view addSubview:bgView];
    //    bgView.frame = self.view.bounds;
    
    self.authContext = [[LAContext alloc] init];
    
    BaseTableView *tableView = [[BaseTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped cellClass:@"AssetsCell"];
    self.tableView = tableView;
    [tableView setBackgroundColor:DefaultBGColor];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 64)];
    
    if (IOS11_OR_LATER) {
        [tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    __weak typeof(self) weakSelf = self;
    tableView.tableViewDidClicked = ^(NSInteger infoID, BaseModel *model) {
        //        FoundDetailViewController *vc = [[FoundDetailViewController alloc] init];
        //        vc.foundID = infoID;
        EarningListViewController *vc = [[EarningListViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    [self.view addSubview:tableView];
    
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - Event

- (void)showPasscodeView {
    TOPasscodeViewController *passcodeViewController = [[TOPasscodeViewController alloc] initWithStyle:TOPasscodeViewStyleTranslucentDark passcodeType:TOPasscodeTypeSixDigits];
    passcodeViewController.delegate = self;
    passcodeViewController.rightAccessoryButton = [UIButton new];
    BOOL biometricsAvailable = [self.authContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil];
    passcodeViewController.allowBiometricValidation = biometricsAvailable;
    
    BOOL faceIDAvailable = NO;
    if (@available(iOS 11.0, *)) {
        faceIDAvailable = NO;//(self.authContext.biometryType == LABiometryTypeFaceID);
    }
    
    [self presentViewController:passcodeViewController animated:YES completion:nil];
}

- (void)addNewRecord {
    AddNewAssetsVc *vc = [[AddNewAssetsVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - passcode delegate

- (void)didTapCancelInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)passcodeViewController:(TOPasscodeViewController *)passcodeViewController isCorrectCode:(NSString *)code
{
    return [code isEqualToString:@"111111"];
}

- (void)didPerformBiometricValidationRequestInPasscodeViewController:(TOPasscodeViewController *)passcodeViewController
{
    __weak typeof(self) weakSelf = self;
    NSString *reason = @"使用TouchID，解锁Finance";
    id reply = ^(BOOL success, NSError *error) {
        
        // Touch ID validation was successful
        // (Use this to dismiss the passcode controller and display the protected content)
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // Create a new Touch ID context for next time
                [weakSelf.authContext invalidate];
                weakSelf.authContext = [[LAContext alloc] init];
                
                // Dismiss the passcode controller
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            });
            return;
        }
        
        // Actual UI changes need to be made on the main queue
        dispatch_async(dispatch_get_main_queue(), ^{
            [passcodeViewController setContentHidden:NO animated:YES];
        });
        
        // The user hit 'Enter Password'. This should probably do nothing
        // but make sure the passcode controller is visible.
        if (error.code == kLAErrorUserFallback) {
            NSLog(@"User tapped 'Enter Password'");
            return;
        }
        
        // The user hit the 'Cancel' button in the Touch ID dialog.
        // At this point, you could either simply return the user to the passcode controller,
        // or dismiss the protected content and go back to a safer point in your app (Like the login page).
        if (error.code == LAErrorUserCancel) {
            NSLog(@"User tapped cancel.");
            return;
        }
        
        // There shouldn't be any other potential errors, but just in case
        NSLog(@"%@", error.localizedDescription);
    };
    
    [passcodeViewController setContentHidden:YES animated:YES];
    
    [self.authContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:reply];
}

#pragma mark - Net

- (void)getDataFromServer {
    //    @property (nonatomic, copy) NSString *platform;//平台
    //
    //    @property (nonatomic, assign) NSTimeInterval startTime;
    //
    //    @property (nonatomic, assign) NSTimeInterval endTime;
    //
    //    @property (nonatomic, assign) double amount;
    //
    //
    //    @property (nonatomic, assign) double endEraning;
    //
    //    @property (nonatomic, assign) double dayEraning;
    //
    //    @property (nonatomic, copy) NSString *eraningRatio;
    
    NSArray *assetList = @[@{@"platform":@"拍拍贷",@"startTime":@"7月21日",@"endTime":@"9月21日",@"amount":@(3000),@"dayEraning":@(0),@"endEraning":@(36),@"eraningRatio":@"7.2%"},@{@"platform":@"拍拍贷",@"startTime":@"7月21日",@"endTime":@"10月21日",@"amount":@(10000),@"dayEraning":@(0),@"endEraning":@(185),@"eraningRatio":@"7.4%"},@{@"platform":@"人人贷",@"startTime":@"7月19日",@"endTime":@"9月19日",@"amount":@(8000),@"dayEraning":@(0),@"endEraning":@(73.67),@"eraningRatio":@"10%"},@{@"platform":@"人人贷",@"startTime":@"9月3日",@"endTime":@"12月5日",@"amount":@(5000),@"dayEraning":@(0),@"endEraning":@(82.58),@"eraningRatio":@"6.6%"},@{@"platform":@"爱钱进",@"startTime":@"7月10日",@"endTime":@"10月10日",@"amount":@(35888),@"dayEraning":@(8.28),@"endEraning":@(160),@"eraningRatio":@"7%"},@{@"platform":@"玖富",@"startTime":@"8月11日",@"endTime":@"11月11日",@"amount":@(10000),@"dayEraning":@(2.4),@"endEraning":@(196),@"eraningRatio":@"8%"},@{@"platform":@"51人品",@"startTime":@"8月30日",@"endTime":@"11月30日",@"amount":@(10022.54),@"dayEraning":@(0),@"endEraning":@(100),@"eraningRatio":@"7%"},@{@"platform":@"口袋理财",@"startTime":@"9月13日",@"endTime":@"9月28日",@"amount":@(8000),@"dayEraning":@(0),@"endEraning":@(32.88),@"eraningRatio":@"10%"},@{@"platform":@"口袋记账",@"startTime":@"9月1日",@"endTime":@"10月1日",@"amount":@(5000),@"dayEraning":@(0),@"endEraning":@(30),@"eraningRatio":@"6%"},@{@"platform":@"理财魔方",@"startTime":@"9月1日",@"endTime":@"9月1日",@"amount":@(5000),@"dayEraning":@(0),@"endEraning":@(100),@"eraningRatio":@"10%"},@{@"platform":@"京东金融",@"startTime":@"now",@"endTime":@"next year",@"amount":@(28000),@"dayEraning":@(0),@"endEraning":@(0),@"eraningRatio":@"4%"},@{@"platform":@"支付宝",@"startTime":@"now",@"endTime":@"next year",@"amount":@(10000),@"dayEraning":@(0),@"endEraning":@(100),@"eraningRatio":@"4%"},@{@"platform":@"腾讯理财通",@"startTime":@"now",@"endTime":@"next year",@"amount":@(10000),@"dayEraning":@(0),@"endEraning":@(100),@"eraningRatio":@"4%"}];
    
    NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:assetList.count];
    
    for (NSDictionary *dict in assetList) {
        AssetsModel *model = [[AssetsModel alloc] initWithDictionary:dict];
        [tmpArr addObject:model];
    }
    
    self.tableView.dataArray = [BaseTableView getDateMatrixWithArr: tmpArr];
    
    double totalValue = 0;
    for (NSDictionary *record in assetList) {
        NSString *amount = [record objectForKey:@"amount"];
        totalValue += [amount doubleValue];
    }
    
    [self setupNavigationTitle:[NSString stringWithFormat:@"总计:%.02lf",totalValue]];
}

#pragma mark - life method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - other life method

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
