//
//  TopicTuiJianViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopicTuiJianViewController.h"
#import "shouYeModel.h"
#import "TopicCell.h"
#import "TopicDetailViewController.h"

@interface TopicTuiJianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*mainTableView;
    int page;
    NSMutableArray*dataList;
    NSString*urlStr;
}
@end

@implementation TopicTuiJianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title=@"专题推荐";
    dataList=[NSMutableArray array];
    page=1;
    [self configUI];
    [mainTableView.header beginRefreshing];
}
-(void)configUrlStr
{
    urlStr=[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.topic.list.php?p=%d&pagesize=10&order=addtime",page];
}
-(void)getHttpData
{
    [self configUrlStr];
    [mainTableView showJUHUAWithBool:YES];
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
        [mainTableView showJUHUAWithBool:NO];
        shouYeModel*model=[[shouYeModel alloc] mj_setKeyValues:operation.responseString];
        //        shouYeInfo*info=model.results[0];
        //        NSLog(@"%@",info.title);
        [dataList addObjectsFromArray:model.results];
        
        [mainTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
    [mainTableView.header endRefreshing];
    [mainTableView.footer endRefreshing];

}
-(void)configUI
{
    [super configUI];
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-20) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    
    [mainTableView registerNib:[UINib nibWithNibName:@"TopicCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    mainTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:mainTableView];
    
    
    //下拉刷新
    mainTableView.header =[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=1;
        [dataList removeAllObjects];
        [self getHttpData];
    }];
    //上拉加载
    mainTableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self getHttpData];
    }];
}
#pragma mark tableview的代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (dataList.count) {
        [cell configUIWith:dataList[indexPath.row]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210.0*POINT_H;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicDetailViewController*detailVC=[[TopicDetailViewController alloc] init];
    detailVC.navigationItem.title=@"详情";
    detailVC.Id=[dataList[indexPath.row] ID];
    detailVC.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    [self.navigationController pushViewController:detailVC animated:YES];
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
