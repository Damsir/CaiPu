//
//  XiaoZhiShiViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiaoZhiShiViewController.h"
#import "shouYeModel.h"
#import "XiaoZhiShiListCell.h"
//#import "WebViewController.h"
#import "SubWebViewController.h"

@interface XiaoZhiShiViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString*httpStr;
    int page;
    UITableView*mainTableView;
    
    NSMutableArray*dataList;
}
@end

@implementation XiaoZhiShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _keyword=@"菜";
    
    [self createUrlStr];
    page=1;
    dataList=[NSMutableArray array];
    
    [self configUI];
    [mainTableView.header beginRefreshing];
    
}
-(void)createUrlStr
{
    _urlStr=@"http://ibaby.ipadown.com/api/food/food.tips.list.php?keywords=菜&p=%d&pagesize=20&from=com.ipadown.djbt&version=2.0";
}
#pragma mark 配置链接
-(void)configHttpStr
{
    httpStr=[NSString stringWithFormat:_urlStr,page];
    httpStr=[httpStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
#pragma mark 请求网络数据
-(void)getHttpData
{
    
    [self configHttpStr];
    [mainTableView showJUHUAWithBool:YES];
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    
    [manager GET:httpStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
        [mainTableView showJUHUAWithBool:NO];
        shouYeModel*model=[[shouYeModel alloc] mj_setKeyValues:operation.responseString];
        
        [dataList addObjectsFromArray:model.results];
        
        [mainTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    
    }];
    [mainTableView.header endRefreshing];
    [mainTableView.footer endRefreshing];
}
#pragma mark 配置UI
-(void)configUI
{
    [super configUI];
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-20) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
//    mainTableView.tag=987654;
    mainTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:mainTableView];
    
    mainTableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page=1;
        [dataList removeAllObjects];
        [self getHttpData];
    }];
    
    mainTableView.footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [self getHttpData];
    }];
}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XiaoZhiShiListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"xiaoZhiShiCell"];
    if (!cell) {
        cell=[[XiaoZhiShiListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"xiaoZhiShiCell"];
    }
    //防止数组越界
    if (dataList.count) {
        
        [cell configUIWith:dataList[indexPath.row] and:indexPath.row+1];
  
    }
//    cell.contentView.tag=987654;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubWebViewController*subWeb=[[SubWebViewController alloc] init];
    subWeb.Id=[dataList[indexPath.row] ID];
    subWeb.kindStr=@"tips";
    subWeb.navigationItem.title=[dataList[indexPath.row] title] ;
    subWeb.Title=[dataList[indexPath.row] title] ;
    
    [self.navigationController pushViewController:subWeb animated:YES];
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
