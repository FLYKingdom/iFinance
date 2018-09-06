
//
//  AssetsCell.m
//  Finance
//
//  Created by mac on 2017/9/16.
//  Copyright © 2017年 FlyYardAppStore. All rights reserved.
//

#import "AssetsCell.h"
#import <ChameleonFramework/Chameleon.h>

#import "MyUtility.h"

@interface AssetsCell ()

@property (nonatomic, strong) UILabel *plantformLab;

@property (nonatomic, strong) UILabel *amountLab;

@property (nonatomic, strong) UILabel *subTipLab;

@property (nonatomic, strong) UILabel *eranRatioLab;

@property (nonatomic, strong) UILabel *endEranLab;

@property (nonatomic, strong) UILabel *restTimeLab;

@end

@implementation AssetsCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setModel:(BaseModel *)model{
    [super setModel:model];
    
    if (!model) {
        return;
    }
    
    AssetsModel *tmpModel = (AssetsModel *) model;
    //: set values
    [self.plantformLab setText:tmpModel.platform];
    
    [self.eranRatioLab setText:tmpModel.eraningRatio];
    
    NSString *finalTip = [NSString stringWithFormat:@"%.02lf\n%lf",tmpModel.dayEraning,tmpModel.endTime];
    [self.subTipLab setText:finalTip];
    
    [self.amountLab setText:[NSString stringWithFormat:@"%.02lf",tmpModel.amount]];
    
    [self.endEranLab setText:[NSString stringWithFormat:@"%.02lf",tmpModel.endEraning]];
    [self.restTimeLab setText:[@(tmpModel.endTime) description]];
    
}

-(void)setupUI{
    [self.contentView setBackgroundColor:DefaultBGColor];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 12, 10, 12);
    UIView *shadowView = [[UIView alloc] init];
    [MyUtility addShadowView:shadowView Opacity:0.2];
    [self.contentView addSubview:shadowView];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(inset);
    }];
    
    UIView *cardView = [[UIView alloc] init];
    NSArray *colors = @[[UIColor flatYellowColor], [UIColor flatRedColor]];
    UIColor *color = [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight withFrame:CGRectMake(0, 0, kDeviceWidth-14, 100) andColors:colors]; //[UIColor flatRedColor];
    UIColor *lightColor = [UIColor flatPurpleColor];
    [lightColor lightenByPercentage:0.4];
//    [color lightenByPercentage:0.2];
    [cardView setBackgroundColor:lightColor];
    cardView.layer.cornerRadius = 5;
    cardView.layer.masksToBounds = YES;
    [self.contentView addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(inset);
    }];
    
    //上半部分
    CGFloat topH = 50;
    UILabel *plantFormLab = [UILabel labelWithName:@"" boldSize:15 fontHexColor:@"333333"];
    self.plantformLab = plantFormLab;
    [plantFormLab setTextColor:[UIColor whiteColor]];
    
    [cardView addSubview:plantFormLab];
    [plantFormLab setFrame:CGRectMake(16, 0, kDeviceWidth -200, topH)];
    
    UILabel *earnRatioLab = [UILabel labelWithName:@"" fontSize:18 fontHexColor:@"ff0000"];
    self.eranRatioLab = earnRatioLab;
    [earnRatioLab setTextAlignment:NSTextAlignmentCenter];
    [cardView addSubview:earnRatioLab];
    [earnRatioLab setFrame:CGRectMake(CGRectGetMaxX(plantFormLab.frame) +5, 0, 40, topH)];
    
    UILabel *subTipLabel = [UILabel labelWithName:@"" fontSize:14 fontHexColor:@"666666"];
    self.subTipLab = subTipLabel;
    subTipLabel.numberOfLines = 2;
    [subTipLabel setTextAlignment:NSTextAlignmentRight];
    [cardView addSubview:subTipLabel];
    CGFloat starX = CGRectGetMaxX(earnRatioLab.frame) + 10;
    [subTipLabel setFrame:CGRectMake(starX, 0, kDeviceWidth - starX - 16, topH)];
    
    //下半部分
    CGFloat bottomH = 80;
    UILabel *amountLab = [UILabel labelWithName:@"" fontSize:30 fontHexColor:@"ff6600"];
    self.amountLab = amountLab;
    [cardView addSubview:amountLab];
    [amountLab setFrame:CGRectMake(16, topH, CGRectGetWidth(plantFormLab.frame), bottomH)];
    
    UILabel *endEranLab = [UILabel labelWithName:@"" fontSize:18 fontHexColor:@"ff0000"];
    self.endEranLab = endEranLab;
    starX = CGRectGetMaxX(amountLab.frame) + 10;
    [endEranLab setFrame:CGRectMake(starX, topH, kDeviceWidth - 16 -starX, 50)];
    [endEranLab setTextAlignment:NSTextAlignmentCenter];
    [cardView addSubview:endEranLab];
    
    UILabel *endTimeLab = [UILabel labelWithName:@"" fontSize:16 fontHexColor:@"000000"];
    self.restTimeLab = endTimeLab;
    [cardView addSubview:endTimeLab];
    [endTimeLab setTextAlignment:NSTextAlignmentCenter];
    [endTimeLab setFrame:CGRectMake(starX, CGRectGetMaxY(endEranLab.frame), CGRectGetWidth(endEranLab.frame), 30)];
    
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(0, topH +bottomH -0.5, kDeviceWidth, 0.5)];
    [sepView setBackgroundColor:RGBA(51, 51, 51, 0.2)];
    self.sepView = sepView;
    
    [cardView addSubview:sepView];
}

@end
