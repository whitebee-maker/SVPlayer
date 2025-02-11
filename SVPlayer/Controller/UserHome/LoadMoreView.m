//
//  LoadMore.m
//  SVPlayer
//
//  Created by king on 2025/2/10.
//

#import "LoadMoreView.h"

@interface LoadMoreView()

@property(nonatomic, strong) UILabel                 *label;
@property(nonatomic, assign) LoadingType             curLoadType;


@end

@implementation LoadMoreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.zPosition = -1;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _label.text = @"Loading...";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    _label.backgroundColor = [UIColor clearColor];
    [self addSubview:_label];
}

- (void)setLoadState:(LoadingType)loadState {
    _curLoadType = loadState;
    if (_curLoadType == LoadStateLoading) {
        self.hidden = NO;
    } else if (_curLoadType == LoadStateEnd) {
        self.hidden = YES;
    }
}

@end
