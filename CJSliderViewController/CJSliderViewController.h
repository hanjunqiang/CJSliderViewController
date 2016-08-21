//
//  CJSliderViewController.h
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-5.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <RadioButtons/RadioButtons_Slider.h>
#import "RadioControllers.h"

//@class CJSliderViewController;
//@protocol CJSliderViewControllerDataSoure <NSObject>
//
///**
// *  获取CJSliderViewController控制器的数据源radioControllers
// *
// *  @param sliderViewController 控制器
// *
// *  @return 数据源
// */
//- (NSArray <UIViewController *> *)radioControllersForCJSliderViewController:(CJSliderViewController *)sliderViewController;
//
//@end


/**
 *  能够左右滑动的视图控制器
 */
@interface CJSliderViewController : UIViewController<UIScrollViewDelegate, RadioButtonsDelegate, RadioControllersDelegate>{
    NSArray *radioButtonNames;
    NSString *radioButtonNidName;
    NSMutableArray *radioControllers;
    
    NSInteger selectIndex;
}
//@property (nonatomic, assign) id <CJSliderViewControllerDataSoure> delegate;
@property (nonatomic, strong) IBOutlet RadioButtons_Slider *radioButtons;
@property (nonatomic, strong) IBOutlet RadioControllers *radioCons;


- (void)removeAllViews_CJSliderVC;
- (void)initizileView_CJSliderVC;

//子类必须继承的方法
- (void)doSomethingToCon_whereIndex:(NSInteger)index;

@end
