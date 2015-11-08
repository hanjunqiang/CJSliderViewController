//
//  RadioButtons.h
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-13.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"


@class RadioButtons;
@protocol RadioButtonsSliderDelegate <NSObject>

@optional
- (void)radioButtons_slider:(RadioButtons *)radioButtons_slider chooseIndex:(NSInteger)index;
@end






@interface RadioButtons : UIView<UIScrollViewDelegate, RadioButtonDelegate>{
    NSInteger currentExtendSection;//当前展开的section ，默认－1时，表示都没有展开
    NSInteger sectionNum;
}
@property (nonatomic, strong) UIScrollView *sv;
@property (nonatomic, strong) id<RadioButtonsSliderDelegate> delegate;

/**
 *  设置对应Tab名称
 *
 *  @param titles
 */
- (void)setTabBarItemTitles:(NSArray *)titles itemNidName:(NSString *)nibName;
- (void)addArrowImage_Left:(UIImage *)imageLeft Right:(UIImage *)imageRight;//添加左右滑动箭头

/**
 *  设置指定Index的Tab为选中状态
 *
 *  @param index
 */
- (void)selectRadioButtonIndex:(NSInteger)index;


@end
