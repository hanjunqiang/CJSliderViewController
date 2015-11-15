//
//  ViewController.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 15/11/8.
//  Copyright © 2015年 lichq. All rights reserved.
//

#import "ViewController.h"
#import <RadioButtons/RadioButtons_Slider.h>

@interface ViewController ()<RadioButtonsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    RadioButtons_Slider *rb_slider = [[RadioButtons_Slider alloc]initWithFrame:CGRectMake(0, 100, 320, 40)];
    NSArray *radioButtonNames =  @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    [rb_slider setTitles:radioButtonNames radioButtonNidName:@"RadioButton_Slider" andShowIndex:4];
    [rb_slider setDelegate:self];
    [self.view addSubview:rb_slider];
}

- (void)radioButtons:(RadioButtons_Slider *)radioButtons chooseIndex:(NSInteger)index_cur oldIndex:(NSInteger)index_old{
    NSLog(@"当前选择的是%d", index_cur);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
