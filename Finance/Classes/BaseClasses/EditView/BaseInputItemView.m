//
//  BaseInputItemView.m
//  Finance
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "BaseInputItemView.h"

@interface BaseFinanceView ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation BaseInputItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame inputType:(InputViewType)inputType{
    return [self initWithFrame:frame inputType:inputType commonStyle:YES];
}

-(instancetype)initWithFrame:(CGRect)frame inputType:(InputViewType)inputType commonStyle:(BOOL)hasStyle{
    self = [super initWithFrame:frame commonStyle:hasStyle];
    
    if (self) {
        [self setupUIWithType:inputType];
    }
    return self;
}

- (void)setupUIWithType:(InputViewType) type {
    //todo input view 初始化
    switch (type) {
        case InputViewTypeTextField:
        {
            UITextField *textField = [[UITextField alloc] init];
            textField.delegate = self;
            [self addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            self.inputView = textField;
        }
            break;
        case InputViewTypeTextView:
        {
            UITextView *textField = [UITextView init];
            textField.delegate = self;
            [self addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            self.inputView = textField;
        }
            break;
        case InputViewTypePicker:
        {
            UILabel *textField = [[UILabel alloc] init];
            [self addSubview:textField];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
            self.inputView = textField;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - delegate method

-(void)textFieldDidEndEditing:(UITextField *)textField{
    //todo something
    NSString *value = @"todo var type fetch value";
    
    if ([self.delegate respondsToSelector:@selector(finishedInputCallBack:value:)]) {
        [self.delegate finishedInputCallBack:self.key value:value];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    //todo something
    
    NSString *value = @"todo var type fetch value";
    
    if ([self.delegate respondsToSelector:@selector(finishedInputCallBack:value:)]) {
        [self.delegate finishedInputCallBack:self.key value:value];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    //todo something
}

-(void)textViewDidChange:(UITextView *)textView{
    //todo something
}

@end
