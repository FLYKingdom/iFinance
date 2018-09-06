//
//  HomeBoardView.h
//  Finance
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFinanceView.h"

@interface HomeBoardView : BaseFinanceView

@property (nonatomic, strong) NSDictionary *infoDict;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, copy) void(^callBack)(NSString *vcClass);

@end
