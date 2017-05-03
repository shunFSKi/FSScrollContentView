//
//  FSSegmentTitleView.h
//  FSScrollContentViewDemo
//
//  Created by huim on 2017/5/3.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSSegmentTitleView;

typedef enum : NSUInteger {
    FSIndicatorTypeDefault,
    FSIndicatorTypeEqualTitle,
    FSIndicatorTypeCustom,
} FSIndicatorType;

@protocol FSSegmentTitleViewDelegate <NSObject>

@optional

- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endInex;

@end

@interface FSSegmentTitleView : UIView

@property (nonatomic, weak) id<FSSegmentTitleViewDelegate>delegate;

@property (nonatomic, strong) NSArray *titlesArr;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleNormalColor;

@property (nonatomic, strong) UIColor *titleSelectColor;

@property (nonatomic, strong) UIColor *indicatorColor;

@property (nonatomic, assign) CGFloat indicatorExtension;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<FSSegmentTitleViewDelegate>)delegate indicatorType:(FSIndicatorType)incatorType;

@end
