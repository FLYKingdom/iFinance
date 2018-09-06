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

@property (nonatomic, assign) NSInteger plantformID;

@property (nonatomic, copy) NSString *platformName;

//app scheme用于快速 跳转到理财app
@property (nonatomic, copy) NSString *scheme;

@end
