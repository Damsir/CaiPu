//
//  MainViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MainViewController.h"
#import "shouYeModel.h"
#import "ShouYeTableViewCell.h"
#import "WebViewController.h"
#import "AppDelegate.h"


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSString*httpStr;
    int page;
    UITableView*mainTableView;
    NSMutableArray*dataList;
    NSString*keywords;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title=@"厨师菜谱";
    keywords=@"";
    dataList=[NSMutableArray array];
    page=1;
    _cateStr=@"菜";

    [self configUI];
    [mainTableView.header beginRefreshing];
}

#pragma mark 配置链接
-(void)configHttpStr
{
    httpStr=[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.show.list.php?category=%@&p=%d&pagesize=10&from=com.ipadown.djbt&version=2.0%@",_cateStr,page,keywords];
    
    httpStr=[httpStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
#pragma mark 请求网络数据
-(void)getHttpData
{
    [self configHttpStr];
//    NSLog(@"链接%@",httpStr);
    
    [mainTableView showJUHUAWithBool:YES];
    
    AFHTTPRequestOperationManager*manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    [manager GET:httpStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",operation.responseString);
        
        [self btnClick];
//        keywords=@"";
        
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
#pragma mark 创建UI
-(void)configUI
{
    [super configUI];
    self.navigationItem.title=@"养生菜谱";
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-20) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    
    [mainTableView registerNib:[UINib nibWithNibName:@"ShouYeTableViewCell" bundle:nil] forCellReuseIdentifier:@"shouYeCell"];
    
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
    
    //添加导航栏右边搜索按钮
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn-search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchStart)];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
}
#pragma mark 搜索
-(void)searchStart
{
    UISearchBar*searchB=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 400, 44)];
    searchB.placeholder=@"请输入您想搜索的菜谱";
    [searchB becomeFirstResponder];
    searchB.delegate=self;
    
    UIButton*cancelBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame=CGRectMake(0, 0, 50, 44);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.titleView=searchB;
}
-(void)btnClick
{
    [self.navigationItem.titleView endEditing:YES];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn-search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(searchStart)];
    UILabel*titLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titLab.text=@"养生菜谱";
    titLab.textColor=[UIColor whiteColor];
    titLab.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView=titLab;
}
//点击搜索
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    NSLog(@"您在搜%@",searchBar.text);
    keywords=[NSString stringWithFormat:@"&keywords=%@",searchBar.text];
//    NSLog(@"链接:%@",keywords);
    [mainTableView.header beginRefreshing];
    
}

#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataList.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouYeTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"shouYeCell"];
    
    //防止数组越界
    if (dataList.count) {
        [cell configUIWith:dataList[indexPath.row]];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180.0*POINT_H;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIApplication*app=[UIApplication sharedApplication];
    AppDelegate*tempDelegate=(AppDelegate*)app.delegate;
    [tempDelegate.chouTi closeLeftView];
    
    WebViewController*web=[[WebViewController alloc] init];
    web.Id=[dataList[indexPath.row] ID];
    web.imgStr=[dataList[indexPath.row] thumb_2];
    web.kindStr=@"show";
    web.Title =[dataList[indexPath.row] title];
//    web.navigationItem.title=[dataList[indexPath.row] title];
    web.navigationItem.title=@"做法详情";
    [self.navigationController pushViewController:web animated:YES];
    
    NSLog(@"%ld",(long)indexPath.row);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.chouTi setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.chouTi setPanEnabled:YES];
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
