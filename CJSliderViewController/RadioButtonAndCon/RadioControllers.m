//
//  RadioControllers.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-12.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "RadioControllers.h"

@implementation RadioControllers

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)awakeFromNib{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.clipsToBounds = YES;
    
    sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    sv.pagingEnabled = YES;
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.bounces = NO;
    sv.delegate = self;
    
    //scrollView采用三页显示(对于不是前一页，现在页，下一页的页面不加载)，以节省内存。所以contentSize为width*3，并滚动到现在页
    [sv setContentSize:CGSizeMake(width*3, height)];
    [sv scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    
    [self addSubview:sv];
}



- (void)setScrollViews:(NSMutableArray *)views {
    NSAssert(views.count >= 3, @"views min size 3");
    
    //调整View大小
    for (NSInteger i=0; i<views.count; i++) {
        UIView *view = views[i];
        CGRect frame = view.frame;
        frame.size.width = self.frame.size.width;
        frame.size.height = self.frame.size.height;
        view.frame = frame;
    }
    self.views = views;
    
    
    curIndex = -1;
    
    
    [self resetViewWithIndex:0];
}


- (void)resetViewWithIndex:(NSInteger)index {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (curIndex == index) {
        return;
    }
    curIndex = index;
    
    NSInteger totalCount = self.views.count;
    
    //取得下一个 左·中·右视图，分别是所有view中的哪几个
    NSInteger indexL = (index==0) ? totalCount-1:index-1;
    NSInteger indexC = curIndex;
    NSInteger indexR = (index==totalCount-1) ? 0:index+1;
    
    //设置 左·中·右视图
    _viewL = [self.views objectAtIndex:indexL];
    _viewC = [self.views objectAtIndex:indexC];
    _viewR = [self.views objectAtIndex:indexR];
    
    _viewL.center = CGPointMake(width/2, height/2);
    _viewC.center = CGPointMake(width+width/2, height/2);
    _viewR.center = CGPointMake(width*2+width/2, height/2);
    
    [sv addSubview:_viewL];
    [sv addSubview:_viewC];
    [sv addSubview:_viewR];
    
    //移除不显示视图
    for (NSInteger i=0; i<self.views.count; i++) {
        if (i != indexL && i != indexC && i != indexR) {
            UIView *view = self.views[i];
            [view removeFromSuperview];
        }
    }
    
    //滚动到 中间视图
    [sv scrollRectToVisible:_viewC.frame animated:NO];

    [self.delegate conSlideViewDidChangeToIndex:curIndex];
}

#pragma mark - 手动选择显示哪个viewController.view
- (void)selectIndex:(NSInteger)index{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    if (curIndex == index) {
        return;
    }
    NSInteger oldIndex = curIndex;
    selIndex = index;
    
    //移除不显示视图
    for (NSInteger i = 0; i < self.views.count; i++) {
        if (i != oldIndex && i != selIndex) {
            UIView *view = self.views[i];
            [view removeFromSuperview];
        }
    }
    //处理旧视图：将旧视图作为scrollView的中心视图进行设置
    UIView *centerView = [self.views objectAtIndex:oldIndex];
    centerView.center = CGPointMake(width+width/2, height/2);
    [sv addSubview:centerView];
    
    //添加新视图：将新视图添加到scrollView的相应位置上，并进行滚动到该位置(这样才有滚动动画)
    if (selIndex < oldIndex || (oldIndex==0 && selIndex == self.views.count-1)) {
        //目标视图位于左侧的情况
        UIView *selView = [self.views objectAtIndex:selIndex];
        selView.center = CGPointMake(width/2, height/2);
        [sv addSubview:selView];
        
        [sv scrollRectToVisible:selView.frame animated:YES];
    }else if(selIndex > oldIndex || (oldIndex==self.views.count-1 && selIndex==0)){
        //目标视图位于右侧的情况
        UIView *selView = [self.views objectAtIndex:selIndex];
        selView.center = CGPointMake(width*2+width/2, height/2);
        [sv addSubview:selView];
        
        [sv scrollRectToVisible:selView.frame animated:YES];
    }
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    NSInteger index = curIndex;
    
    //由于我们这里使用的是只加载当前页及当前页的前后两页来显示的方式，以减少内存方式，所以当我们拖动到不是所加载的这几页时，比如拖动到当前页的前两页时，就会由于之前没有加载，而显示空内容(尤其是当我们拖动的距离超过一页的时候)。所以，为了避免出现拖动过程中出现空内容的view，所以我们在拖动过程中随时检查并设置它的上下视图
    //两个视图情况下的View检查
    if (scrollView.contentOffset.x < scrollView.frame.size.width) {
        //左侧视图检查]
        if (index == 0) {
            index = self.views.count-1;
        }else{
            index--;
        }
        _viewL = [self.views objectAtIndex:index];
        _viewL.center = CGPointMake(width/2, height/2);
    }else if(scrollView.contentOffset.x > scrollView.frame.size.width) {
        //右侧视图检查
        if (index==self.views.count-1) {
            index = 0;
        }else {
            index++;
        }
        _viewR = [self.views objectAtIndex:index];
        _viewR.center = CGPointMake(width*2+width/2, height/2);
    }
}


//[sv scrollRectToVisible:selView.frame animated:YES];的时候调用，目的是为了让视图的切换有动画效果。
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self resetViewWithIndex:selIndex];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x <= 0) {                                 //滚动到前一页
        NSInteger nextIndex = (curIndex==0) ? self.views.count-1 : curIndex-1;
        [self resetViewWithIndex:nextIndex];
        
    }else if(scrollView.contentOffset.x >= scrollView.frame.size.width*2) {//滚动到后一页
        NSInteger nextIndex = (curIndex==self.views.count-1) ? 0 : curIndex+1;
        [self resetViewWithIndex:nextIndex];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
