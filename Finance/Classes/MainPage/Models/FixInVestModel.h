//
//  FixInVestModel.h
//  Finance
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "BaseModel.h"

//基金定投

typedef enum : NSUInteger {
    FixInvestTypeFix,
    FixInvestTypeVariable,
    FixInvestTypeCustom,
} FixInvestType;

@interface FixInVestModel : BaseModel

@property (nonatomic, assign) NSInteger fixinvestID;

@property (nonatomic, assign) FixInvestType investType;

@property (nonatomic, assign) CGFloat investMoney;

@end
