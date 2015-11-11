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




- (void)initizileData_CJSliderVC{
    
    NSArray *channelNames_all = @[@"Home1第一页", @"Home2", @"Home3是佛恩", @"Home4天赐的爱", @"Home5你是礼物", @"Home6"];
    NSMutableArray *channelNames = [[NSMutableArray alloc]init];
    NSInteger count_channel = channelNames_all.count;
    //NSInteger count_channel = 3+rand()%(channelNames_all.count-3);
    for (int i = 0; i < count_channel; i++) {
        NSString *channelName = [channelNames_all objectAtIndex:i];
        [channelNames addObject:channelName];
    }
    
    radioControllers = [[NSMutableArray alloc]init];
    radioButtonNames = [[NSMutableArray alloc]init];
    for (int i = 0; i < channelNames.count; i++) {
        NSString *name = [channelNames objectAtIndex:i];
        
        [radioButtonNames addObject:name];
        
        switch (i) {
            case 0:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                vc.view.backgroundColor = [UIColor redColor];
                [radioControllers addObject:vc];
                break;
            }
            case 1:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                vc.view.backgroundColor = [UIColor greenColor];
                [radioControllers addObject:vc];
                break;
            }
            case 2:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                vc.view.backgroundColor = [UIColor blueColor];
                [radioControllers addObject:vc];
                break;
            }
            default:
            {
                UIViewController *vc = [[UIViewController alloc]init];
                vc.view.backgroundColor = i%2 == 0 ? [UIColor orangeColor] : [UIColor yellowColor];
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
