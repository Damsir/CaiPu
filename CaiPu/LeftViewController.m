//
//  LeftViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "XiaoZhiShiViewController.h"
#import "HealthShiLiaoViewController.h"
#import "TopicTuiJianViewController.h"
#import "MineShouCangViewController.h"
#import "SheZhiController.h"
#import "DBManager.h"



@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*mainTable;
    NSArray*cellName;
    NSArray*cellImg;
    
    
}
@property(nonatomic,strong)UIButton*iconBtn;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
    [self configUI];
    
}
-(void)loadData
{
    cellName=@[@"      养 生 菜 谱",@"      小 知 识",@"      健 康 食 疗",@"      专 题 推 荐",@"      我 的 收 藏"];
    cellImg=@[@"item-cook",@"item-zs",@"item-health",@"item-topic",@"item-sc"];
}
-(void)configUI
{
    UIImageView*bgImgV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_bg"]];
    bgImgV.frame=self.view.bounds;
    [self.view addSubview:bgImgV];
    
    mainTable=[[UITableView alloc] initWithFrame:CGRectMake(100, 0, self.view.bounds.size.width-75, self.view.bounds.size.height)  style:UITableViewStylePlain];
    mainTable.delegate=self;
    mainTable.dataSource=self;
    mainTable.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    mainTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTable];
    
//    UIButton*iconBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [iconBtn setImage:[UIImage imageNamed:@"logo2"] forState:UIControlStateNormal];
//    iconBtn.frame=CGRectMake(0, 0, 100, 100);
//    iconBtn.layer.cornerRadius=50;
//    iconBtn.layer.masksToBounds=YES;
//    mainTable.tableHeaderView=iconBtn;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*cellId=@"myzone";
    
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.textLabel.text=cellName[indexPath.section];
    cell.backgroundColor=[UIColor clearColor];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSeparatorStyleNone;
    cell.imageView.image=[UIImage imageNamed:cellImg[indexPath.section]];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIButton*iconBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _iconBtn=iconBtn;
        DBManager*manager=[DBManager sharedDBManager];
        
        NSArray*iconArr=[manager receaveIcon];
        if (iconArr.count) {
            NSLog(@"数据库里有头像");
            
            //接档
            UIImage*iconImg=[NSKeyedUnarchiver unarchiveObjectWithData:iconArr[0][@"icon"]];
            [iconBtn setImage:iconImg forState:UIControlStateNormal];
        }
        else{
            [iconBtn setImage:[UIImage imageNamed:@"logo2"] forState:UIControlStateNormal];
        }
        
        iconBtn.frame=CGRectMake(75.0,75.0*POINT_H, 100.0*POINT_H, 100.0*POINT_H);
        iconBtn.layer.cornerRadius=50.0*POINT_H;
        iconBtn.layer.masksToBounds=YES;
        UIView*bgView=[[UIView alloc] init];
        bgView.frame=CGRectMake(0, 0, 200.0, 200.0*POINT_H);
        [bgView addSubview:iconBtn];
        [iconBtn addTarget:self action:@selector(sheZhi) forControlEvents:UIControlEventTouchUpInside];
        return bgView;
    }
    return [[UIView alloc] init];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 220.0*POINT_H;
    }
    return 30.0*POINT_H;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25.0*POINT_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIApplication*app=[UIApplication sharedApplication];
    AppDelegate*myAppDelegate=(AppDelegate *)app.delegate;
    UIViewController*vc=myAppDelegate.NavC.viewControllers.firstObject;
    UIViewController*childVC=vc.childViewControllers.firstObject;
//    NSLog(@"aaaaaa%@",childVC);
//    NSLog(@"bbbbbb%@",vc.childViewControllers);
    [childVC removeFromParentViewController];
    [childVC.view removeFromSuperview];
    
    if (indexPath.section==0) {
        NSLog(@"厨师菜谱");
//        vc.navigationItem.title=@"养生菜谱";
        UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titLab.text=@"厨师菜谱";
        titLab.textColor=[UIColor whiteColor];
        titLab.textAlignment=NSTextAlignmentCenter;
        vc.navigationItem.titleView=titLab;
        MainViewController*MVC=(MainViewController*)vc;
        [MVC btnClick];
    }
    else if (indexPath.section==1){
        
        XiaoZhiShiViewController*xiaoZhiShiVC=[[XiaoZhiShiViewController alloc] init];
//        vc.navigationItem.title=@"小知识";
        UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titLab.text=@"小知识";
        titLab.textColor=[UIColor whiteColor];
        titLab.textAlignment=NSTextAlignmentCenter;
        vc.navigationItem.titleView=titLab;
        vc.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
        xiaoZhiShiVC.view.frame=vc.view.bounds;
        //加导航
        
//        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:xiaoZhiShiVC];
        
        [vc.view addSubview:xiaoZhiShiVC.view];
        
        [vc addChildViewController:xiaoZhiShiVC];
        
        NSLog(@"小知识");
//        NSLog(@"---%@",NSStringFromCGRect(xiaoZhiShiVC.view.frame));
        
    }
    else if (indexPath.section==2){
        HealthShiLiaoViewController*healthVC=[[HealthShiLiaoViewController alloc] init];
//        vc.navigationItem.title=@"健康食疗";
        vc.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
        UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titLab.text=@"健康食疗";
        titLab.textColor=[UIColor whiteColor];
        titLab.textAlignment=NSTextAlignmentCenter;
        vc.navigationItem.titleView=titLab;
//        vc.navigationController.navigationBarHidden=YES;
        healthVC.view.frame=vc.view.bounds;
        //加导航
//        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:healthVC];
//        healthVC.navigationItem.title=@"健康食疗";
//        healthVC.navigationController.navigationBar.translucent=NO;
        [vc.view addSubview:healthVC.view];
        [vc addChildViewController:healthVC];
        NSLog(@"健康食疗");
    }
    else if (indexPath.section==3){
        TopicTuiJianViewController*topicVC=[[TopicTuiJianViewController alloc] init];
//        vc.navigationItem.title=@"专题推荐";
        vc.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
        UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titLab.text=@"专题推荐";
        titLab.textColor=[UIColor whiteColor];
        titLab.textAlignment=NSTextAlignmentCenter;
        vc.navigationItem.titleView=titLab;
        topicVC.view.frame=vc.view.bounds;
        //加导航
//        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:topicVC];
        
        
        [vc.view addSubview:topicVC.view];
        [vc addChildViewController:topicVC];
        NSLog(@"专题推荐");
    }
    else if (indexPath.section==4){
        MineShouCangViewController*mineShouCangVC=[[MineShouCangViewController alloc] init];
//        vc.navigationItem.title=@"我的收藏";
        vc.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
        UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
        titLab.text=@"我的收藏";
        titLab.textColor=[UIColor whiteColor];
        titLab.textAlignment=NSTextAlignmentCenter;
        vc.navigationItem.titleView=titLab;
        mineShouCangVC.view.frame=vc.view.bounds;
        
        //加导航
//        UINavigationController*nav=[[UINavigationController alloc] initWithRootViewController:mineShouCangVC];
        
        
        [vc.view addSubview:mineShouCangVC.view];
        [vc addChildViewController:mineShouCangVC];
        NSLog(@"我的收藏");
    }
    [myAppDelegate.chouTi closeLeftView];
}
#pragma mark 点击头像到设置界面
-(void)sheZhi
{
    UIApplication*app=[UIApplication sharedApplication];
    AppDelegate*myAppDelegate=(AppDelegate *)app.delegate;
    UIViewController*vc=myAppDelegate.NavC.viewControllers.firstObject;
    UIViewController*childVC=vc.childViewControllers.firstObject;

    [childVC removeFromParentViewController];
    [childVC.view removeFromSuperview];
    
    SheZhiController*sheZhiVC=[[SheZhiController alloc] init];
    
    UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titLab.text=@"设置";
    titLab.textColor=[UIColor whiteColor];
    titLab.textAlignment=NSTextAlignmentCenter;
    vc.navigationItem.titleView=titLab;
    vc.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    sheZhiVC.view.frame=vc.view.bounds;
    
    [vc.view addSubview:sheZhiVC.view];
    
    [vc addChildViewController:sheZhiVC];
    
    [myAppDelegate.chouTi closeLeftView];
    //回调头像
    sheZhiVC.imgBlock1=^(UIImage*img){
        
        if ([img isEqual:_iconBtn.imageView.image]) {
            NSLog(@"已经是系统头像了");
//            UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已经是系统头像了哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
        }
        else
        {
            [_iconBtn setImage:img forState:UIControlStateNormal];
        }
    };
}
#pragma mark--接收通知执行方法

//-(void)changeIcon:(NSNotification *)notify
//{
//    [_iconBtn setImage:notify.userInfo[@"iconImg"] forState:UIControlStateNormal];
//}

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
