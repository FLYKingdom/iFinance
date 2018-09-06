//
//  EarningModel.h
//  Finance
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "BaseModel.h"

#define FFEarningKey @"ff_earning"
//收益表 ff_earning Fly Finance

@interface EarningModel : BaseModel

@property (nonatomic, assign) NSInteger earningID;

//金额
@property (nonatomic, assign) CGFloat money;

//持有收益率
@property (nonatomic, assign) CGFloat earningRatio;
//持有年化 收益率
@property (nonatomic, assign) CGFloat yearEarnRatio;
//持有收益金额
@property (nonatomic, assign) CGFloat earnmMoney;

//持有时长（由创建时间计算而得）
//创建时间
@property (nonatomic, assign) NSInteger created;

//赎回时间
@property (nonatomic, assign) NSInteger outTime;

//平台
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, assign) NSInteger platformID;
//基金信息
@property (nonatomic, assign) NSInteger foundNum;
@property (nonatomic, copy) NSString *foundName;
@property (nonatomic, copy) NSString *foundType;//大盘 小盘 创业版等
//评论心得
@property (nonatomic, copy) NSString *remark;

@end
