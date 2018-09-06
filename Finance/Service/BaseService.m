//
//  BaseService.m
//  HaoyunDriver
//
//  Created by bingo on 14-8-4.
//  Copyright (c) 2014年 arteam. All rights reserved.
//

#import "BaseService.h"
#import "ShareMethodManager.h"

@implementation BaseService

+(void) postService:(NSDictionary*)parameter URL:(NSString *)requestURL success:(void (^)(void ))sussessBlock fail:(void (^)(NSString *reason))failBlock{
//    NSMutableDictionary *finalPara = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    NSInteger accountID = [CacheManager getAccountID];
//    NSString *accessToken = [CacheManager getUserAccessToken];
//    [finalPara setObject:@(accountID) forKey:@"accountId"];
//    [finalPara setObject:accessToken forKey:@"accessToken"];
//
//    [[AFBingoAPIClient sharedClient] postSessionWithPath:requestURL parameters:finalPara success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        int responseCode=[[[responseObject valueForKey:@"meta"] valueForKey:@"code"] intValue];
//        //        NSLog(@"response = %d",responseCode);
//        //        NSLog(@"json = %@",JSON);
//        if (responseCode==200) { //获取验证码成功
//
//            if (sussessBlock) {
//                sussessBlock();
//            }
//        }else{
//            NSString *desc=[[responseObject valueForKey:@"meta"] valueForKey:@"desc"] ;
//            if (failBlock) {
//                failBlock(desc);
//            }
//
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failBlock) {
//            failBlock([NSString stringWithFormat:@"未知网络错误，请检查您的网络" ]);
//        }
//    }];
    
}

+(void)addInfoService:(NSDictionary *)parameter URL:(NSString *)requestURL praseName:(NSString *)praseName success:(void (^)(NSInteger))sussessBlock fail:(void (^)(NSString *))failBlock{
//    NSMutableDictionary *finalPara = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    NSInteger accountID = [CacheManager getAccountID];
//    NSString *accessToken = [CacheManager getUserAccessToken];
//    [finalPara setObject:@(accountID) forKey:@"accountId"];
//    [finalPara setObject:accessToken forKey:@"accessToken"];
//
//    [[AFBingoAPIClient sharedClient] postSessionWithPath:requestURL parameters:finalPara success:^(NSURLSessionDataTask *task, id responseObject) {
//
//        NSLog(@"response = %@",responseObject);
//        int responseCode=[[[responseObject valueForKey:@"meta"] valueForKey:@"code"] intValue];
//        //        NSLog(@"response = %d",responseCode);
//        //        NSLog(@"json = %@",JSON);
//        if (responseCode==200) { //获取验证码成功
//            NSDictionary *data = [responseObject objectForKey:RespData];
//            NSNumber *resultNum = [data objectForKey:praseName];
//
//            NSInteger resultID = resultNum?[resultNum integerValue]:0;
//            if (sussessBlock) {
//                sussessBlock(resultID);
//            }
//        }else{
//            NSString *desc=[[responseObject valueForKey:@"meta"] valueForKey:@"desc"] ;
//            if (failBlock) {
//                failBlock(desc);
//            }
//
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failBlock) {
//            failBlock([NSString stringWithFormat:@"未知网络错误，请检查您的网络" ]);
//        }
//    }];
}

#pragma mark - base list request

+(void)getInfoListWithClass:(NSString *)modelClass key:(NSString *)key parameter:(NSDictionary *)parameter URL:(NSString *)url success:(void (^)(NSArray *))successBlock fail:(void (^)(NSString *))failBlock{
//    NSMutableDictionary *finalPara = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    NSInteger accountID = [CacheManager getAccountID];
//    NSString *accessToken = [CacheManager getUserAccessToken];
//    [finalPara setObject:@(accountID) forKey:@"accountId"];
//    if (accessToken) {
//        [finalPara setObject:accessToken forKey:@"accessToken"];
//    }
//
//    [[AFBingoAPIClient sharedClient] getSessionWithPath:url parameters:finalPara success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *resposeDict = [responseObject objectForKey:RespMeta];
//
//        if (resposeDict && [resposeDict isKindOfClass:[NSDictionary class]]) {
//
//            NSInteger code = [[resposeDict objectForKey:RespCode] integerValue];
//            NSString *desc = [resposeDict objectForKey:RespDesc];
//
//            if (code == SuccessCode) {
//                NSArray *tmpListArr = nil;
//                if (!key || [key isEqualToString:@""]) {
//                    tmpListArr = [responseObject objectForKey:RespData];
//                }else{
//                    NSDictionary *data = [responseObject objectForKey:RespData];
//                    tmpListArr = [data objectForKey:key];
//                }
//
//                NSMutableArray *tmpArr = [NSMutableArray arrayWithCapacity:tmpListArr.count];
//
//                for (NSDictionary *dict in tmpListArr) {
//                    if (![dict isKindOfClass:[NSDictionary class]]) {
//                        continue;
//                    }
//                    if (modelClass) {
//                        Class myClass = NSClassFromString(modelClass);
//                        BaseModel *model = [[myClass alloc] initWithDictionary:dict];
//                        [tmpArr addObject:model];
//                    }else{
//                        [tmpArr addObject:dict];
//                    }
//                }
//                if (successBlock){
//                    successBlock(tmpArr.copy);
//                }
//            }else{
//                if (failBlock) {
//                    failBlock(desc);
//                }
//            }
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failBlock) {
//            failBlock(NetWorkErrorStr);
//        }
//    }];

}

+(void)getInfoListWithClass:(NSString *)modelClass parameter:(NSDictionary *)parameter URL:(NSString *)url success:(void (^)(NSArray *))successBlock fail:(void (^)(NSString *))failBlock{
    [self getInfoListWithClass:modelClass key:@"" parameter:parameter URL:url success:successBlock fail:failBlock];
}

#pragma mark - base detail request

+(void)getDetailInfoWithClass:(NSString *)modelClass key:(NSString *)key parameter:(NSDictionary *)parameter URL:(NSString *)url success:(void (^)(BaseModel *))successBlock fail:(void (^)(NSString *))failBlock{
//    NSMutableDictionary *finalPara = [NSMutableDictionary dictionaryWithDictionary:parameter];
//    NSInteger accountID = [CacheManager getAccountID];
//    NSString *accessToken = [CacheManager getUserAccessToken];
//    [finalPara setObject:@(accountID) forKey:@"accountId"];
//    [finalPara setObject:accessToken forKey:@"accessToken"];
//
//    [[AFBingoAPIClient sharedClient] postSessionWithPath:url parameters:finalPara success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *resposeDict = [responseObject objectForKey:RespMeta];
//
//        if (resposeDict && [resposeDict isKindOfClass:[NSDictionary class]]) {
//
//            NSInteger code = [[resposeDict objectForKey:RespCode] integerValue];
//            NSString *desc = [resposeDict objectForKey:RespDesc];
//
//            if (code == SuccessCode) {
//                NSDictionary *tmpInfoDict = nil;
//                if (!key || [key isEqualToString:@""]) {
//                    tmpInfoDict = [responseObject objectForKey:RespData];
//                }else{
//                    NSDictionary *data = [responseObject objectForKey:RespData];
//                    tmpInfoDict = [data objectForKey:key];
//                }
//
//
//                Class myClass = NSClassFromString(modelClass);
//                BaseModel *model = [[myClass alloc] initWithDictionary:tmpInfoDict];
//
//                if (successBlock){
//                    successBlock(model);
//                }
//            }else{
//                if (failBlock) {
//                    failBlock(desc);
//                }
//            }
//        }
//
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        if (failBlock) {
//            failBlock(NetWorkErrorStr);
//        }
//    }];

}

+(void)getDetailInfoWithClass:(NSString *)modelClass parameter:(NSDictionary *)parameter URL:(NSString *)url success:(void (^)(BaseModel *))successBlock fail:(void (^)(NSString *))failBlock{
    [self getDetailInfoWithClass:modelClass key:@"" parameter:parameter URL:url success:successBlock fail:failBlock];
}

#pragma mark - upload Image

+(void)updateImage:(UIImage *)cerImage fileName:(NSString *)fileName parameter:(NSDictionary *)paramter url:(NSString *)url progress:(void (^)(CGFloat))progressBlock success:(void (^)(id))successBlock fail:(void (^)(NSString *))failBlock{

    //矫正
//    UIImage *rightImg = [ShareMethodManager adjustRightPhoto:cerImage];
//
//    NSMutableDictionary *finalPara = nil;
//    if (paramter) {
//        finalPara = [NSMutableDictionary dictionaryWithDictionary:paramter];
//    }else{
//        finalPara = [NSMutableDictionary dictionary];
//    }
//    NSInteger accountID = [CacheManager getAccountID];
//    NSString *accessToken = [CacheManager getUserAccessToken];
//    [finalPara setObject:@(accountID) forKey:@"accountId"];
//    [finalPara setObject:accessToken forKey:@"accessToken"];
//
//    //图片压缩至低于600K
//    float compressionQuality = 1.0;
//    NSData *imgData;
//
//    do {
//        imgData = UIImageJPEGRepresentation(rightImg, compressionQuality);
//        compressionQuality -= 0.1;
//        if (!imgData) {
//            break;
//        }
//    } while (imgData.length > 600000 && compressionQuality > 0.1);
//
//    [[AFBingoAPIClient sharedClient] uploadImageWithPath:url parameter:finalPara imagePrameterName:fileName imageData:imgData progressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
//        //        NSLog(@"bytesWritten = %d totalBytesWritten = %d totalBytesExpectedToWrite = %d",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
//        if (progressBlock) {
//            CGFloat progerss = (CGFloat) totalBytesWritten/totalBytesExpectedToWrite;
//            progressBlock(progerss);
//        }
//    } completionHandler:^(AFHTTPRequestOperation *operation, NSError *error, id responseObject) {
//        if (error) {
//            if (failBlock) {
//                failBlock(error.domain);
//            }
//        }else{
//            if (responseObject) {
//                NSLog(@"responseObject = %@",responseObject);
//                NSDictionary *meta = [responseObject objectForKey:@"meta"];
//                NSInteger responseCode = [[meta objectForKey:@"code"] integerValue];
//                if (responseCode == 200) {
//                    if (successBlock) {
//                        NSDictionary *data =  [responseObject objectForKey:@"data"];
//                        successBlock(data);
//                    }
//                }else{
//                    if (failBlock) {
//                        NSString *desc = [meta objectForKey:@"desc"];
//                        failBlock(desc);
//                    }
//                }
//
//            }
//        }
//    }];
    
}

@end
