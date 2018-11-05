//
//  BaseInputItemView.h
//  Finance
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "BaseFinanceView.h"

typedef enum : NSUInteger {
    InputViewTypeAlert,
    InputViewTypePicker,
    InputViewTypeTextField,
    InputViewTypeTextView,
    InputViewTypeNewPage,
    InputViewTypeCustom//todo 自定义样式
} InputViewType;

@protocol InputItemDelegate <NSObject>

@required

-(void) finishedInputCallBack:(NSString *) key value:(id) value;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BaseInputItemView : BaseFinanceView

@property (nonatomic, copy) id<InputItemDelegate> delegate;

@property (nonatomic, assign) InputViewType inputType;

@property (nonatomic, strong) UIView *inputView;

@property (nonatomic, copy) NSString *key;

-(instancetype) initWithFrame:(CGRect)frame inputType:(InputViewType) inputType;

-(instancetype) initWithFrame:(CGRect)frame inputType:(InputViewType) inputType commonStyle:(BOOL) hasStyle;

@end

NS_ASSUME_NONNULL_END
