//
//  TopicDetailViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "DetailCell.h"
#import "shouYeModel.h"
#import "HeadView.h"
#import "WebViewController.h"

@interface TopicDetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UITableView*mainTableView;
    NSMutableArray*dataList;
    NSString*title;
}



@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataList=[NSMutableArray array];
    
    [self configUI];
    
    [self getHttpData];
}
-(void)configUI
{
    
//    self.navigationController.navigationBar.alpha=0;
//    self.navigationController.navigationBar.translucent=YES;
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    //配置tableView
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-64) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"DetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:mainTableView];
    
}
#pragma mark pop自己
-(void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getHttpData
{
    [mainTableView showJUHUAWithBool:YES];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.topic.detail.php?id=%@",_Id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",operation.responseString);
        [mainTableView showJUHUAWithBool:NO];
        
        shouYeModel*model=[[shouYeModel alloc] mj_setKeyValues:operation.responseString];
        [dataList addObjectsFromArray:model.list];
        
//        NSLog(@"-----%@",dataList);
        title=model.title;
        
        HeadView*headV=[[HeadView alloc] init];
        
        CGFloat hdHeight=[headV configUIWith:model.thumb and:model.title and:model.jianjie and:self];
        
        headV.frame=CGRectMake(0, 0, Screen_W, hdHeight);
        
        mainTableView.tableHeaderView=headV;
        
        NSLog(@"%f",hdHeight);
        
        [mainTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error%@",error.localizedDescription);
    }];
}
#pragma mark tableview的代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    [cell configUIWith:dataList[indexPath.row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 0, Screen_W, 44.0)];
    
    lab.text=[NSString stringWithFormat:@"   %@",title];
    
    lab.textColor=[UIColor colorWithRed:0.288 green:0.473 blue:0.203 alpha:1.000];
    lab.backgroundColor=[UIColor whiteColor];
    
    lab.font=[UIFont boldSystemFontOfSize:15];
    
    return lab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0*POINT_H;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController*web=[[WebViewController alloc] init];
    web.Id=[dataList[indexPath.row] ID];
//    web.navigationItem.title=[dataList[indexPath.row] title];
    web.navigationItem.title=@"做法详情";
    web.Title=[dataList[indexPath.row] title];
    web.imgStr=[dataList[indexPath.row] thumb_2];
    web.kindStr=@"show";
    [self.navigationController pushViewController:web animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%@",NSStringFromCGPoint(mainTableView.contentOffset));

    if (mainTableView.contentOffset.y<0)
    {
         _block(mainTableView.contentOffset.y);
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
