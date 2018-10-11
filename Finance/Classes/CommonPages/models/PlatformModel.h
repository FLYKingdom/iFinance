//
//  PlatformModel.h
//  Finance
//
//  Created by mac on 2018/6/22.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "BaseModel.h"
#define FFPlatformKey @"ff_platform"

//平台表 ff_platform

@interface PlatformModel : BaseModel

//info id
@property (nonatomic, copy) NSString *platform;

@property (nonatomic, assign) CGFloat total;
@property (nonatomic, assign) CGFloat earning;

//app scheme用于快速 跳转到理财app
@property (nonatomic, copy) NSString *scheme;

@end
