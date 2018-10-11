//
//  PlatformHoldCell.m
//  Finance
//
//  Created by mac on 2018/10/11.
//  Copyright © 2018年 FlyYardAppStore. All rights reserved.
//

#import "PlatformHoldCell.h"

@implementation PlatformHoldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BaseModel *) model {
    [super setModel:model];
    
    //set values
}

-(void)setupUI{
    // set up ui
    
    UIView *sepView = [[UIView alloc] init];
    self.sepView = sepView;
    [self.contentView addSubview:sepView];
    [sepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView.mas_top).offset(50);
        make.height.equalTo(@(0.5));
    }];
}

@end
