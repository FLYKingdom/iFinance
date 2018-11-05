//
//  BaseInputView.m
//  Finance
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018 FlyYardAppStore. All rights reserved.
//

#import "BaseInputView.h"

@implementation BaseInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame commonStyle:(BOOL)hasStyle{
    self = [super initWithFrame:frame commonStyle:hasStyle];
    
    if (self) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    [self setBackgroundColor:DefaultBGColor];
}

@end
