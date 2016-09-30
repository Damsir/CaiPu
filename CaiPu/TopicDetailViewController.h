//
//  TopicDetailViewController.h
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopicDetailViewController : UIViewController
@property(nonatomic,copy)NSString*Id;
@property(nonatomic,copy)void (^block)(CGFloat);

@end
