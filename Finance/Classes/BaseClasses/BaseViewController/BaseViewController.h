//
//  MyBaseViewController.h
//  schoolIM
//
//  Created by bingo on 14-10-15.
//  Copyright (c) 2014年 profusionup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    GetDataTypeInit,
    GetDataTypeReload,
    GetDataTypeInsert,
} GetDataType;//获取数据的方式

typedef enum{ADD_RECORD_BY_INIT,ADD_RECORD_BY_RELOAD,ADD_RECORD_BY_INSERT,ADD_RECORD_BY_CLEAR_CACHE} AddRecordType;

@interface BaseViewController : UIViewController

-(void)setupNavigationTitle:(NSString *)titleStr;

-(void)showPasscodeView;

@end
