//
//  NetworkTool.h
//  LoessSlopeCommunity
//
//  Created by huangwu on 2017/10/19.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@class AFHTTPSessionManager;

@interface NetworkTool : NSObject
+(instancetype)shareNetworkTool;
-(void)getWithUrlStr:(NSString *)urlStr success:(void(^)(id response))success fail:(void(^)(NSError *err))err;
-(void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary*)parametersDic success:(void(^)(id response))success fail:(void(^)(NSError *err))err;
-(void)uploadImagesWithDic:(NSDictionary*)dic urlString:(NSString*)url imageDatas:(NSArray*)imageAr success:(void(^)(id  response))success fail:(void(^)(NSError *err))err;
-(void)uploadFileWithDic:(NSDictionary*)dic urlString:(NSString*)url uploadData:(NSData*)data   fileName:(NSString*)fileName success:(void(^)(id response))success failure:(void(^)(NSError* err))err;
-(void)postWithCustomUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parametersDic success:(void(^)(id response))success fail:(void(^)(NSError *err))err;
-(void)cancelLastRequest;
-(void)postBodyWithUrl:(NSString *)urlString parameters:(NSDictionary *)parametersDic success:(void(^)(id response))success fail:(void(^)(NSError *err))err;
-(AFHTTPSessionManager*)networkManager;

@end
