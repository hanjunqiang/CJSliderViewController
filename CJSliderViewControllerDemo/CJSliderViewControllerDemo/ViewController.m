//
//  ViewController.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 15/11/8.
//  Copyright © 2015年 lichq. All rights reserved.
//

#import "ViewController.h"
#import <RadioButtons/RadioButtons_Slider.h>

#import "UIScrollView+CJAddContentView.h"

@interface ViewController () <RadioButtonsDelegate, UIScrollViewDelegate> {
    UIScrollView *_scrollView;
    UIView *contentView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"首页", nil);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"滚动到指定位置" style:UIBarButtonItemStylePlain target:self action:@selector(scrollToPosition:)];
    
    
    
    RadioButtons_Slider *rb_slider = [[RadioButtons_Slider alloc]initWithFrame:CGRectMake(0, 100, 320, 40)];
    NSArray *radioButtonNames =  @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    [rb_slider setTitles:radioButtonNames radioButtonNidName:@"RadioButton_Slider" andShowIndex:4];
    [rb_slider setDelegate:self];
    [self.view addSubview:rb_slider];
    
    [self addScrollView];
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _scrollView.contentOffset = CGPointMake(100, 0);
}

- (void)radioButtons:(RadioButtons_Slider *)radioButtons chooseIndex:(NSInteger)index_cur oldIndex:(NSInteger)index_old{
    NSLog(@"当前选择的是%zd", index_cur);
    
}

- (void)addScrollView {
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    width = 100;
    height = 200;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.backgroundColor = [UIColor magentaColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = YES;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.bounces = YES;
    _scrollView.delegate = self;
    
    //scrollView采用三页显示(对于不是前一页，现在页，下一页的页面不加载)，以节省内存。所以contentSize为width*3，并滚动到现在页
//    [scrollView setContentSize:CGSizeMake((width)*3, height)];
//    [scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    
    //将UIScrollView添加到UIView控件中，并设置UIScrollView针对父视图UIView的constraints（Leading/trailling/top/bottom = 0）
    [self.view addSubview:_scrollView];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_scrollView
                                                   attribute:NSLayoutAttributeLeft
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                   attribute:NSLayoutAttributeLeft
                                                  multiplier:1
                                                    constant:10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_scrollView
                                                   attribute:NSLayoutAttributeRight
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                   attribute:NSLayoutAttributeRight
                                                  multiplier:1
                                                    constant:-10]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_scrollView
                                                   attribute:NSLayoutAttributeTop
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                   attribute:NSLayoutAttributeTop
                                                  multiplier:1
                                                    constant:70]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_scrollView
                                                   attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual
                                                      toItem:self.view
                                                   attribute:NSLayoutAttributeBottom
                                                  multiplier:1
                                                    constant:-10]];
    
    [self addContentViewToScrollView];//等价于 contentView = [scrollView cj_addContentViewWithWidthMultiplier:3 heightMultiplier:1];
    
    [self addLeftViewToScrollView];
    [self addRightViewToScrollView];
    
    //_scrollView.contentOffset = CGPointMake(100, 0);//滚动写在这里无效
}

#pragma mark - 滚动
- (IBAction)scrollToPosition:(id)sender {
    _scrollView.contentOffset = CGPointMake(100, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView.contentOffset.x  = %.1f", scrollView.contentOffset.x );
}


- (void)addContentViewToScrollView {
    contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = [UIColor lightGrayColor];
    
    [_scrollView addSubview:contentView];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    //left
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    //right
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeRight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1
                                                            constant:0]]; //right = 0;
    //top
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    //bottom(实际上这条是反向设置了scrollView的高)
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_scrollView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]]; //bottom = 0
    
    
    //设置container的width（这里我们暂时设置contentView为3被scrollView的宽）
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:3
                                                            constant:0]];
    //设置container的height
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0]];
}


//这里的view也可以直接添加到scrollView上新增的那个contentView上，但是由于我们这边需要设置view的宽高等于scrollView的宽高（而导致需要用到scrollView addConstraint:，NSLayoutAttributeWidth而不是contentView addConstraint:，NSLayoutAttributeWidth），而不是contentView的宽高，。所以我们这里统一将view添加到scrollView上就可以了。
- (void)addLeftViewToScrollView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor redColor];
    [contentView addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    /* width、height、top是不变的所以这里可以先写 */
    //width
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1
                                                            constant:0]];
    //height
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0]];
    //top
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:0]];
    /* 计算left要多少 */
    //left
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_scrollView
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1
                                                             constant:0]];
}

- (void)addRightViewToScrollView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    [contentView addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    /* width、height、top是不变的所以这里可以先写 */
    //width
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1
                                                            constant:0]];
    //height
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0]];
    //top
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                            attribute:NSLayoutAttributeTop
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:contentView
                                                            attribute:NSLayoutAttributeTop
                                                           multiplier:1
                                                             constant:0]];
    /* 计算left要多少 */
    //left
    CGFloat scrollViewWidth = CGRectGetWidth(_scrollView.frame);
    NSLog(@"scrollViewWidth = %.1f", scrollViewWidth);
    scrollViewWidth = 375;
    
    [_scrollView addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:_scrollView
                                                           attribute:NSLayoutAttributeLeft
                                                          multiplier:1
                                                            constant:scrollViewWidth]];
    
//    [NSLayoutConstraint layou]
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
