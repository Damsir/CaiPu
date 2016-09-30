//
//  UIView+ProgressView.m
//  UICollectionViewAndHttp
//
//  Created by smith on 15/11/3.
//  Copyright © 2015年 smith. All rights reserved.
//

#import "UIView+ProgressView.h"

#define VIEW_TAG  9909

@implementation UIView (ProgressView)

- (void)showJUHUAWithBool:(BOOL)isShow
{
    if (isShow)
    {
        self.userInteractionEnabled=NO;
        UIView * backView = [self viewWithTag:VIEW_TAG] ;
        if (backView)
        {
            return ;
        }
        //第一个层级
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)] ;
        backView.tag = VIEW_TAG ;
        [self addSubview:backView] ;
        [self bringSubviewToFront:backView];
        
        //第二个层级 是用来做透明度用的
        UIView * subBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_W, Screen_H)] ;
        
        subBackView.backgroundColor = [UIColor clearColor] ;
        
//        subBackView.alpha = 0.3f ;
        
        [backView addSubview:subBackView] ;
        
        //第三层级 菊花
        
        UIView * blackView = [[UIView alloc] init];
        blackView.center=CGPointMake(Screen_W/2.0, Screen_H/2.0-64.0);
        blackView.bounds=CGRectMake(0, 0, 120, 70);
//        UIView*blackView=[[UIView alloc] init];
//        blackView.bounds=CGRectMake(0, 0, self.bounds.size.width-200, 100);
//        blackView.center=self.center;
        blackView.layer.cornerRadius = 10 ;
        blackView.backgroundColor = [UIColor blackColor] ;
        [backView addSubview:blackView] ;
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] ;
        activity.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2) ;
        [activity startAnimating] ;
        [blackView addSubview:activity] ;
        
    }
    else
    {
        self.userInteractionEnabled=YES;
        UIView * backView = [self viewWithTag:VIEW_TAG] ;
        [backView removeFromSuperview] ;
    }
}


@end
