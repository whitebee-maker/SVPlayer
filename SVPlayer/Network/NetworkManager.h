//
//  NetworkManager.h
//  SVPlayer
//
//  Created by king on 2025/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSString *const baseUrl = @"";
NSString *const getUserByUidPath = @"";


@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;

- (void)GET:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

- (void)POST:(NSString *)urlStr parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end

NS_ASSUME_NONNULL_END
