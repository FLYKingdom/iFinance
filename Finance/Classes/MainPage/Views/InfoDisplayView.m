//
//  InfoDisplayView.m
//  Finance
//
//  Created by mac on 2018/7/1.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "InfoDisplayView.h"

#import "UILabel+Extension.h"

@interface InfoDisplayView()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation InfoDisplayView

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
    
    //todo set values
    CGFloat scrollW = CGRectGetWidth(self.scrollView.frame);
    
    CGFloat lefSep = 0;
    CGFloat topSep = 10;
    CGFloat height = 50;//totalH - 2*topSep;
    
    NSString *tipStr = nil;
    NSString *placeHolder = nil;
    for (NSDictionary *item in propertyInfos) {
        tipStr = [item objectForKey:@"tipStr"];
        placeHolder = [item objectForKey:@"placeholder"];
        UIView *propertyField1 = [self generatePropertyView:tipStr placeholder:placeHolder frame:CGRectMake(lefSep , topSep +  height*self.scrollView.tag, scrollW - 2*lefSep, height)];
        [self.scrollView addSubview:propertyField1];
        self.scrollView.tag ++;
    }
    
    
    [self.scrollView setContentSize:CGSizeMake(scrollW, topSep +(topSep+ height)*self.scrollView.tag)];
    
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
    scrollView.layer.cornerRadius = 5;
    scrollView.layer.masksToBounds = YES;
    [scrollView setBackgroundColor:[UIColor whiteColor]];
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLable.mas_bottom).offset(15);
        make.right.equalTo(self.mas_right).offset(-sepWidth);
        make.left.equalTo(self.mas_left).offset(sepWidth);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

-(UIView *)generatePropertyView:(NSString *)tipStr placeholder:(NSString *)placeholder frame:(CGRect)frame{
    CGFloat height = CGRectGetHeight(frame);
    
    UIView *tmpView = [[UIView alloc] initWithFrame:frame];
    
    CGFloat labelWidth = (tipStr.length +1) * DefaultMainFontSize;
    
    UILabel *tipLab = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, labelWidth, height)];
    [tipLab setText:tipStr];
    [tipLab setFont:[UIFont fontWithName:FontName size:DefaultMainFontSize]];
    [tipLab setTextAlignment:NSTextAlignmentLeft];
    tipLab.textColor=[UIColor lightGrayColor];
    [tmpView addSubview:tipLab];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.layer.cornerRadius = 5;
    textLabel.layer.masksToBounds = YES;
    [textLabel setBackgroundColor:[UIColor whiteColor]];
    
    textLabel.textAlignment=NSTextAlignmentLeft;
    textLabel.font = [UIFont fontWithName:FontName size:TitleFontSize];
    textLabel.textColor = DefaultFontColor;
    textLabel.text = placeholder;
    [textLabel setFrame:CGRectMake(CGRectGetMaxX(tipLab.frame), 0, CGRectGetWidth(frame) - CGRectGetMaxX(tipLab.frame), height)];
    [tmpView addSubview:textLabel];
    
    return tmpView;
}

@end
