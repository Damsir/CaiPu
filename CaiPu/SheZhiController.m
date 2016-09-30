//
//  SheZhiController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SheZhiController.h"
#import "SetHeaderV.h"
#import "SetCell.h"
#import "DBManager.h"
#import "FileService.h"
#define Cache_P [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]



@interface SheZhiController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView*mainTableView;
    NSArray*dataArr;
    UIImagePickerController*pickerC;
}


@end

@implementation SheZhiController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor greenColor];
    [self loadData];
    
    [self configUI];
}
#pragma mark 加载数据
-(void)loadData
{
    dataArr=@[@{@"img":@"plugin_icon_setting",@"name":@"设置头像"},@{@"img":@"plugin_icon_info",@"name":@"清空缓存"}];
    
    pickerC=[[UIImagePickerController alloc] init];
    pickerC.delegate=self;
    pickerC.allowsEditing=YES;
}

#pragma mark 配置UI
-(void)configUI
{
    [super configUI];
    
    mainTableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    mainTableView.delegate=self;
    mainTableView.dataSource=self;
    [self.view addSubview:mainTableView];
    
    SetHeaderV*headerV=[[SetHeaderV alloc] initWithFrame:CGRectMake(0, 0, Screen_W, 250*POINT_H)];
    
    [headerV configUIWithVC:self];
    headerV.delegate=self;

    mainTableView.tableHeaderView=headerV;
    
    [mainTableView registerNib:[UINib nibWithNibName:@"SetCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
#pragma mark tableview的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SetCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    
//    cell.imageView.image=[UIImage imageNamed:dataArr[indexPath.row][@"img"]];
//    cell.textLabel.text=dataArr[indexPath.row][@"name"];
    //计算缓存大小
     CGFloat f=[FileService folderSizeAtPath:Cache_P];
    
    NSLog(@"缓存大小%.2f",f);
    
    [cell configUIWithDic:dataArr[indexPath.row] andIndex:indexPath.row andCache:f];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*lab=[[UILabel alloc]  initWithFrame:CGRectMake(0, 0, Screen_W, 44)];
    lab.text=@"    系统设置";
    lab.textColor=[UIColor grayColor];
    lab.font=[UIFont systemFontOfSize:15];
    return lab;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        NSLog(@"设置头像");
        [self changeIcon];
    }
    else if (indexPath.row==1)
    {
        NSLog(@"清除缓存");
        
        NSLog(@"%@",Cache_P);
        
//        CGFloat size=[FileService folderSizeAtPath:Cache_P];
//        NSLog(@"缓存大小:%2f",size);
        
        [FileService clearCache:Cache_P];
        
        [mainTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//        CGFloat size1=[FileService folderSizeAtPath:Cache_P];
//        NSLog(@"%2f",size1);
        UIAlertView*alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:@"清除成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        
        [alertV show];
    }
}
-(void)changeIcon
{
    UIActionSheet*sheet=[[UIActionSheet alloc] initWithTitle:@"您可以通过以下途径设置头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册",@"还原成系统头像", nil];
    
    [sheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSLog(@"拍照");
        pickerC.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickerC animated:YES completion:nil];
    }
    
    else if (buttonIndex==1) {
        NSLog(@"从相册");
        pickerC.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pickerC animated:YES completion:nil];
//
    }
    else if (buttonIndex==2)
    {
        NSLog(@"系统头像");
        UIImage*img=[UIImage imageNamed:@"logo2"];
        DBManager*manager=[DBManager sharedDBManager];
        NSArray*iconArr=[manager receaveIcon];
        for (NSDictionary*dic in iconArr) {
            [manager deleteIconWithDic:dic];
        }
        self.imgBlock(img);
        self.imgBlock1(img);
    }
 
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    DBManager*manager=[DBManager sharedDBManager];
    NSArray*arr=[manager receaveIcon];
    for (NSDictionary*dic in arr) {
        [manager deleteIconWithDic:dic];
    }
    
    if (info[UIImagePickerControllerEditedImage]) {
        //编辑后的图片
//        self.imgBlock(info[UIImagePickerControllerEditedImage]);
        //放入数据库进行保存
        //先归档
        NSData*imgData=[NSKeyedArchiver archivedDataWithRootObject:info[UIImagePickerControllerEditedImage]];
        [manager addIconWtihDic:@{@"icon":imgData}];
        
    }
    else
    {
        //没有编辑的图片
//        self.imgBlock(info[UIImagePickerControllerOriginalImage]);
        //放入数据库进行保存
        NSData*imgData=[NSKeyedArchiver archivedDataWithRootObject:info[UIImagePickerControllerOriginalImage]];
        [manager addIconWtihDic:@{@"icon":imgData}];
        
    }
    NSArray*iconArr=[manager receaveIcon];
    //解档
    UIImage*iconImg=[NSKeyedUnarchiver unarchiveObjectWithData:iconArr[0][@"icon"]];
    //改变headV的头像
    self.imgBlock(iconImg);
    //改变左侧抽屉的头像
    self.imgBlock1(iconImg);
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark scrollview代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
    _block(scrollView.contentOffset.y);
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
