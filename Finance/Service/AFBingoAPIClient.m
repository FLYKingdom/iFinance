//
//  AFBingoAPIClient.m
//  zhaosha
//
//  Created by Eelsyang on 15-12-23.
//  Copyright (c) 2015年 com.zhaosha All rights reserved.
//

#import "AFBingoAPIClient.h"

//#import "AFBingoJSONRequestOperation.h"
#import "TMCache.h"

@implementation AFHTTPRequestOperation

@end

@implementation AFBingoAPIClient

+ (instancetype)sharedClient {
    static AFBingoAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFBingoAPIClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedClient;
}

#pragma mark -  get and post

- (void)getSessionWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    NSString *userID     = [[TMCache sharedCache] objectForKey:@"userID"];
    
    //对链接进行加密
    NSString *originStr=@"";
    // 参数含有userID，最终字符串含有两个userID
    if (originStr.length>0) {
        originStr=[originStr substringToIndex:originStr.length-1];
        originStr=[originStr stringByAppendingString:[NSString stringWithFormat:@"&userID=%@",userID]];
    }else{
        originStr=[NSString stringWithFormat:@"userID=%@",userID];
    }
    NSNumber *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSMutableDictionary *newParameters =  [NSMutableDictionary dictionaryWithDictionary:parameters];
    [newParameters setObject:@(2) forKey:@"platform"];
    [newParameters setObject:currentVersion forKey:@"version"];

    [self GET:path parameters:newParameters progress:NULL success:success failure:failure];
}

-(void)postSessionWithPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
//    id userID = [[TMCache sharedCache] objectForKey:@"userID"];
//    if (userID) {
//        if ([path containsString:@"?"]) {
//            path=[NSString stringWithFormat:@"%@&userID=%@",path,userID];
//        }else{
//            path=[NSString stringWithFormat:@"%@?&userID=%@",path,userID];
//        }
//    }
    
    NSNumber *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    path = [path stringByAppendingString:[NSString stringWithFormat:@"?platform=2&version=%@",currentVersion]];
    
    [self POST:path parameters:parameters progress:NULL success:success failure:failure];
}

-(void)downloadFileWithPath:(NSString *)path filePath:(NSString *)filePath success:(void (^)(NSData *))success failure:(void (^)(NSString *))failure{
    //TOReset(适配https)
    NSURL* url = [NSURL URLWithString:path];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {

            BOOL isExist = [self addFilePath];
            BOOL isWritten = NO;

            if (isExist) {
                isWritten = [data writeToFile:filePath atomically:YES];
            }

            if (isWritten && success) {
                success(data);
            }
            if (!isWritten && failure) {
                failure(@"写入文件错误");
            }
        }else{
            if (failure) {
                failure(@"文件下载失败");
            }
        }
    }];

}

- (BOOL)addFilePath {
    NSString *localPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileDictionary = [localPath stringByAppendingFormat:@"/appdata/chatbuffer/zhaosha"];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = NO;
    if ([fileManager fileExistsAtPath:fileDictionary]) {
        isExist = YES;
    }else{
        NSError *error = nil;
        [fileManager createDirectoryAtPath:fileDictionary withIntermediateDirectories:YES attributes:nil error:&error];
        isExist = !error;
    }
    return isExist;
}

- (void)uploadImageWithPath:(NSString *)path
                  parameter:(NSDictionary *)parameter
          imagePrameterName:(NSString *) imageName
                       imageData:(NSData *) imageData
              progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)) progressBlock
          completionHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject)) completion
{
    NSNumber *userID=[[TMCache sharedCache] objectForKey:@"userID"];
    NSNumber *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *finalPath=[NSString stringWithFormat:@"%@?userID=%@&platform=2&version=%@",path,userID,currentVersion];

    [self POST:finalPath parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageData name:imageName fileName:@"docImg.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock && uploadProgress) {
            progressBlock(uploadProgress.completedUnitCount,uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
//            progressBlock(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(nil,nil,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil,error,nil);
        }
    }];
}

@end
