//
//  HoldingModel.h
//  Finance
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "BaseModel.h"

#define FFHoldingKey @"ff_holding"
//持有资产表 ff_holding Fly Finance

typedef enum : NSUInteger {
    SuggestTypeHold,//持有
    SuggestTypeAdd,//加仓
    SuggestTypeCut,//减仓
    SuggestTypeClear//清仓
} SuggestType;

@interface HoldingModel : BaseModel

@property (nonatomic, assign) NSInteger holdingID;

//金额
@property (nonatomic, assign) CGFloat money;

//录入净值（需要实时录入）可参考 以后考虑使用公共接口 返回实时净值
@property (nonatomic, assign) CGFloat netValue;
//持有收益率
@property (nonatomic, assign) CGFloat eraningRatio;
//平均成本
@property (nonatomic, assign) CGFloat holdingCost;
//持有份额
@property (nonatomic, assign) CGFloat shareholding;
//持有时长（由创建时间计算而得）
//创建时间
@property (nonatomic, assign) NSInteger created;

//平台
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, assign) NSInteger platformID;
//基金信息
@property (nonatomic, assign) NSInteger foundNum;
@property (nonatomic, copy) NSString *foundName;
@property (nonatomic, copy) NSString *foundType;//大盘 小盘 创业版等
//评论心得
@property (nonatomic, copy) NSString *remark;

//加仓减仓日志（指导 加仓）建议回投资平台查看
////

//评级状态 需要关注的 继续持有 加仓/减仓建议
@property (nonatomic, assign) SuggestType suggest;
//操作建议说明
@property (nonatomic, copy) NSString *suggestTips;

//是否定投中
@property (nonatomic, assign) BOOL isFixInvesting;
//定投计划(建议使用定投表便于统计 每周每月支出)
@property (nonatomic, assign) NSInteger fixInvestID;

//other 是否考虑添加 货币基金池 计算临时持有收益 最大化资金 使用效率

@end
