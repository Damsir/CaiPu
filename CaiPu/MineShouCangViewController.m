//
//  MineShouCangViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MineShouCangViewController.h"
#import "ShouYeTableViewCell.h"
#import "WebViewController.h"
#import "AppDelegate.h"
#import "DBManager.h"
#import "shouYeModel.h"

@interface MineShouCangViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*mainTableView;
    NSMutableArray *dataList;
}

@end

@implementation MineShouCangViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataList=[NSMutableArray array];
    
}

-(void)configUI
{
    [super configUI];
    
    [dataList removeAllObjects];
    DBManager*manager=[DBManager sharedDBManager];
    NSArray*arr=[manager receaveData];
    for (NSDictionary*dic in arr) {
        shouYeInfo*model=[[shouYeInfo alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        
        [dataList addObject:model];
        
    }
    
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-64) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    
    [mainTableView registerNib:[UINib nibWithNibName:@"ShouYeTableViewCell" bundle:nil] forCellReuseIdentifier:@"shouYeCell"];
    
    mainTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:mainTableView];
    
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
        [cell configUIWith:dataList[dataList.count-1-indexPath.row]];
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
//    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.chouTi setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.chouTi setPanEnabled:YES];
    [self configUI];
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
