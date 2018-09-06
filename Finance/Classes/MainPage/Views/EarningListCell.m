//
//  EarningListCell.m
//  Finance
//
//  Created by mac on 2018/6/23.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "EarningListCell.h"
#import <ChameleonFramework/Chameleon.h>

@interface EarningListCell()

@property (nonatomic, strong) UIView *container;

@end

@implementation EarningListCell

-(void)setModel:(BaseModel *)model{
    [super setModel:model];
    
    EarningModel *tmpModel = (EarningModel *) model;
    if (!tmpModel) {
        return;
    }
    //todo set value
    NSArray *tmpViewArr = self.container.subviews;
    
    if (!tmpViewArr || tmpViewArr.count < 10) {
        return;
    }
    
    [self.container setBackgroundColor:[UIColor flatRedColor]];
    NSInteger index = 0;
    UILabel *nameLabel = [tmpViewArr objectAtIndex:index++];
    [nameLabel setText:tmpModel.foundName];
    
    UILabel *moneyLab = [tmpViewArr objectAtIndex:index++];
    [moneyLab setText:[tmpModel getFormatFloatString:@"money"]];

    UILabel *earnMoneyLab = [tmpViewArr objectAtIndex:index++];
    NSString *tmpStr = [tmpModel getFormatFloatString:@"earnmMoney" precision:2 sign:YES];
    [earnMoneyLab setText:[NSString stringWithFormat:@"%@元",tmpStr]];
    
    index++;//Tip
    UILabel *earnRatioLab = [tmpViewArr objectAtIndex:index++];
    [earnRatioLab setText:[tmpModel getFormatPercentString:@"earningRatio" precision:2 sign:NO]];
    
    index++;
    UILabel *yearRatioLab = [tmpViewArr objectAtIndex:index++];
    [yearRatioLab setText:[tmpModel getFormatPercentString:@"yearEarnRatio" precision:2 sign:NO]];
    
    index ++;
    UILabel *inTimeLab = [tmpViewArr objectAtIndex:index++];
    [inTimeLab setText:[tmpModel getFormatDateString:@"created"]];
    
    index ++;
    UILabel *outTimeLab = [tmpViewArr objectAtIndex:index++];
    [outTimeLab setText:[tmpModel getFormatDateString:@"outTime"]];
    
    UILabel *daysLab = [tmpViewArr objectAtIndex:index];
    [daysLab setText:[tmpModel getDaysWithBegin:@"created" end:@"outTime"]];//计算持有天数
}

-(void)setupUI{
    [super setupUI];
    [self setBackgroundColor:DefaultBGColor];
    
    CGFloat topSep = 7;
    
    UIView *container = [[UIView alloc] init];
    self.container = container;
    container.layer.cornerRadius = 5;
    container.layer.masksToBounds = YES;
    
    NSString *contentColor = @"ffffff";
    UILabel *nameLabel = [UILabel labelWithName:@"" boldSize:16 fontHexColor:contentColor];
    [container addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(container.mas_left).offset(5);
        make.top.equalTo(container.mas_top).offset(10);
    }];
    
    UILabel *moneyLab = [UILabel labelWithName:@"" fontSize:30 fontHexColor:contentColor];
    [container addSubview:moneyLab];
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_left);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
    }];
    
    UILabel *earnLab = [UILabel labelWithName:@"" fontSize:20 fontHexColor:contentColor];
    [container addSubview:earnLab];
    [earnLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLab.mas_right).offset(7);
        make.bottom.equalTo(moneyLab.mas_bottom).offset(-3.5);
    }];
    
    UILabel *earnTipLab = [UILabel labelWithName:@"持有收益：" fontSize:15 fontHexColor:contentColor];
    [container addSubview:earnTipLab];
    [earnTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLab.mas_left);
        make.top.equalTo(moneyLab.mas_bottom).offset(15);
    }];
    
    UILabel *earnRatioLab = [UILabel labelWithName:@"" fontSize:15 fontHexColor:contentColor];
    [container addSubview:earnRatioLab];
    [earnRatioLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(earnTipLab.mas_right).offset(3);
        make.top.equalTo(moneyLab.mas_bottom).offset(15);
    }];
    
    UILabel *yearEarnTipLab = [UILabel labelWithName:@"年化收益：" fontSize:15 fontHexColor:contentColor];
    [container addSubview:yearEarnTipLab];
    [yearEarnTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(earnRatioLab.mas_right).offset(20);
        make.bottom.equalTo(earnRatioLab.mas_bottom);
    }];
    
    UILabel *yearEarnRatioLab = [UILabel labelWithName:@"" fontSize:15 fontHexColor:contentColor];
    [container addSubview:yearEarnRatioLab];
    [yearEarnRatioLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yearEarnTipLab.mas_right).offset(3);
        make.centerY.equalTo(earnRatioLab.mas_centerY);
    }];
    
    UILabel *inTipLab = [UILabel labelWithName:@"买入时间：" fontSize:15 fontHexColor:contentColor];
    [container addSubview:inTipLab];
    [inTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(earnTipLab.mas_left);
        make.top.equalTo(earnRatioLab.mas_bottom).offset(10);
    }];
    
    UILabel *inTimeLab = [UILabel labelWithName:@"" fontSize:15 fontHexColor:@"333333"];
    [inTimeLab setBackgroundColor:[UIColor whiteColor]];
    inTimeLab.layer.cornerRadius = 3;
    inTimeLab.layer.masksToBounds = YES;
    [inTimeLab setTextAlignment:NSTextAlignmentCenter];
    [container addSubview:inTimeLab];
    [inTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inTipLab.mas_right).offset(3);
        make.centerY.equalTo(inTipLab.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];

    UILabel *outTipLab = [UILabel labelWithName:@"赎回时间：" fontSize:15 fontHexColor:contentColor];
    [container addSubview:outTipLab];
    [outTipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inTimeLab.mas_right).offset(20);
        make.top.equalTo(earnRatioLab.mas_bottom).offset(10);
    }];
    
    UILabel *outTimeLab = [UILabel labelWithName:@"" fontSize:15 fontHexColor:@"333333"];
    [outTimeLab setBackgroundColor:[UIColor whiteColor]];
    [outTimeLab setTextAlignment:NSTextAlignmentCenter];
    outTimeLab.layer.cornerRadius = 3;
    outTimeLab.layer.masksToBounds = YES;
    [container addSubview:outTimeLab];
    [outTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(outTipLab.mas_right).offset(3);
        make.centerY.equalTo(outTipLab.mas_centerY);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *doneLabel = [UILabel labelWithName:@"" fontSize:25 fontHexColor:contentColor];
    [container addSubview:doneLabel];
    [doneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(container.mas_right).offset(-10);
        make.centerY.equalTo(moneyLab.mas_centerY);
    }];
    
    [self.contentView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(PaddingBorder);
        make.right.equalTo(self.contentView.mas_right).offset(-PaddingBorder);
        make.top.equalTo(self.contentView.mas_top).offset(topSep);
        make.bottom.equalTo(inTipLab.mas_bottom).offset(10);
    }];
    
    UIView *sepView = [[UIView alloc] init];
    self.sepView = sepView;
    [self.contentView addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.top.equalTo(self.container.mas_bottom).offset(topSep);
        make.width.equalTo(@(kDeviceWidth-16));
        make.height.equalTo(@(0.5));
    }];
}


@end
