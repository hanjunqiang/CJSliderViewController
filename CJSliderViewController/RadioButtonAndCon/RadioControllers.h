//
//  RadioControllers.h
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-12.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RadioControllersDelegate <NSObject>

/**
 *  在conSlideView上改变选中的index
 *
 *  @param index
 */
- (void)conSlideViewDidChangeToIndex:(NSInteger)index;

@end




@interface RadioControllers : UIView<UIScrollViewDelegate>{
    UIScrollView *sv;
    NSInteger curIndex;
    NSInteger selIndex;
    
    UIView *_viewL;
    UIView *_viewC;
    UIView *_viewR;
}


@property (assign,nonatomic) id<RadioControllersDelegate> delegate;
@property (strong,nonatomic) NSMutableArray *views;

/**
 *  设置滚动视图的UIViewController的View,必须设置3个以上的视图。
 *
 *  @param views
 */
- (void)setScrollViews:(NSMutableArray *)views;
- (void)setScrollViews:(NSMutableArray *)views andShowIndex:(NSInteger)showIndex;


/**
 *  设置第几个Page被选中
 *
 *  @param index
 */
- (void)selectIndex:(NSInteger)index;

@end
