//
//  HomeBoardView.m
//  Finance
//
//  Created by mac on 2018/6/25.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "HomeBoardView.h"

@interface HomeBoardView()

@end

@implementation HomeBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setInfoDict:(NSDictionary *)infoDict{
    _infoDict = infoDict;
    
    if (!infoDict || [self.subviews count] < 2) {
        return;
    }
    
    int index = 0;
    NSString *title = [infoDict objectForKey:@"title"];
    UILabel *titleLab = [self.subviews objectAtIndex:index++];
    [titleLab setText:title];
    
    NSString *subTitle = [infoDict objectForKey:@"subTitle"];
    UIScrollView *scrollView = [self.subviews objectAtIndex:index++];
    
    UILabel *subTitleLab = [UILabel labelWithName:subTitle fontSize:15 fontColor:[UIColor whiteColor]];
    CGFloat labH = CGRectGetHeight(scrollView.frame);
    CGSize fitSize = [subTitleLab sizeThatFits:CGSizeMake(MAXFLOAT, labH)];
    [subTitleLab setFrame:CGRectMake(16, 0, fitSize.width, labH)];
    [scrollView addSubview:subTitleLab];
    
    [scrollView setContentSize:CGSizeMake(fitSize.width+32, labH)];
//    NSString *vcName = [infoDict objectForKey:@"vcName"];//todo click的时候跳转
    
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame commonStyle:YES];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {

    UILabel *nameLabel = [UILabel labelWithName:@"" boldSize:18 fontHexColor:@"333333"];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [nameLabel setBackgroundColor:[UIColor whiteColor]];
    nameLabel.layer.masksToBounds = YES;
    nameLabel.layer.cornerRadius = 5;
    
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(80);
        make.top.equalTo(self.mas_top).offset(10);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    self.scrollView = scrollView;
    scrollView.layer.cornerRadius = 5;
    scrollView.layer.masksToBounds = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setBackgroundColor:RiseColor];
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
//    UIView *gradientView = [[UIView alloc] init];
//    CAGradientLayer *layer = [CAGradientLayer layer];
//    layer.frame = gradientView.frame;
//    layer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)RiseColor.CGColor,nil];
//    layer.startPoint = CGPointMake(1, 0);
//    layer.endPoint = CGPointMake(1, 1); //  设置颜色变化点，取值范围 0.0~1.0
//    layer.locations = @[@0,@1];
//    
//    [self addSubview:gradientView];
//    [gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(nameLabel);
//        make.top.equalTo(nameLabel.mas_bottom);
//        make.height.mas_equalTo(30);
//    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //执行callback
    if (!self.infoDict) {
        return;
    }
    
    NSString *vcName = [self.infoDict objectForKey:@"vcClass"];
    if (self.callBack) {
        self.callBack(vcName);
    }
}

@end
