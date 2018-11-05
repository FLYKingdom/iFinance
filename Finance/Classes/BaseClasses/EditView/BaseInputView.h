//
//  BaseInputView.h
//  Finance
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "BaseFinanceView.h"
#import "BaseInputItemView.h"

//input view delegate
@protocol BaseInputViewDelegate <NSObject>

@required

-(BOOL) shouldChangeKey:(NSString *) key value:(NSString *) value;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BaseInputView : BaseFinanceView

@property (nonatomic, copy) id<BaseInputViewDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *inputViews;

-(void) setupUI;

@end

NS_ASSUME_NONNULL_END
