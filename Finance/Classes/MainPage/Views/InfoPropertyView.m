//
//  InfoPropertyView.m
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "InfoPropertyView.h"

#import "GradientView.h"
#import "UILabel+Extension.h"

@interface InfoPropertyView()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation InfoPropertyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setPropertyInfos:(NSArray *)propertyInfos{
    _propertyInfos = propertyInfos;
    
    if (self.scrollView.tag == propertyInfos.count) {
        return;
    }
    [self layoutIfNeeded];
    
    GradientView *leftView = [self.subviews objectAtIndex:2];
    GradientView *rightView = [self.subviews objectAtIndex:3];
    [leftView drawGradientLayer:DefaultBGColor];
    [rightView drawGradientLayer:DefaultBGColor];
    
    //todo set values
    CGFloat lefSep = 50;
    CGFloat topSep = 10;
    CGFloat totalH = CGRectGetHeight(self.scrollView.frame);
    CGFloat height = totalH - 2*topSep;
    
    NSString *tipStr = nil;
    NSString *placeHolder = nil;
    InfoInputType type = InfoInputTypeText;
    for (NSDictionary *item in propertyInfos) {
        tipStr = [item objectForKey:@"tipStr"];
        placeHolder = [item objectForKey:@"placeholder"];
        NSNumber *typeNum = [item objectForKey:@"type"];
        if (typeNum) {
            type = [typeNum integerValue];
        }
        
        UIView *propertyField1 = [self generateTextField:tipStr type:type placeholder:placeHolder frame:CGRectMake(lefSep + kDeviceWidth*self.scrollView.tag, topSep, kDeviceWidth - 2*lefSep, height)];
        [self.scrollView addSubview:propertyField1];
        self.scrollView.tag ++;
    }
    
    
    [self.scrollView setContentSize:CGSizeMake(kDeviceWidth * (self.scrollView.tag), totalH)];
    
}

- (instancetype)initWithFrame:(CGRect)frame tip:(NSString *) tip
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI:tip];
    }
    return self;
}

-(void) setupUI:(NSString *) tip{
    CGFloat sepWidth = 50;
    UILabel *tipLable = [UILabel labelWithName:tip fontSize:17 fontColor:[HexColor colorWithHexString:@"333333"]];
    [self addSubview:tipLable];
    [tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(sepWidth);
        make.right.top.equalTo(self);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLable.mas_bottom).offset(15);
        make.left.right.bottom.equalTo(self);
    }];
    
    GradientView *leftSepView = [[GradientView alloc] initWithFrame:CGRectZero direction:GradientStyleLeftRight];
    [self addSubview:leftSepView];
    [leftSepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(scrollView);
        make.width.mas_equalTo(sepWidth);
    }];
    
    GradientView *rightSepView = [[GradientView alloc] initWithFrame:CGRectZero direction:GradientStyleRightLeft];
    [self addSubview:rightSepView];
    [rightSepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(scrollView);
        make.width.mas_equalTo(sepWidth);
    }];
}

-(UIView *)generateTextField:(NSString *)tipStr type:(InfoInputType) type placeholder:(NSString *)placeholder frame:(CGRect)frame{
    CGFloat height = CGRectGetHeight(frame);
    
    UITextField *textField = [[UITextField alloc] init];
    textField.layer.cornerRadius = 5;
    textField.layer.masksToBounds = YES;
    [textField setBackgroundColor:[UIColor whiteColor]];
    
    textField.textAlignment=NSTextAlignmentLeft;
    textField.font=[UIFont fontWithName:FontName size:DefaultMainFontSize];
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField.textColor = DefaultFontColor;
    
    textField.placeholder = placeholder;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    CGFloat labelWidth = (tipStr.length +2) * DefaultMainFontSize;
    
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelWidth, height)];
    [tipLab setText:tipStr];
    [tipLab setFont:[UIFont fontWithName:FontName size:DefaultMainFontSize]];
    [tipLab setTextAlignment:NSTextAlignmentCenter];
    tipLab.textColor = [UIColor lightGrayColor];
    
    CGFloat sepHeight = height*(1-0.618);
    UIView *sepView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(tipLab.frame)-0.5-DefaultMainFontSize/2, CGRectGetMidY(tipLab.frame)-sepHeight/2, 0.5, sepHeight)];
    [sepView setBackgroundColor:rgba(51, 51, 51, 0.2)];
    [tipLab addSubview:sepView];
    
    textField.leftView = tipLab;
    textField.delegate = self;
    
    if (type == InfoInputTypeButton) {
        UIView *container = [[UIView alloc] initWithFrame:frame];
        
        [textField setFrame:container.bounds];
        [container addSubview:textField];
        
        textField.userInteractionEnabled = NO;
        container.tag = self.scrollView.tag;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(propertyViewTapped:)];
        [container addGestureRecognizer:tapGesture];
        container.userInteractionEnabled = YES;
        
        return container;
    }
    
    [textField setFrame:frame];
    textField.tag = self.scrollView.tag;
    return textField;
}

#pragma mark - event

- (void)propertyViewTapped:(UITapGestureRecognizer *) tapGesture {
    UIView *gestureView = tapGesture.view;
    NSString *key = [self.propertyInfos objectAtIndex:gestureView.tag];
    
    if (self.callback) {
        self.callback(key, 1);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"value = %@",[textField text]);
    NSString *key = [self.propertyInfos objectAtIndex:textField.tag];
    
    if (self.callback) {
        self.callback(key, 2);
    }
}

@end
