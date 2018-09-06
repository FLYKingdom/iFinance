//
//  AFBingoAPIClient.h
//  zhaosha
//
//  Created by Eelsyang on 15-12-23.
//  Copyright (c) 2015年 com.zhaosha All rights reserved.
//
#import <Foundation/Foundation.h>

#import "AFHTTPSessionManager.h"

@interface AFHTTPRequestOperation : NSObject

@end

@interface AFBingoAPIClient : AFHTTPSessionManager

+ (AFBingoAPIClient *)sharedClient;//baseUrl

//下载文件
- (void)downloadFileWithPath:(NSString *)path
                    filePath:(NSString *) filePath
        success:(void (^)(NSData *responseData))success
        failure:(void (^)(NSString *reason))failure;

- (void)uploadImageWithPath:(NSString *)path
                  parameter:(NSDictionary *)parameter
          imagePrameterName:(NSString *) imageName
                  imageData:(NSData *) imageData
              progressBlock:(void (^)(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite)) progressBlock
          completionHandler:(void (^)(AFHTTPRequestOperation *operation, NSError *error, id responseObject)) completion;
/**
 Creates an `AFHTTPRequestOperation` with a `POST` request, and enqueues it to the HTTP client's operation queue.
 
 @param path The path to be appended to the HTTP client's base URL and used as the request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param success A block object to be executed when the request operation finishes successfully. This block has no return value and takes two arguments: the created request operation and the object created from the response data of request.
 @param failure A block object to be executed when the request operation finishes unsuccessfully, or that finishes successfully, but encountered an error while parsing the response data. This block has no return value and takes two arguments: the created request operation and the `NSError` object describing the network or parsing error that occurred.
 
 @see -HTTPRequestOperationWithRequest:success:failure:
 */

//new post session method
- (void)postSessionWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;


- (void)getSessionWithPath:(NSString *)path
         parameters:(NSDictionary *)parameters
            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
