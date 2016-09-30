//
//  AppDelegate.h
//  CaiPu
//
//  Created by qianfeng on 15/11/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) LeftSlideViewController*chouTi;
@property(nonatomic,strong)UINavigationController*NavC;;
@end

