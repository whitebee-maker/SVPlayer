//
//  SlideTabBar.m
//  SVPlayer
//
//  Created by weibin on 2025/2/3.
//

#import "SlideTabBar.h"

@interface SlideTabBar()

@property (nonatomic, strong) UIView                    *slideLightView; // 黄色横条
@property(nonatomic, strong) NSMutableArray<UILabel *>  *labels;
@property(nonatomic, strong) NSMutableArray<NSString *> *titles;
@property(nonatomic, assign) NSInteger                  tabIndex;
@property(nonatomic, assign) CGFloat                    itemWidth;

@end

@implementation SlideTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _labels = [NSMutableArray array];
        _titles = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_titles.count == 0) {
        return;
    }
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *subView, NSUInteger idx, BOOL *stop) {
        [subView removeFromSuperview];
    }];
    [_labels removeAllObjects];
    
    CGFloat itemWidth = _itemWidth = ScreenWidth / _titles.count;
    [_titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL *stop) {
        UILabel *label = [[UILabel alloc] init];
        label.text = title;
        label.textColor = ColorWhiteAlpha60;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = BigFont;
        label.tag = idx;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapAction:)]];
        [_labels addObject:label];
        [self addSubview:label];
        label.frame = CGRectMake(idx * itemWidth, 0, itemWidth, self.bounds.size.height);
        if (idx != _titles.count - 1) {
            UIView *spliteLine = [[UIView alloc] initWithFrame:CGRectMake((idx+1)*itemWidth - 0.25f, 12.5f, 0.5f, self.bounds.size.height - 25.0f)];
            spliteLine.backgroundColor = [UIColor whiteColor];
            spliteLine.layer.zPosition = 10;
            [self addSubview:spliteLine];
        }
    }];
    _labels[_tabIndex].textColor = ColorWhite;
    
    _slideLightView = [[UIView alloc] init];
    _slideLightView.backgroundColor = ColorThemeYellow;
    _slideLightView.frame = CGRectMake(_tabIndex * itemWidth + 15, self.bounds.size.height-2, itemWidth - 30, 2);
    [self addSubview:_slideLightView];
}

- (void)setLabels:(NSArray<NSString *> *)titles tabIndex:(NSInteger)tabIndex {
    [_titles removeAllObjects];
    [_titles addObjectsFromArray:titles];
    _tabIndex = tabIndex;
}

// ==============================================================
#pragma mark - Actions
// ==============================================================

- (void)onTapAction:(UITapGestureRecognizer *)sender {
    NSInteger index = sender.view.tag;
    if (_delegate) {
        [UIView animateWithDuration:0.10
                              delay:0
             usingSpringWithDamping:0.8
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            CGRect frame = self.slideLightView.frame;
            frame.origin.x = self.itemWidth * index + 15;
            [self.slideLightView setFrame:frame];
            [self.labels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
                label.textColor = index == idx ? ColorWhite : ColorWhiteAlpha60;
            }];
        } completion:^(BOOL finished) {
            [self.delegate onSlideTabBarTapAction:index];
        }];
    }
}

@end
