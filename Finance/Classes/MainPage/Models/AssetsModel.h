//
//  AssetsModel.h
//  Finance
//
//  Created by mac on 2017/9/16.
//  Copyright © 2017年 FlyYardAppStore. All rights reserved.
//

#import "BaseModel.h"

@interface AssetsModel : BaseModel

@property (nonatomic, copy) NSString *platform;//平台

@property (nonatomic, assign) NSTimeInterval startTime;

@property (nonatomic, assign) NSTimeInterval endTime;

@property (nonatomic, assign) double amount;

@property (nonatomic, assign) double endEraning;

@property (nonatomic, assign) double dayEraning;

@property (nonatomic, copy) NSString *eraningRatio;

@end
