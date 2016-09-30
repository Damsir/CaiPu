//
//  HeadView.m
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HeadView.h"
#import "UIImageView+AFNetworking.h"

@interface HeadView ()
{
    UILabel*titleName;
    UIImageView*imgV;
    UILabel*jianJieLab;
}

@end


@implementation HeadView


-(CGFloat)configUIWith:(NSString*)img and:(NSString*)title and:(NSString *)jianJie and:(TopicDetailViewController *)vc
{
    imgV=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, 160)];
    [self addSubview:imgV];
    
    UIView*bgView=[[UIView alloc]  initWithFrame:CGRectMake(0, 160-30, Screen_W, 30)];
    bgView.alpha=0.3;
    bgView.backgroundColor=[UIColor blackColor];
    [self addSubview:bgView];
    
    titleName=[[UILabel alloc] initWithFrame:CGRectMake(0, 160-30, Screen_W, 30)];
    titleName.backgroundColor=[UIColor clearColor];
    titleName.font=[UIFont systemFontOfSize:15];
    titleName.textColor=[UIColor whiteColor];
    [self  addSubview:titleName];
    
    jianJieLab=[[UILabel alloc] init];
    jianJieLab.font=[UIFont systemFontOfSize:13];
    jianJieLab.textColor=[UIColor grayColor];
    [self addSubview:jianJieLab];
    
    
    [imgV setImageWithURL:[NSURL URLWithString:img] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"]];
    
    titleName.text=[NSString stringWithFormat:@"   %@",title];
    
    CGSize size=[jianJie boundingRectWithSize:CGSizeMake(Screen_W-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    jianJieLab.frame=CGRectMake(10, 160+10, Screen_W-20, size.height);
    jianJieLab.text=jianJie;
    jianJieLab.numberOfLines=0;
    
    vc.block=^(CGFloat height)
    {
        CGFloat imgV_H=160.0-height;
        CGFloat temp_point=Screen_W/160.0;
        CGFloat imgV_W=imgV_H*temp_point;
        CGFloat zengLiang=imgV_W-Screen_W;
        
        imgV.frame=CGRectMake(0.0-zengLiang/2.0, height,imgV_W , imgV_H);
    };
    
    
    return size.height+170;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
