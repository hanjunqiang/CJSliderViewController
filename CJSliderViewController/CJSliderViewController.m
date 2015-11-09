//
//  CJSliderViewController.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-5.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "CJSliderViewController.h"

@interface CJSliderViewController (){
    
}

@end

@implementation CJSliderViewController
@synthesize radioCons;
@synthesize radioButtons;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}





#pragma mark - 显示radioButtons
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self initizileView];
}


- (void)removeAllViews{
    for (UIView *view in self.radioCons.views) {
        [view removeFromSuperview];
    }
    [self.radioCons.views removeAllObjects];
    
    //    for (UIView *view in self.radioButtons.sv.subviews) {
    //        if ([view isKindOfClass:[UIButton class]]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    for (UIView *view in self.radioButtons.subviews) {
        [view removeFromSuperview];
    }
    self.radioButtons.delegate = nil;
    
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
}

- (void)initizileView{
    if (self.radioCons.views.count == 0) {
        NSMutableArray *views = [[NSMutableArray alloc] init];
        for (UIViewController *vc in radioControllers) {
            [views addObject:vc.view];
            [self addChildViewController:vc];//记得添加进去
        }
//        [self.radioCons setScrollViews:views];
        [self.radioCons setScrollViews:views andShowIndex:selectIndex];
        [self.radioCons setDelegate:self];
    }
    
    
    if (self.radioButtons.delegate == nil) {
//        [self.radioButtons setTabBarItemTitles:radioButtonNames itemNidName:radioButtonNidName];
        [self.radioButtons setTabBarItemTitles:radioButtonNames itemNidName:radioButtonNidName andShowIndex:selectIndex];
        
        /*
        //添加左右滑动箭头
        UIImage *imageLeft = [UIImage imageNamed:@"arrowLeft"];
        UIImage *imageRight = [UIImage imageNamed:@"arrowRight"];
        [self.radioButtons addArrowImage_Left:imageLeft Right:imageRight];
        */
        
        [self.radioButtons setDelegate:self];
    }
    
    //已在上面通过andShowIndex来控制了。
//    [self.radioButtons selectRadioButtonIndex:selectIndex];
//    [self.radioCons selectIndex:selectIndex];
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    
}


//- (BOOL)automaticallyAdjustsScrollViewInsets{
//    return NO;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.edgesForExtendedLayout = UIRectEdgeAll;//(默认)
    [self initizileData];
}


#pragma mark - RadioButtonsDelegate
- (void)radioButtons_slider:(RadioButtons *)radioButtons_slider chooseIndex:(NSInteger)index{
    [self.radioCons selectIndex:index];
    selectIndex = index;
    
    [self doSomethingToCon_whereIndex:index];//一般是做一些额外的，比如“强制刷新”的操作
}

#pragma mark - RadioControllersDelegate
- (void)conSlideViewDidChangeToIndex:(NSInteger)index{
    [self.radioButtons selectRadioButtonIndex:index];
    selectIndex = index;
    
    [self doSomethingToCon_whereIndex:index];//一般是做一些额外的，比如“强制刷新”的操作
}


#pragma mark - 子类必须继承的方法
- (void)initizile{
    
}

- (void)doSomethingToCon_whereIndex:(NSInteger)index{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
