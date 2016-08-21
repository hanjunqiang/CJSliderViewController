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
    
    
    [self initizileView_CJSliderVC];
}


- (void)removeAllViews_CJSliderVC{
    for (UIView *view in self.radioCons.views) {
        [view removeFromSuperview];
    }
    [self.radioCons.views removeAllObjects];
    
    for (UIView *view in self.radioButtons.sv.subviews) {
        [view removeFromSuperview];
    }
    self.radioButtons.delegate = nil;
    
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
}

/**
 *  初始化数据（按钮和控制器）
 */
- (void)initizileData_CJSliderVC {
    /* 设置radioButtons */
    radioButtonNames = @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    radioButtonNidName = @"RadioButton_Slider";
    
    
    /* 设置radioControllers（黄橙相间） */
    radioControllers = [[NSMutableArray alloc] init];
    
    UIViewController *home1 = [[UIViewController alloc]init];
    home1.view.backgroundColor = [UIColor yellowColor];
    [radioControllers addObject:home1];
    
    UIViewController *home2 = [[UIViewController alloc]init];
    home2.view.backgroundColor = [UIColor orangeColor];
    [radioControllers addObject:home2];
    
    UIViewController *home3 = [[UIViewController alloc]init];
    home3.view.backgroundColor = [UIColor yellowColor];
    [radioControllers addObject:home3];
    
    UIViewController *home4 = [[UIViewController alloc]init];
    home4.view.backgroundColor = [UIColor orangeColor];
    [radioControllers addObject:home4];
    
    UIViewController *home5 = [[UIViewController alloc]init];
    home5.view.backgroundColor = [UIColor yellowColor];
    [radioControllers addObject:home5];
    
    UIViewController *home6 = [[UIViewController alloc]init];
    home6.view.backgroundColor = [UIColor orangeColor];
    [radioControllers addObject:home6];
    
    for (NSInteger i = 0; i < radioControllers.count; i++) {
        UIViewController *viewController = [radioControllers objectAtIndex:i];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
        label.backgroundColor = [UIColor cyanColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:40];
        label.text = [NSString stringWithFormat:@"This is home%zd", i+1];
        [viewController.view addSubview:label];
    }
}


- (void)initizileView_CJSliderVC{
//    [self initizileData_CJSliderVC];
    
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
        //[self.radioButtons setTitles:radioButtonNames radioButtonNidName:radioButtonNidName];
        [self.radioButtons setTitles:radioButtonNames radioButtonNidName:radioButtonNidName andShowIndex:selectIndex];
        
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
}


#pragma mark - RadioButtonsDelegate
- (void)radioButtons:(RadioButtons *)radioButtons chooseIndex:(NSInteger)index_cur oldIndex:(NSInteger)index_old{
    [self.radioCons showViewWithIndex:index_cur];
    selectIndex = index_cur;
    
    [self doSomethingToCon_whereIndex:index_cur];//一般是做一些额外的，比如“强制刷新”的操作
}

#pragma mark - RadioControllersDelegate
- (void)conSlideViewDidChangeToIndex:(NSInteger)index{
    [self.radioButtons selectRadioButtonIndex:index];
    selectIndex = index;
    
    [self doSomethingToCon_whereIndex:index];//一般是做一些额外的，比如“强制刷新”的操作
}


#pragma mark - 子类可选的继承方法
- (void)doSomethingToCon_whereIndex:(NSInteger)index{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
