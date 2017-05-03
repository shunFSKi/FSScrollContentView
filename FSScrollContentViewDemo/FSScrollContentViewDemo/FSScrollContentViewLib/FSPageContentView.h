//
//  FSPageContentView.h
//  Huim
//
//  Created by huim on 2017/4/28.
//  Copyright © 2017年 huim. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FSPageContentView;

@protocol FSPageContentViewDelegate <NSObject>

@optional

- (void)FSContentViewWillBeginDragging:(FSPageContentView *)contentView;

- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface FSPageContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<FSPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<FSPageContentViewDelegate>delegate;

@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

@end
