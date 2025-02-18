//
//  UserRequest.h
//  SVPlayer
//
//  Created by king on 2025/2/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRequest : NSObject

+ (void)getUserDataByUid:(NSString *)uid success:(void (^)(NSDictionary *responseData))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
