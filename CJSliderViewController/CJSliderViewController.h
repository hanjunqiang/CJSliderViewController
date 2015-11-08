//
//  CJSliderViewController.h
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-5.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RadioButtons.h"
#import "RadioControllers.h"

@interface CJSliderViewController : UIViewController<UIScrollViewDelegate, RadioButtonsSliderDelegate, RadioControllersDelegate>{
    NSArray *radioButtonNames;
    NSString *radioButtonNidName;
    
    NSArray *radioControllers;
    
    NSInteger selectIndex;
}
@property (strong,nonatomic) IBOutlet RadioButtons *radioButtons;
@property (strong,nonatomic) IBOutlet RadioControllers *radioCons;


//子类必须继承的方法
- (void)initizile;
- (void)doSomethingToCon_whereIndex:(NSInteger)index;

@end
