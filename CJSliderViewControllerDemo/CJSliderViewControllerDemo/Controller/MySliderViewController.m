//
//  MySliderViewController.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 15/11/3.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "MySliderViewController.h"


@interface MySliderViewController ()

@end

@implementation MySliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"首页", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(updateShowIndex)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"不切换" style:UIBarButtonItemStylePlain target:self action:@selector(no_updateShowIndex)];
    
    [self initizileData_CJSliderVC];
//    selectIndex = 1;
    selectIndex = 0;
}

- (void)no_updateShowIndex{
    selectIndex = 4;
    
    [self updateCon];
}

- (void)updateShowIndex{
    NSInteger oldIndex = selectIndex;
    while (selectIndex == oldIndex) {
        selectIndex = rand() % radioButtonNames.count;
    }
    NSLog(@"切换到第%zd个控制器", selectIndex+1);
    
    
    [self updateCon];
}


- (void)updateCon{
    [self removeAllViews_CJSliderVC];
    
    [self initizileData_CJSliderVC];
    if (selectIndex > radioButtonNames.count-1) {
        selectIndex = 0; //当前显示的index被删掉后，默认转为显示第一个
    }
    
    [self initizileView_CJSliderVC];
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


- (void)doSomethingToCon_whereIndex:(NSInteger)index{
    if (index == 0) {
//        Home1 *con = [self.childViewControllers objectAtIndex:index];
//        [con forceToRefreshData];
        
    }else if(index == 1){
//        Home2 *con = [self.childViewControllers objectAtIndex:index];
//        [con forceToRefreshData];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
