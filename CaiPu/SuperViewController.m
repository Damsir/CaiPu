//
//  SuperViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SuperViewController.h"
#import "AppDelegate.h"
@interface SuperViewController ()

@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self monitorNet];
}
-(void)configUI
{
    //添加导航栏左边按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]style:UIBarButtonItemStylePlain target:self action:@selector(openChouTi)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor=Main_Color;
    //关掉半透明
    self.navigationController.navigationBar.translucent=NO;
    self.automaticallyAdjustsScrollViewInsets =NO;
    //
    self.view.backgroundColor=[UIColor whiteColor];
//    self.navigationItem.title=@"养生菜谱";
    
}

#pragma mark 打开抽屉
-(void)openChouTi
{
    AppDelegate*myAppDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (myAppDelegate.chouTi.closed) {
        [myAppDelegate.chouTi openLeftView];
    }
    else
    {
        [myAppDelegate.chouTi closeLeftView];
    }
}
-(void)monitorNet
{
    AFNetworkReachabilityManager*manager=[AFNetworkReachabilityManager sharedManager];
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==AFNetworkReachabilityStatusUnknown) {
            [self showAlertWith:@"网络未知"];
        }
        else if (status==AFNetworkReachabilityStatusNotReachable)
        {
            [self showAlertWith:@"网络不可用,请检查您的窝蜂移动网络是否打开"];
        }
    }];
}
-(void)showAlertWith:(NSString*)message
{
    UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"网络提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
    
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
