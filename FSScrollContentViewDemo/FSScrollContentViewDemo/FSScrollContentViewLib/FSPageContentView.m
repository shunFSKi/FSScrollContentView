//
//  FSPageContentView.m
//  Huim
//
//  Created by huim on 2017/4/28.
//  Copyright © 2017年 huim. All rights reserved.
//

#import "FSPageContentView.h"

static NSString *collectionCellIdentifier = @"collectionCellIdentifier";

@interface FSPageContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, strong) NSArray *childsVCs;
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat startOffsetX;
@property (nonatomic, assign) BOOL isSelectBtn;

@end

@implementation FSPageContentView

- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<FSPageContentViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        self.parentVC = parentVC;
        self.childsVCs = childVCs;
        self.delegate = delegate;
        
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark --LazyLoad

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionCellIdentifier];
        _collectionView = collectionView;
    }
    return _collectionView;
}

#pragma mark --setup
- (void)setupSubViews
{
    _startOffsetX = 0;
    _isSelectBtn = NO;
    
    for (UIViewController *childVC in self.childsVCs) {
        [self.parentVC addChildViewController:childVC];
    }
    [self addSubview:self.collectionView];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.childsVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellIdentifier forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIViewController *childVC = self.childsVCs[indexPath.item];
    childVC.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVC.view];
    return cell;
}

#pragma mark UIScrollView

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isSelectBtn = NO;
    _startOffsetX = scrollView.contentOffset.x;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(FSContentViewWillBeginDragging:)]) {
        [self.delegate FSContentViewWillBeginDragging:self];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_isSelectBtn) {
        return;
    }
    CGFloat scrollView_W = scrollView.bounds.size.width;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX/scrollView_W);
    NSInteger endIndex;
    CGFloat progress;
    if (currentOffsetX > _startOffsetX) {
        progress = (currentOffsetX - _startOffsetX)/scrollView_W;
        endIndex = startIndex + 1;
        if (endIndex > self.childsVCs.count - 1) {
            endIndex = self.childsVCs.count - 1;
        }
    }else if (currentOffsetX == _startOffsetX){
        progress = 0;
        endIndex = startIndex;
    }else{
        progress = (_startOffsetX - currentOffsetX)/scrollView_W;
        endIndex = startIndex - 1;
        endIndex = endIndex < 0?0:endIndex;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(FSContentViewDidScroll:startIndex:endIndex:progress:)]) {
        [self.delegate FSContentViewDidScroll:self startIndex:startIndex endIndex:endIndex progress:progress];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat scrollView_W = scrollView.bounds.size.width;
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    NSInteger startIndex = floor(_startOffsetX/scrollView_W);
    NSInteger endIndex = floor(currentOffsetX/scrollView_W);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(FSContenViewDidEndDecelerating:startIndex:endIndex:)]) {
        [self.delegate FSContenViewDidEndDecelerating:self startIndex:startIndex endIndex:endIndex];
    }
}

#pragma mark setter

- (void)setContentViewCurrentIndex:(NSInteger)contentViewCurrentIndex
{
    if (_contentViewCurrentIndex < 0||_contentViewCurrentIndex > self.childsVCs.count-1) {
        return;
    }
    _isSelectBtn = YES;
    _contentViewCurrentIndex = contentViewCurrentIndex;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:contentViewCurrentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

@end
