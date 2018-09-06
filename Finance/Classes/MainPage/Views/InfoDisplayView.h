//
//  InfoDisplayView.h
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDisplayView : UIView

@property (nonatomic, strong) NSArray *propertyInfos;

- (instancetype)initWithFrame:(CGRect)frame tip:(NSString *) tip;

@end
