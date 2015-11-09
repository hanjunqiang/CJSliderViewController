//
//  MySliderViewController.m
//  CJSliderViewControllerDemo
//
//  Created by lichq on 15/11/3.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "MySliderViewController.h"

//#import "Home1.h"
//#import "Home2.h"
//#import "Home3.h"
//#import "Home4.h"
//#import "Home5.h"
//#import "Home6.h"



@interface MySliderViewController ()

@end

@implementation MySliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"首页", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(updateShowIndex)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"不切换" style:UIBarButtonItemStylePlain target:self action:@selector(no_updateShowIndex)];
    
    selectIndex = 1;
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
    NSLog(@"切换到第%d个控制器", selectIndex+1);
    
    
    [self updateCon];
}


- (void)updateCon{
    [self removeAllViews];
    [self initizileView];
}




- (void)initizileData{
//    UIStoryboard *sboard_home = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
//    Home1 *home1 = [sboard_home instantiateViewControllerWithIdentifier:@"Home1"];
//    Home2 *home2 = [sboard_home instantiateViewControllerWithIdentifier:@"Home2"];
//    Home3 *home3 = [sboard_home instantiateViewControllerWithIdentifier:@"Home3"];
//    Home4 *home4 = [sboard_home instantiateViewControllerWithIdentifier:@"Home4"];
//    Home5 *home5 = [sboard_home instantiateViewControllerWithIdentifier:@"Home5"];
//    Home6 *home6 = [sboard_home instantiateViewControllerWithIdentifier:@"Home6"];
    UIViewController *home1 = [[UIViewController alloc]init];
    UIViewController *home2 = [[UIViewController alloc]init];
    UIViewController *home3 = [[UIViewController alloc]init];
    UIViewController *home4 = [[UIViewController alloc]init];
    UIViewController *home5 = [[UIViewController alloc]init];
    UIViewController *home6 = [[UIViewController alloc]init];
    radioControllers = @[home1, home2, home3, home4, home5, home6];
    
    radioButtonNames = @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    radioButtonNidName = @"RadioButton_Slider";
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
