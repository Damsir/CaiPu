//
//  SetHeaderV.m
//  CaiPu
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SetHeaderV.h"
#import "DBManager.h"
//#import "LeftViewController.h"


@interface SetHeaderV ()
{
    UIImageView*bgImgV;
    UIButton*iconBtn;
    UIImageView*imgV;
}

@end

@implementation SetHeaderV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        bgImgV=[[UIImageView alloc] initWithFrame:frame];
        bgImgV.userInteractionEnabled=YES;
        
        bgImgV.image=[UIImage imageNamed:@"bg_own.jpg"];
        
        iconBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        DBManager*manager=[DBManager sharedDBManager];
        NSArray*iconArr=[manager receaveIcon];
        if (iconArr.count) {
            //接档
            UIImage*iconImg=[NSKeyedUnarchiver unarchiveObjectWithData:iconArr[0][@"icon"]];
            [iconBtn setImage:iconImg forState:UIControlStateNormal];
        }
        else
        {
            [iconBtn setImage:[UIImage imageNamed:@"logo2"] forState:UIControlStateNormal];
        }
#if 0 //-----通知
        
//        LeftViewController*leftVC=[[LeftViewController alloc] init];
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeIcon" object:iconBtn userInfo:@{@"iconImg":iconBtn.imageView.image}];
//        [[NSNotificationCenter defaultCenter] addObserver:leftVC selector:@selector(changeIcon:) name:@"changIcon" object:nil];
#endif
        iconBtn.center=bgImgV.center;
        iconBtn.bounds=CGRectMake(0, 0, 100*POINT_H, 100*POINT_H);
        iconBtn.layer.cornerRadius=50.0*POINT_H;
        iconBtn.layer.masksToBounds=YES;
        
        [bgImgV addSubview:iconBtn];
        
        [iconBtn addTarget:self action:@selector(clickIcon) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:bgImgV];
        
#if 0
        imgV=[[UIImageView alloc] init];
        imgV.userInteractionEnabled=YES;
        imgV.tag=123;
        
        imgV.contentMode=UIViewContentModeScaleAspectFit;
        imgV.backgroundColor=[UIColor blackColor];
        
        imgV.image=iconBtn.imageView.image;
        [[UIApplication sharedApplication].keyWindow addSubview:imgV];
        imgV.hidden=YES;
        
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(minSelf:)];
        [imgV addGestureRecognizer:tap];
#endif
    }
    return self;
}

#pragma mark ---改变头像
-(void)clickIcon
{
    [self.delegate changeIcon];
}

#if 0
#pragma mark ---放大头像
-(void)plusSelf:(UIButton*)sender
{
    imgV.hidden=NO;
    [UIView animateWithDuration:1 animations:^{
        imgV.frame=[UIScreen mainScreen].bounds;
    }];
    
}
#pragma mark ----缩小头像
-(void)minSelf:(UITapGestureRecognizer*)tap
{
    imgV.hidden=YES;
}
#endif
#pragma mark ---滑动tableview的时候改变背景和头像
-(void)configUIWithVC:(SheZhiController *)sheZhiVC
{
    sheZhiVC.block=^(CGFloat hHeight){
        bgImgV.frame=CGRectMake(0, hHeight, Screen_W, self.frame.size.height-hHeight);
        iconBtn.bounds=CGRectMake(0, 0, 100*POINT_H-hHeight*(10.0/25.0), 100*POINT_H-hHeight*(10.0/25.0));
        iconBtn.layer.cornerRadius=(100*POINT_H-hHeight*(10.0/25.0))/2.0;
        
        iconBtn.center=CGPointMake(iconBtn.center.x, bgImgV.center.y-hHeight);
    };
    
    sheZhiVC.imgBlock=^(UIImage*img)
    {
        
        if ([img isEqual:iconBtn.imageView.image]) {
            NSLog(@"已经是系统头像了");
            UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"已经是系统头像了哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [iconBtn setImage:img forState:UIControlStateNormal];
        }
    };
}

@end



