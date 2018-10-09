//
//  ComputerViewController.m
//  Finance
//
//  Created by mac on 2018/10/7.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "ComputerViewController.h"

#import "UIButton+Extension.h"
#import "MyUtility.h"
#import "Masonry.h"

@interface ResultCollectionCell : UICollectionViewCell

@property(nonatomic, strong) UILabel *tipLabel;

@end

@implementation ResultCollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    //显示 i计算结果
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [HexColor colorWithHexString:@"666666"].CGColor;
    self.layer.borderWidth = 0.5;
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    self.tipLabel = tipLabel;
    [tipLabel setTextColor:RGBA(51, 51, 51, 1)];
    [tipLabel setFont:[UIFont systemFontOfSize:15]];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end

@interface ComputerViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

//views

//collection
@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) UIScrollView *computeView;

//data
@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation ComputerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavigationTitle:@"复利计算器"];
    
    [self setupUI];
}

- (void)setupUI {
    // result collection list
    [self.view setBackgroundColor:DefaultBGColor];
    
    UICollectionViewFlowLayout  *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 120);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(20, 16, 20, 16);
    
    CGFloat collectionH = 160;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 15, kDeviceWidth, collectionH) collectionViewLayout:layout];
    self.collectionView = collectionView;
    [collectionView setBackgroundColor:DefaultBGColor];
    [collectionView registerClass:[ResultCollectionCell class] forCellWithReuseIdentifier:@"collectionCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    //2. compute view
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.layer.borderColor = [HexColor colorWithHexString:@"666666"].CGColor;
    scrollView.layer.borderWidth = 0.5;
    self.computeView = scrollView;
    
    //2. ...view setting
    
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).mas_offset(UIEdgeInsetsMake(collectionH +15, 30, 20 + BottomStatusSep, 30));
    }];

    
    UIView *computeView = [[UIView alloc] init];
    
    //2.1 固收期限
    CGFloat itemW = IPHONE_6_OR_LARGER? 300: 260;
    CGFloat itemH = 50;
    UIView *item1 = [MyUtility generateTextField:@"固收期限(x月):" placeholder:@"产品投资期限（月）" frame:CGRectMake(0, 0, itemW, itemH)];
    [computeView addSubview:item1];
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView.mas_centerX);
        make.top.equalTo(computeView.mas_top).offset(20);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo(itemW);
    }];
    
    //2.2 固收利率
    UIView *item2 = [MyUtility generateTextField:@"固收利率(n%):" placeholder:@"产品预期收益率(0.3%)" frame:CGRectMake(0, 0, itemW, itemH)];
    [computeView addSubview:item2];
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView.mas_centerX);
        make.top.equalTo(item1.mas_bottom).offset(15);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo(itemW);
    }];
    
    //2.3 投资本金
    UIView *item3 = [MyUtility generateTextField:@"投资本金(m元):" placeholder:@"预算投资本金（元）" frame:CGRectMake(0, 0, itemW, itemH)];
    [computeView addSubview:item3];
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView.mas_centerX);
        make.top.equalTo(item2.mas_bottom).offset(15);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo(itemW);
    }];
    
    //2.4 投资期限
    UIView *item4 = [MyUtility generateTextField:@"投资期限(y月):" placeholder:@"预投资月数（月）" frame:CGRectMake(0, 0, itemW, itemH)];
    [computeView addSubview:item4];
    [item4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView.mas_centerX);
        make.top.equalTo(item3.mas_bottom).offset(15);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo(itemW);
    }];
    //2.5 到期收益
    UIView *item5 = [MyUtility generateTextField:@"到期收益(z%):" placeholder:@"到期收益率：0%" frame:CGRectMake(0, 0, itemW, itemH)];
    [computeView addSubview:item5];
    [item5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView.mas_centerX);
        make.top.equalTo(item4.mas_bottom).offset(15);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo(itemW);
    }];
    
    UILabel *ruleLabel = [[UILabel alloc] init];
    [ruleLabel setNumberOfLines:0];
    [ruleLabel setText:@"\t1、 p = y/x\n\t2、z = m * (1+n*x/12)^p"];
    [ruleLabel setTextColor:[HexColor colorWithHexString:@"ff0000"]];
    [ruleLabel setFont:[UIFont systemFontOfSize:15]];
    [computeView addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(computeView);
        make.width.mas_equalTo(itemW);
        make.top.equalTo(item5.mas_bottom).offset(20);
    }];
    
    UIButton *computeBtn = [UIButton buttonWithName:@"计算" andFont:16 HexColor:@"666666" cornerRadius:5];
    
    computeBtn.layer.borderColor = [HexColor colorWithHexString:@"666666"].CGColor;
    computeBtn.layer.borderWidth = 0.5;
    [computeView addSubview:computeBtn];
    [computeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(computeView.mas_left).offset(20);
        make.top.equalTo(ruleLabel.mas_bottom).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    UIButton *compareBtn = [UIButton buttonWithName:@"保存" andFont:16 HexColor:@"666666" cornerRadius:5];
    compareBtn.layer.borderColor = [HexColor colorWithHexString:@"666666"].CGColor;
    compareBtn.layer.borderWidth = 0.5;
    [computeView addSubview:compareBtn];
    [compareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(computeBtn.mas_right).offset(20);
        make.top.width.height.equalTo(computeBtn);
    }];
    
    [scrollView addSubview:computeView];
    [computeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(scrollView);
        make.bottom.equalTo(computeBtn.mas_bottom).offset(20);
    }];
    
    [computeView layoutIfNeeded];
    CGFloat computeH = CGRectGetHeight(computeView.frame);
    [scrollView setContentSize:CGSizeMake(0, computeH)];
    
    //todo result初始化
    self.results = [[NSMutableArray alloc] initWithObjects:@"name",@"name", nil];
}

#pragma mark - collectionview  associate method

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.results.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ResultCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    //todo set format tip result
    [cell.tipLabel setText:[NSString stringWithFormat:@"结果%d",(int)indexPath.item]];
    
    return cell;
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
