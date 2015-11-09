//
//  RadioButtons.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 14-11-13.
//  Copyright (c) 2014年 lichq. All rights reserved.
//

#import "RadioButtons.h"

#define RadioButton_TAG_BEGIN   1000

@interface RadioButtons() {
    NSInteger _index;
    UIButton *btnArrowL;
    UIButton *btnArrowR;
}

@end





@implementation RadioButtons
@synthesize sv;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



- (void)awakeFromNib{
#pragma mark - 当scrollView位于第一个子视图时，其会对内容自动调整。如果你不想让scrollView的内容自动调整，可采取如下两种方法中的任一一种(这里采用第一种)。方法一：取消添加lab，以使得scrollView不是第一个子视图，从而达到取消scrollView的自动调整效果方法二：automaticallyAdjustsScrollViewInsets：如果你不想让scrollView的内容自动调整，将这个属性设为NO（默认值YES）。详细情况可参考evernote笔记中的UIStatusBar笔记内容
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectZero];
    [self addSubview:lab];
    
    [self addScrollViewForTab];
}


- (void)addScrollViewForTab{
    sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    sv.showsVerticalScrollIndicator = NO;
    sv.showsHorizontalScrollIndicator = NO;
    sv.delegate = self;
    sv.bounces = NO;
    sv.backgroundColor = [UIColor orangeColor];

    
    [self addSubview:sv];
}


//添加左右滑动箭头
- (void)addArrowImage_Left:(UIImage *)imageLeft Right:(UIImage *)imageRight{
    //创建左滑动箭头
    btnArrowL = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnArrowL setFrame:CGRectMake(0, 0, imageLeft.size.width, imageLeft.size.height)];
    [btnArrowL setCenter:CGPointMake(btnArrowL.frame.size.width/2,self.frame.size.height/2)];
    [btnArrowL setBackgroundImage:imageLeft forState:UIControlStateNormal];
    [btnArrowL addTarget:self action:@selector(btnArrowLAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnArrowL];
    
    //创建右滑动箭头
    btnArrowR = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnArrowR setFrame:CGRectMake(0, 0, imageRight.size.width, imageRight.size.height)];
    [btnArrowR setCenter:CGPointMake(self.frame.size.width - btnArrowR.frame.size.width/2, self.frame.size.height/2)];
    [btnArrowR setBackgroundImage:imageRight forState:UIControlStateNormal];
    [btnArrowR addTarget:self action:@selector(btnArrowRAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnArrowR];
    
    
    //刚开始隐藏左箭头，显示右箭头
    btnArrowL.hidden = YES;
    btnArrowR.hidden = NO;
}


#pragma mark - 箭头点击事件
- (void)btnArrowLAction:(UIButton *)btn{
    CGFloat leftX = sv.contentOffset.x;
    NSInteger tempDx = self.frame.size.width;
    RadioButton *targetItem = nil;
    for (int i = 0; i < sectionNum; i++) {
        RadioButton *radioButton = (RadioButton *)[self viewWithTag:RadioButton_TAG_BEGIN + i];
        
        NSInteger maxX = MAX(leftX, CGRectGetMaxX(radioButton.frame));
        NSInteger minX = MIN(leftX, CGRectGetMaxX(radioButton.frame));
        if (maxX - minX < tempDx) {
            tempDx = maxX - minX;
            targetItem = radioButton;
        }
    }
    [self showSelectItem:targetItem];
}

- (void)btnArrowRAction:(UIButton *)btn{
    CGFloat rightX = sv.contentOffset.x + sv.frame.size.width;
    NSInteger tempDx = self.frame.size.width;
    RadioButton *targetItem = nil;
    for (int i = 0; i < sectionNum; i++) {
        RadioButton *radioButton = (RadioButton *)[self viewWithTag:RadioButton_TAG_BEGIN + i];
        NSInteger maxX = MAX(rightX, CGRectGetMinX(radioButton.frame));
        NSInteger minX = MIN(rightX, CGRectGetMinX(radioButton.frame));
        if (maxX - minX < tempDx) {
            tempDx = maxX - minX;
            targetItem = radioButton;
        }
    }
    [self showSelectItem:targetItem];
}

#pragma mark - Item按钮点击事件
- (void)radioButtonClick:(RadioButton *)radioButton_cur{
    NSInteger section = radioButton_cur.tag - RadioButton_TAG_BEGIN;
    
    if (currentExtendSection == section) {
        //do nothing...
    }else{
        if (currentExtendSection != -1) {//存在的话，就先消除旧的。（不存在的可能①第一次点击;②点击后又隐藏）
            //不是之前点击的radioButton的时候,除了要把现有的按钮方向改变外，还需要把之前的那个按钮的方向也再改变掉。
            RadioButton *radioButton_old = (RadioButton *)[self viewWithTag:RadioButton_TAG_BEGIN + currentExtendSection];
            radioButton_old.selected = !radioButton_old.selected;
        }
        
        radioButton_cur.selected = !radioButton_cur.selected;
        
        currentExtendSection = section;
        
        if([self.delegate respondsToSelector:@selector(radioButtons_slider:chooseIndex:)]){
            [self.delegate radioButtons_slider:self chooseIndex:section];
        }
    }
}



//将隐藏Tab滑动显示
- (void)showSelectItem:(RadioButton *)item{
    
#pragma mark 移动方法①
    /*
    //该item与320宽的边缘的距离计算。
    CGFloat leftX = CGRectGetMinX(item.frame) - sv.contentOffset.x;
    CGFloat rightX = CGRectGetMaxX(item.frame) - sv.contentOffset.x;
    
    if (leftX < btnArrowL.frame.size.width) {
        //如果左边的边缘 < 左箭头的宽，则进行滚出来显示出完整的这个item.
        CGFloat contentX = item.frame.origin.x - btnArrowL.frame.size.width;
        CGRect frame = CGRectMake(contentX, 0, item.frame.size.width, item.frame.size.height);
        
        [self.sv scrollRectToVisible:frame animated:YES];//滚动到显示出整个rect
        
    }else if(rightX > btnArrowR.frame.origin.x){
        //如果右的边缘 > 右箭头的宽，则进行滚回来显示出完整的这个item.
        CGFloat contentX = item.frame.origin.x + btnArrowR.frame.size.width;
        CGRect frame = CGRectMake(contentX, 0, item.frame.size.width, item.frame.size.height);
        
        [self.sv scrollRectToVisible:frame animated:YES];//滚动到显示出整个rect
    }
    */
    
    
#pragma mark 移动方法②
    //该item的距离计算。
    //CGFloat leftX = CGRectGetMinX(item.frame);
    CGFloat rightX = CGRectGetMaxX(item.frame);
    
    if (rightX >= self.frame.size.width - 60) { //如果rightX离self.frame边缘太近(小于40)就要移动,设移动距离为moveOffset
        CGFloat moveOffset = self.frame.size.width/2 + 40;
        CGFloat rightX_new;
        
        if (rightX + moveOffset >= self.sv.contentSize.width) {//如果向左移动moveOffset后，会超出边界，则移动到末尾
            moveOffset = self.frame.size.width;
            rightX_new = self.sv.contentSize.width - moveOffset;
            
            [self.sv setContentOffset:CGPointMake(rightX_new, self.sv.contentOffset.y) animated:YES];
        }else{
            
            rightX_new = rightX - moveOffset;
            
            if (rightX_new > 0) {
                [self.sv setContentOffset:CGPointMake(rightX_new, self.sv.contentOffset.y) animated:YES];
            }
        }
        
    }else{
        [self.sv setContentOffset:CGPointMake(0, self.sv.contentOffset.y) animated:YES];
    }
}




- (void)setTabBarItemTitles:(NSArray *)titles itemNidName:(NSString *)nibName{
    [self setTabBarItemTitles:titles itemNidName:nibName andShowIndex:0];
}

- (void)setTabBarItemTitles:(NSArray *)titles itemNidName:(NSString *)nibName andShowIndex:(NSInteger)showIndex{

    
    
    sectionNum = [titles count];
    if (sectionNum == 0) {
        NSLog(@"error: [titles count] == 0");
    }
    
    
    //初始化默认显示view
    NSArray *array = [[NSBundle mainBundle]loadNibNamed:nibName owner:nil options:nil];
    RadioButton *radioButtonTemp = [array lastObject];
    CGFloat sectionWidth = radioButtonTemp.frame.size.width;
    if (sectionWidth * sectionNum < self.frame.size.width) {
        NSLog(@"error：xib中取得的RadioButton宽度太小，重新调整。现先暂时使用平分");
        sectionWidth = self.frame.size.width/sectionNum;
    }
    sv.contentSize = CGSizeMake(sectionWidth * sectionNum, self.frame.size.height);
    
    
    currentExtendSection = -1;
    for (int i = 0; i <sectionNum; i++) {
        CGRect rect_radioButton = CGRectMake(sectionWidth*i, 0, sectionWidth, self.frame.size.height);
        //radioButton初始化方法①
        //RadioButton *radioButton = [[RadioButton alloc]initWithFrame:rect_radioButton];
        //radioButton初始化方法②
        RadioButton *radioButton = [[RadioButton alloc]initWithNibNamed:nibName frame:rect_radioButton];
        if (i == showIndex) {
            [radioButton setSelected:YES];
            currentExtendSection = showIndex;
            
            [self showSelectItem:radioButton];
        }else{
            [radioButton setSelected:NO];
        }
        
        [radioButton setTitle:titles[i]];
        radioButton.delegate = self;
        radioButton.tag = RadioButton_TAG_BEGIN + i;
        [sv addSubview:radioButton];
        
        //分割线
        
        if (i<sectionNum && i != 0) {
            CGRect rect_line = CGRectMake(sectionWidth*i, 5, 1, self.frame.size.height - 10);
            UIView *lineView = [[UIView alloc] initWithFrame:rect_line];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [sv addSubview:lineView];
        }
        /*
        if (1) {
            NSString *title = titles[i];
            UIFont *font = radioButton.btn.titleLabel.font;
            CGSize constrainedToSize = CGSizeMake(radioButton.frame.size.width, radioButton.frame.size.height);
            CGSize textSize = [title sizeWithFont:font constrainedToSize:constrainedToSize lineBreakMode:NSLineBreakByTruncatingTail];
            
            UIImage *shadowImage = [UIImage imageNamed:@"btn_BG_selected@2x"];
            CGRect rect_shadowImageV = CGRectMake(0, 0, textSize.width+5, shadowImage.size.height);
            UIImageView *shadowImageV = [[UIImageView alloc] initWithFrame:rect_shadowImageV];
            [shadowImageV setCenter:CGPointMake(i*sectionWidth +sectionWidth/2, radioButton.frame.size.height/2)];
            shadowImageV.image = shadowImage;
            [radioButton addSubview:shadowImageV];
            [radioButton bringSubviewToFront:radioButton.lab];
        }
        */
    }
}


- (void)selectRadioButtonIndex:(NSInteger)index{
    RadioButton *radioButton_old = (RadioButton *)[self viewWithTag:RadioButton_TAG_BEGIN + currentExtendSection];
    radioButton_old.selected = NO;
    
    RadioButton *radioButton_cur = (RadioButton *)[self viewWithTag:RadioButton_TAG_BEGIN + index];
    radioButton_cur.selected = YES;
    [self showSelectItem:radioButton_cur];
    
    currentExtendSection = index;
}



#pragma mark - UIScrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        btnArrowL.hidden = YES;
        btnArrowR.hidden = NO;
    }else if (scrollView.contentOffset.x+scrollView.frame.size.width == scrollView.contentSize.width) {
        btnArrowL.hidden = NO;
        btnArrowR.hidden = YES;
    }else {
        btnArrowL.hidden = NO;
        btnArrowR.hidden = NO;
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
