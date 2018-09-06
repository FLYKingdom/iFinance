

//
//  AddNewAssetsVc.m
//  Finance
//
//  Created by mac on 2017/9/17.
//  Copyright © 2017年 FlyYardAppStore. All rights reserved.
//

#import "AddNewAssetsVc.h"
#import "UILabel+Extension.h"
#import "PlatformListVc.h"
#import "HexColor.h"

typedef enum : NSUInteger {
    KeyTypeDisplay,
    KeyTypeNewPage,
    KeyTypeFiled,
} KeyType;

@interface AddNewAssetsVc ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableDictionary *finalRecord;

@property (nonatomic, strong) NSArray *tipArr;

@end

@implementation AddNewAssetsVc

-(NSMutableDictionary *)finalRecord{
    if (!_finalRecord) {
        _finalRecord = [NSMutableDictionary dictionaryWithCapacity:self.tipArr.count];
    }
    return _finalRecord;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationTitle:@"添加理财记录"];
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:DefaultBGColor];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:self.view.bounds];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    self.pickerView = pickerView;
    
    self.tipArr = @[@"plantform",@"duration",@"eranRatio",@"amount",@"endEraning",@"dayEraning",@"startTime",@"dealline"];
    
    CGFloat btnW = 100;
    CGFloat btnH = 35;
    UIButton *newPage = [[UIButton alloc] initWithFrame:CGRectMake((kDeviceWidth - btnW)/2, (KDeviceHeight - btnH)/2 + 200, btnW, btnH)];
    [newPage setTitle:@"选择平台" forState:UIControlStateNormal];
    [newPage setTitleColor:[HexColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [newPage.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.view addSubview:newPage];
    [newPage addTarget:self action:@selector(enterNewPage) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Event

- (void)enterNewPage {
    PlatformListVc *vc = [[PlatformListVc alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - delegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tipArr.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *key = [self.tipArr objectAtIndex:row];
    if (component == 0) {
        return key;
    }
    
    return [self.finalRecord objectForKey:key];
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
