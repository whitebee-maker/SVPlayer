//
//  NetworkManager.m
//  SVPlayer
//
//  Created by king on 2025/2/18.
//

#import "NetworkManager.h"

#import "AFNetworking.h"

@interface NetworkManager()

@property(nonatomic, strong)AFHTTPSessionManager *sessionMangaer;

@end

@implementation NetworkManager

+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionMangaer = [AFHTTPSessionManager manager];
    }
    return self;
}

- (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [_sessionMangaer GET:urlStr parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)POST:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [_sessionMangaer POST:urlStr parameters:parameters headers:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
