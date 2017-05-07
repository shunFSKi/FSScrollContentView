//
//  ViewController.m
//  FSScrollContentViewDemo
//
//  Created by huim on 2017/5/3.
//  Copyright © 2017年 fengshun. All rights reserved.
//

#import "ViewController.h"
#import "FSScrollContentView.h"
#import "TestViewController.h"

@interface ViewController ()<FSPageContentViewDelegate,FSSegmentTitleViewDelegate>
@property (nonatomic, strong) FSPageContentView *pageContentView;
@property (nonatomic, strong) FSSegmentTitleView *titleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //demo1
    self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"] delegate:self indicatorType:0];
    self.titleView.indicatorColor = [UIColor blueColor];
    [self.view addSubview:_titleView];
    self.titleView.backgroundColor = [UIColor lightGrayColor];
    //demo2
    FSSegmentTitleView *titleView2 = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 124, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"] delegate:nil indicatorType:0];
    [self.view addSubview:titleView2];
    titleView2.backgroundColor = [UIColor lightGrayColor];
    //demo3
    FSSegmentTitleView *titleView3 = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 194, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"] delegate:nil indicatorType:2];
    titleView3.indicatorExtension = 6;
    [self.view addSubview:titleView3];
    titleView3.backgroundColor = [UIColor lightGrayColor];
    //demo4
    FSSegmentTitleView *titleView4 = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 264, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"] delegate:nil indicatorType:3];
    [self.view addSubview:titleView4];
    titleView4.backgroundColor = [UIColor lightGrayColor];
    
    //demo5
    FSSegmentTitleView *titleView5 = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 334, CGRectGetWidth(self.view.bounds), 50) titles:@[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"] delegate:nil indicatorType:3];
    titleView5.titleSelectFont = [UIFont systemFontOfSize:20];
    [self.view addSubview:titleView5];
    titleView5.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blackColor];
    [btn setTitle:@"pageContentView" forState:UIControlStateNormal];
    btn.frame = CGRectMake(50, 400, 50, 30);
    [btn sizeToFit];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

- (void)click
{
    TestViewController *vc = [[TestViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}





@end
