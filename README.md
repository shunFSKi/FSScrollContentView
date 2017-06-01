# FSScrollContentView

![badge-languages](https://img.shields.io/badge/language-ObjC-orange.svg) ![badge-platforms](https://img.shields.io/badge/platforms-iOS7-lightgrey.svg) [![Build Status](https://travis-ci.org/shunFSKi/FSScrollContentView.svg?branch=master)](https://travis-ci.org/shunFSKi/FSScrollContentView) [![CocoaPods](https://img.shields.io/cocoapods/v/FSScrollContentView.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/dt/FSScrollContentView.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/l/FSScrollContentView.svg)]()

简书：http://www.jianshu.com/p/34cecb066cc1

这是本人在整理项目时抽离了业务代码整理封装的一个通俗易懂较为实用的框架。
支持点击上方标题，切换下方内容页面，也支持滑动下方内容区域，切换上方的标题。
* 主要用来适用于多个视图左右滑动，切换顶部标签控制显示视图的需求
* 仿网易新闻，一些电商app的样式实现
* 实现简单，通俗易懂，支持一些简单的自定义
* 自动适应标签数量控制滑动或不能滑动
## 效果图
![几种类型的效果图](https://github.com/shunFSKi/ImageResources/blob/master/scrollContentView.gif)
## 使用方式
**1、cocoapods**

pod search FSScrollContentView 
如果找不到执行pod setup
pod 'FSScrollContentView'

**2、添加文件**

直接clone代码后将项目中的FSScrollContentViewLib文件夹导入自己项目中，导入FSScrollContentView.h头文件
## API使用说明
其实demo中有很详细的注释说明，通俗易懂
框架包含**FSPageContentView**和**FSSegmentTitleView**两个完全独立的类文件，可酌情使用

**FSPageContentView**

* 创建FSPageContentView
```
/**
 对象方法创建FSPageContentView

 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return FSPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<FSPageContentViewDelegate>)delegate;
```
* FSPageContentView属性修改
```
/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;
```
* FSPageContentView代理方法
```
/**
 FSPageContentView开始滑动

 @param contentView FSPageContentView
 */
- (void)FSContentViewWillBeginDragging:(FSPageContentView *)contentView;

/**
 FSPageContentView滑动调用

 @param contentView FSPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)FSContentViewDidScroll:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 FSPageContentView结束滑动

 @param contentView FSPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;
```
**FSSegmentTitleView**
* 创建FSSegmentTitleView
```
/**
 对象方法创建FSSegmentTitleView

 @param frame frame
 @param titlesArr 标题数组，必须传值
 @param delegate delegate
 @param incatorType 指示器类型
 @return FSSegmentTitleView
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr delegate:(id<FSSegmentTitleViewDelegate>)delegate indicatorType:(FSIndicatorType)incatorType;
```
* FSSegmentTitleView属性修改

~~/**
 标题数组，必须传值
 */
@property (nonatomic, strong) NSArray *titlesArr;~~**废弃/DEPRECATED_1.0.1**
```

/**
 标题文字间距，默认20
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 当前选中标题索引，默认0
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 标题字体大小，默认15
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题正常颜色，默认black
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 标题选中颜色，默认red
 */
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 指示器颜色，默认与titleSelectColor一样,在FSIndicatorTypeNone下无效
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 在FSIndicatorTypeCustom时可自定义此属性，为指示器一端延伸长度，默认5
 */
@property (nonatomic, assign) CGFloat indicatorExtension;
```
* FSSegmentTitleView代理方法
```
/**
 切换标题

 @param titleView FSSegmentTitleView
 @param startIndex 切换前标题索引
 @param endIndex 切换后标题索引
 */
- (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;
```
* FSSegmentTitleView枚举类型
```
typedef enum : NSUInteger {
    FSIndicatorTypeDefault,//默认与按钮长度相同
    FSIndicatorTypeEqualTitle,//与文字长度相同
    FSIndicatorTypeCustom,//自定义文字边缘延伸宽度
    FSIndicatorTypeNone,
} FSIndicatorType;//指示器类型枚举
```
## For example

详细使用可以查看demo
```
self.titleView = [[FSSegmentTitleView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50) delegate:self indicatorType:0];
    self.titleView.titlesArr = @[@"全部",@"服饰穿搭",@"生活百货",@"美食吃货",@"美容护理",@"母婴儿童",@"数码家电",@"其他"];
    [self.view addSubview:_titleView];
    
    NSMutableArray *childVCs = [[NSMutableArray alloc]init];
    for (NSString *title in self.titleView.titlesArr) {
        ChildViewController *vc = [[ChildViewController alloc]init];
        vc.title = title;
        [childVCs addObject:vc];
    }
    self.pageContentView = [[FSPageContentView alloc]initWithFrame:CGRectMake(0, 114, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 90) childVCs:childVCs parentVC:self delegate:self];
    [self.view addSubview:_pageContentView];
    
    - (void)FSSegmentTitleView:(FSSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.pageContentView.contentViewCurrentIndex = endIndex;
}

- (void)FSContenViewDidEndDecelerating:(FSPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex
{
    self.titleView.selectIndex = endIndex;
}
```
## 版本
* 2017.4.28 ——> **1.0**初始版本
* 2017.5.7 ——> **1.0.1**修改初始化方法，添加了标题选中自定义文字大小类型
## 后续
因为最近在重新整理整个项目，准备剔除之前项目的混乱代码，复杂的业务逻辑，将会不定期封装一些比较实用的小框架，目前上传的FSxxdemo都是我在重构项目过程中写的一些封装库，算是较为实用并且稳定的框架类，主要目的也是为了整理记录下来方便以后使用，这个滑动框架暂时样式较少，但是已经能够满足日常开发所用，后期我会抽时间增加更多的支持类型，比如放大选中的标题文字，增加图片类型等。每次更新都将在这里做备忘记录。———— 2017.5.4

修改初始化方法，添加了标题选中自定义文字大小类型 ———— 2017.5.7

修复iOS7下contentView无法加载的Bug，添加contentViewCanScroll属性可手动控制contentView能否滑动 ———— 2017.5.17

修复若干bug，添加cocoapods支持 ———— 2017.6.1

![](https://github.com/shunFSKi/ImageResources/blob/master/qrcode_for_gh_e49d866d2f7a_258.jpg)
