//
//  InfoPropertyView.h
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    InfoInputTypeText,
    InfoInputTypeButton,
} InfoInputType;

@interface InfoPropertyView : UIView

@property (nonatomic, strong) NSArray *propertyInfos;

//event 1begin 2end
@property (nonatomic, copy) void((^callback)(NSString *key,NSInteger event));

- (instancetype)initWithFrame:(CGRect)frame tip:(NSString *) tip;

@end
