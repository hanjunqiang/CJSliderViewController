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
    
    [self initizileData_CJSliderVC];
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
    [self removeAllViews_CJSliderVC];
    [self initizileView_CJSliderVC];
}




- (void)initizileData_CJSliderVC{
    
    NSArray *channelNames = @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    
    
    radioControllers = [[NSMutableArray alloc]init];
    radioButtonNames = [[NSMutableArray alloc]init];
    for (int i = 0; i < channelNames.count; i++) {
        NSString *name = [channelNames objectAtIndex:i];
        
        [radioButtonNames addObject:name];
        
        switch (i) {
            case 0:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                [radioControllers addObject:vc];
                break;
            }
            case 1:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                [radioControllers addObject:vc];
                break;
            }
            case 2:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                [radioControllers addObject:vc];
                break;
            }
            default:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                [radioControllers addObject:vc];
                break;
            }
        }
    }
    
    
    
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
