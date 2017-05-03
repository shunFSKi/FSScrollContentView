//
//  ViewController.m
//  FSScrollContentViewDemo
//
//  Created by huim on 2017/5/3.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "ViewController.h"
#import "FSScrollContentView.h"
#import "ChildViewController.h"

@interface ViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 50) delegate:self indicatorType:FSIndicatorTypeCustom];
    self.titleView.titlesArr = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"];
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleView.titlesArr) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        vc.title = title;
        [childVCs addObject:vc];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 70, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:_pageContentView];
}


#pragma mark --
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endInex
{
    self.pageContentView.contentViewCurrentIndex = endInex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}


@end
