//
//  HealthShiLiaoViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HealthShiLiaoViewController.h"
#import "HealthModel.h"
#import "SubViewController.h"


@interface HealthShiLiaoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*mainTableView;
    NSMutableArray*indesArr;//索引数组
    NSMutableArray*itemsArr;//内容数组
    UILabel*tiShiLab;//提示标签
}
//@property(nonatomic,copy)void(^block)(NSMutableArray*);

@end

@implementation HealthShiLiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationItem.title=@"健康食疗";
    
    [self configUI];
    [self getHttpData];
    
}
#pragma mark 请求网络数据
-(void)getHttpData
{
    [mainTableView showJUHUAWithBool:YES];
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    [manager GET:@"http://ibaby.ipadown.com/api/food/food.tips.category.php" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"健康食疗%@",operation.responseString);
        [mainTableView showJUHUAWithBool:NO];
        HealthModel*model=[[HealthModel alloc] mj_setKeyValues:operation.responseString];
        [indesArr addObjectsFromArray:model.indexs];
        [itemsArr addObjectsFromArray:model.items];
        
        [mainTableView reloadData];
        
        //增宽系统的indextitle
        for(UIView *v in mainTableView.subviews){
            
            Class s=NSClassFromString(@"UITableViewIndex");
            if ([v isKindOfClass:s]) {
            
                CGFloat index_w=60.0;
                v.frame=CGRectMake(Screen_W-index_w,0,index_w,Screen_H);
                [mainTableView reloadSectionIndexTitles];
//                NSLog(@"-----------%@",v);
            }
        }
//        _block(indesArr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error.localizedDescription);
    }];
}
#pragma mark 配置UI
-(void)configUI
{
    [super configUI];
    
//    self.view.backgroundColor=[UIColor colorWithWhite:0.914 alpha:1.000];
    
    mainTableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H-64) style:UITableViewStylePlain];
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    mainTableView.sectionIndexBackgroundColor=[UIColor clearColor];
    mainTableView.sectionIndexColor=[UIColor blackColor];
    mainTableView.tableFooterView=[[UIView alloc] initWithFrame:CGRectZero];
    mainTableView.showsVerticalScrollIndicator=NO;
    
    [self.view addSubview:mainTableView];
    
    indesArr=[NSMutableArray array];
    itemsArr=[NSMutableArray array];
    
    tiShiLab=[[UILabel alloc] init];
        tiShiLab.center=CGPointMake(self.view.center.x, self.view.center.y-70.0*POINT_H);
//    tiShiLab.center=CGPointMake(100, 100);
    tiShiLab.textAlignment=NSTextAlignmentCenter;
    tiShiLab.bounds=CGRectMake(0, 0, 100, 100);
    tiShiLab.font=[UIFont boldSystemFontOfSize:25.0];
    [self.view addSubview:tiShiLab];
    
    

    //开始让提示标签的透明度为0
    tiShiLab.alpha=0;
    
//    __weak typeof(*&self)weakSelf=self;
    
//    _block=^(NSMutableArray*indexsArr)
//    {
//        for (int i=0; i<indexsArr.count; i++) {
//            UIButton*btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [btn setTitle:indexsArr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            btn.frame=CGRectMake(Screen_W-70, (100+15*i)*POINT_H, 70, 10*POINT_H);
//            btn.titleLabel.font=[UIFont systemFontOfSize:10];
//            [weakSelf.view addSubview:btn];
//            btn.tag=100+i;
//            [btn addTarget:weakSelf action:@selector(indexClick:) forControlEvents:UIControlEventTouchDown];
//        }
//    };
}
//-(void)indexClick:(UIButton*)btn
//{
//    NSIndexPath *path=[NSIndexPath indexPathForRow:0 inSection:btn.tag-100];
//    UITableViewCell  *cell=[mainTableView cellForRowAtIndexPath:path];
//    CGRect frame = [cell convertRect:mainTableView.bounds toView:nil];
    
//    NSLog(@"----------------%f,%f",frame.origin.y,frame.size.height);
//}
#pragma mark tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//    NSLog(@"======%@",[itemsArr[section] items]);
    
    return [[itemsArr[section] items] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return indesArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"healthCell"];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"healthCell"];
    }
    cell.textLabel.text=[itemsArr[indexPath.section] items][indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*headLab=[[UILabel alloc] init];
    
    headLab.text=[NSString stringWithFormat:@"    %ld.%@",(long)section+1,indesArr[section]];
    
    headLab.backgroundColor=[UIColor colorWithWhite:0.917 alpha:1.000];
    
    headLab.font=[UIFont systemFontOfSize:14.0];
    
    return headLab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubViewController*subVC=[[SubViewController alloc] init];
    subVC.tags=[itemsArr[indexPath.section] items][indexPath.row];
    
    subVC.navigationItem.title=[itemsArr[indexPath.section] items][indexPath.row];
    NSLog(@"%@",[itemsArr[indexPath.section] items][indexPath.row]);
//    self.navigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:subVC animated:YES];
    
}


#pragma mark 右边索引的代理方法
-(NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indesArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
  
    //点击索引后显示标签
    tiShiLab.alpha=1;

    tiShiLab.text=title;
    NSLog(@"%@",title);
    
    //设动画让提示标签的透明度为0
    [UIView animateWithDuration:1 animations:^{
        tiShiLab.alpha=0;
    }];
    
    return index;
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
