//
//  NetworkTool.m
//  LoessSlopeCommunity
//
//  Created by huangwu on 2017/10/19.
//  Copyright © 2017年 Neo. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"


@interface NetworkTool ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)AFHTTPSessionManager *XI_manager;


@end

static NetworkTool *tool;
@implementation NetworkTool

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    return [self shareNetworkTool];
}

+(instancetype)shareNetworkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[super allocWithZone:NULL] init];
    });
    return tool;
}
-(id)copyWithZone:(NSZone *)zone
{
    return [NetworkTool shareNetworkTool];
}

-(id)mutableCopyWithZone:(NSZone *)zone
{
    return [NetworkTool shareNetworkTool];
}
-(AFHTTPSessionManager *)XI_manager{
    
    static AFHTTPSessionManager *tempManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURLSessionConfiguration *con=[NSURLSessionConfiguration defaultSessionConfiguration];
        con.timeoutIntervalForRequest=30;
        
        tempManager=[[AFHTTPSessionManager alloc]initWithSessionConfiguration:con];
        //        //申明返回的结果是json类型
        tempManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //        //申明请求的数据是json类型
        tempManager.requestSerializer=[AFHTTPRequestSerializer serializer];

        [tempManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        tempManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",
                                                               @"text/html",
                                                               @"image/jpeg",
                                                               @"image/png",
                                                               @"application/octet-stream",
                                                               @"text/json",
                                                               @"text/plain",
                                                               nil];
    });
    
    return tempManager;
}
-(AFHTTPSessionManager *)manager{
    
    static AFHTTPSessionManager *tempManager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *con=[NSURLSessionConfiguration defaultSessionConfiguration];
        con.timeoutIntervalForRequest=30;
        
        tempManager=[[AFHTTPSessionManager alloc]initWithSessionConfiguration:con];
//        //申明返回的结果是json类型
        tempManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        //申明请求的数据是json类型
        tempManager.requestSerializer=[AFHTTPRequestSerializer serializer];
//        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//        [_manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        
        tempManager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",
                             @"text/html",
                             @"image/jpeg",
                             @"image/png",
                             @"application/octet-stream",
                             @"text/json",
                             @"text/plain",
                             nil];
        
    });
    return tempManager;
    
}

-(void)cancelLastRequest{
    
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

-(void)getWithUrlStr:(NSString *)urlStr success:(void (^)(id))success fail:(void (^)(NSError *))err{
    NSString *url=[NSString stringWithFormat:@"%@%@",urlFront,urlStr];

    [self.manager GET:url parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            err(error);
        }
    }];
    
    
}

-(void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parametersDic success:(void (^)(id))success fail:(void (^)(NSError *))err{
    
    NSString *url=[NSString stringWithFormat:@"%@%@",urlFront,urlStr];
    [self.manager POST:url parameters:parametersDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id  dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
           
            success(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            err(error);
        }
    }];
    
}

-(void)postWithCustomUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parametersDic success:(void (^)(id))success fail:(void (^)(NSError *))err{
    
    
    
    [self.manager POST:urlStr parameters:parametersDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            id  dic= [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            success(dic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            err(error);
        }
    }];
    
    
}

-(void)uploadImagesWithDic:(NSDictionary *)dic urlString:(NSString *)url imageDatas:(NSArray *)imageAr success:(void (^)(id))success fail:(void (^)(NSError *))err{
    NSString *urlstr=[NSString stringWithFormat:@"%@%@",urlFront,url];
    [self.manager POST:url parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imageAr.count; i++) {
            NSData *data=imageAr[i];
            
            if (imageAr.count==1) {
                [formData appendPartWithFileData:data name:@"file" fileName:@"123.jpeg" mimeType:@"image/jpeg"];
            }else{
                NSString *fileName=[NSString stringWithFormat:@"image%d.jpeg",i];
                [formData appendPartWithFileData:data name:@"files" fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            err(error);
        }
    }];
    
    
}
-(void)uploadFileWithDic:(NSDictionary *)dic urlString:(NSString *)url uploadData:(NSData *)data fileName:(NSString *)fileName success:(void (^)(id))success failure:(void (^)(NSError *))err {
    if (!url||!fileName||fileName.length==0) return;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",urlFront,url];
    [self.manager POST:url parameters:dic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"application/x-gzip"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            err(error);
        }
    }];
    
    
}

- (void)cancelHTTPOperationsWithMethod:(NSString *)method url:(NSString *)url
{
//    NSArray*taskAr = _manager.tasks;
}

-(AFHTTPSessionManager*)networkManager{
    return self.manager;
}
@end
