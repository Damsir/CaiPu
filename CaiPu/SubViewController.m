//
//  SubViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUrlStr];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];

}
-(void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createUrlStr
{
    self.urlStr=[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.tips.list.php?p=%@&pagesize=20&tags=%@",@"%d",_tags];
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
