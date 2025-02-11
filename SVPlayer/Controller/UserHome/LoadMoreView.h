//
//  LoadMore.h
//  SVPlayer
//
//  Created by king on 2025/2/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LoadingType) {
    LoadStateLoading,
    LoadStateEnd
};


NS_ASSUME_NONNULL_BEGIN

@interface LoadMoreView : UIView

- (void)setLoadState:(LoadingType)state;

@end

NS_ASSUME_NONNULL_END
