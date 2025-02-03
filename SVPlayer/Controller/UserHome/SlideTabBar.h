//
//  SlideTabBar.h
//  SVPlayer
//
//  Created by weibin on 2025/2/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SlideTabBar : UIView

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex;

@end

NS_ASSUME_NONNULL_END
