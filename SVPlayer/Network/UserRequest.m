//
//  UserRequest.m
//  SVPlayer
//
//  Created by king on 2025/2/18.
//

#import "UserRequest.h"

#import "NetworkManager.h"

@implementation UserRequest

+ (void)getUserDataByUid:(NSString *)uid success:(void (^)(NSDictionary *responseData))success failure:(void (^)(NSError *error))failure {
    NetworkManager *networkMgr = [NetworkManager sharedInstance];
    [networkMgr GET:getUserByUidPath parameters:uid success:^(id responseObject) {
        if (success) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                success(responseObject);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
