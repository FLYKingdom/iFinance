//
//  MainPageService.m
//  Bunny
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Eels. All rights reserved.
//

#import "MainPageService.h"

@implementation MainPageService

+(void)getVersionFromServerSuccess:(void (^)(NSDictionary *, BOOL))successBlock fail:(void (^)(void))failBlock{
    NSNumber *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSMutableDictionary *newPara = [NSMutableDictionary dictionary];
    [newPara setObject:@1 forKey:@"type"];
    [newPara setObject:currentVersion forKey:@"code"];
    
    [[AFBingoAPIClient sharedClient] getSessionWithPath:@"method/version.check.inc.php" parameters:newPara success:^(NSURLSessionDataTask *task, id responseObject) {
        int responseCode=[[[responseObject valueForKey:RespMeta] valueForKey:RespCode] intValue];
        
        if (responseCode==200) {
            if (successBlock) {
                NSDictionary *data = [responseObject valueForKey:RespData];
        
                NSNumber *versionNum = [data valueForKey:@"code"];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:versionNum forKey:ServerVersion];
                
                BOOL needUpate = NO;

                int  currentVerNumber = [currentVersion intValue];
                needUpate = [versionNum integerValue] > currentVerNumber;
                
                successBlock(data,needUpate);
            }
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

@end
