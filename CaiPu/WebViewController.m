//
//  WebViewController.m
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"
#import "DBManager.h"
//#import "UMSocial.h"




@interface WebViewController ()<UIWebViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate>
{
    UIWebView*mainWebView;
    NSString*urlStr;
    
    UILabel*tishiLab;
    int temp;
    
}
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configIndex];
    [self configUrlStr];
    [self configUI];
    
}
-(void)configIndex
{
    self.index=1;
}

#pragma mark 配置链接
-(void)configUrlStr
{
    urlStr=[NSString stringWithFormat:@"http://ibaby.ipadown.com/api/food/food.%@.detail.php?id=%@",_kindStr,_Id];
}
-(void)configUI
{
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popSelf)];
    
    if (self.index==1) {
        mainWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, -50.0*POINT_H, Screen_W, Screen_H+170*POINT_H)];
    }
    else
    {
        mainWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, -48.0*POINT_H, Screen_W, Screen_H-10.0*POINT_H)];
    }
    
    mainWebView.delegate=self;
    [mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    mainWebView.scrollView.bounces=NO;
    mainWebView.scrollView.showsVerticalScrollIndicator=NO;

//    mainWebView.tag=987654;
    [self.view addSubview:mainWebView];
    
//    UIView*noChouTiView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    noChouTiView.backgroundColor=[UIColor clearColor];
//    [self.view addSubview:noChouTiView];
//    noChouTiView.tag=987654;
//    noChouTiView.userInteractionEnabled=NO;
    
    //监听
//    [mainWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    //提示lab
    tishiLab=[[UILabel alloc] init];
    tishiLab.center=self.view.center;
    tishiLab.bounds=CGRectMake(0, 0, 200, 50);
    tishiLab.textAlignment=NSTextAlignmentCenter;
    tishiLab.backgroundColor=[UIColor clearColor];
    tishiLab.textColor=Main_Color;
    tishiLab.font=[UIFont boldSystemFontOfSize:20];
    [self.view addSubview:tishiLab];
    tishiLab.alpha=0;
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    
//    CGPoint p=[change[@"new"] CGPointValue];
//    NSLog(@"%f",p.y);
//    
//    
//    UILabel*lab=(UILabel*)[self.view viewWithTag:100];
//    lab.frame=CGRectMake(10, 310-p.y, 55, 30);
//    
//}

#pragma mark pop自己
-(void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 分享
-(void)shareTo
{
//    UIPasteboard*pasteboard = [UIPasteboardgeneralPasteboard];
    UIPasteboard*pBoard=[UIPasteboard generalPasteboard];
    
    pBoard.string=[NSString stringWithFormat:@"%@%@",self.Title,urlStr];
    UIActionSheet*sheet=[[UIActionSheet alloc] initWithTitle:@"内容已复制到粘贴板,您可以分享到:" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"QQ",@"微信",@"QQ空间",@"新浪微博", nil];
    
    [sheet showInView:self.view];
#if 0
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5655710d67e58ea1b2001806"
                                      shareText:[NSString stringWithFormat:@"%@%@",self.Title,urlStr]
                                     shareImage:[UIImage imageNamed:@"logo2.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToQzone,UMShareToQQ,nil]
                                       delegate:nil];
#endif
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIApplication*app=[UIApplication sharedApplication];
    if (buttonIndex==0) {
        NSLog(@"qq");
        
        BOOL isSus=[app openURL:[NSURL URLWithString:@"mqq://"]];
        if (!isSus) {
            NSLog(@"没有qq");
            [self showAlert:@"QQ"];
        }
    }
    else if (buttonIndex==1){
        BOOL isSus=[app openURL:[NSURL URLWithString:@"wechat://"]];
        if (!isSus) {
            NSLog(@"没有微信");
            [self showAlert:@"微信"];
        }
    }
    else if (buttonIndex==2){
        BOOL isSus=[app openURL:[NSURL URLWithString:@"mqzone://"]];
        if (!isSus) {
            NSLog(@"没有qq空间");
            [self showAlert:@"QQ空间"];
        }
        
    }
    else if (buttonIndex==3){
        
        BOOL isSus=[app openURL:[NSURL URLWithString:@"weibo://"]];
        if (!isSus) {
            NSLog(@"没有新浪微博");
            [self showAlert:@"新浪微博"];
        }
    }
}
-(void)showAlert:(NSString*)t
{
    NSString*tt=[NSString stringWithFormat:@"您没有安装%@哦",t];
    UIAlertView*alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:tt delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertV show];
}

#pragma mark  webView的代理
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString*tempStr=[NSString stringWithFormat:@"%@",request.URL];
    NSLog(@"%@",tempStr);
    NSArray*arr=[tempStr componentsSeparatedByString:@"://"];
    NSString*str=arr[0];
    
    if ([str isEqualToString:@"bookmark"]) {
        
//        NSLog(@"位置:%f",webView.scrollView.contentOffset.y);
        
//        UILabel*lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 310, 55, 30)];
//        lab.text=@"已收藏";
//        lab.tag=100;
//        lab.font=[UIFont systemFontOfSize:14];
//        lab.textColor=[UIColor whiteColor];
//        lab.backgroundColor=[UIColor redColor];
//        lab.textAlignment=NSTextAlignmentCenter;
//        [self.view addSubview:lab];
        
        DBManager*manager=[DBManager sharedDBManager];
        
        NSArray*dbArr=[manager receaveData];
        temp=0;
        for (NSDictionary*dic in dbArr) {
            if ([dic[@"ID"] isEqualToString:self.Id]) {
                temp++;
            }
        }
        UIAlertView*alertV;
        if (temp==0) {
            alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您可以收藏该菜谱" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"收藏", nil];
        }
        else
        {
            alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您已经收藏了该菜谱,确定要移除该收藏?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        }
        [alertV show];
        
    }
//    else if ([str isEqualToString:@"cookid"])
//    {
//        WebViewController*webVC=[[WebViewController alloc] init];
//        webVC.Id=arr[1];
//        webVC .kindStr=@"show";
//        webVC.navigationItem.title=@"做法详情";
//        [self.navigationController pushViewController:webVC animated:YES];
//    }
    
    return YES;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"0");
    }
    else if (buttonIndex==1)
    {
        NSLog(@"1");
        tishiLab.alpha=1;
        
        
        DBManager *manager=[DBManager sharedDBManager];
        
        if (temp==0) {
            [manager addDataWithDictionary:@{@"ID":self.Id,@"thumb_2":self.imgStr,@"title":self.Title}];
            
            tishiLab.text=@"收藏成功";
        }
        else
        {
            [manager deleteDataWithDictionary:@{@"ID":self.Id,@"thumb_2":self.imgStr,@"title":self.Title}];
            tishiLab.text=@"移除成功";
        }
        
        [UIView animateWithDuration:2 animations:^{
            tishiLab.alpha=0;
//            tishiLab.bounds=CGRectMake(0, 0, 0, 0);
        }];
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    UIActivityIndicatorView*juHua=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [juHua startAnimating];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:juHua];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(shareTo)];
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
