//
//  HeadView.h
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicDetailViewController.h"

@interface HeadView : UIView

-(CGFloat)configUIWith:(NSString*)img and:(NSString*)title and:(NSString *)jianJie and:(TopicDetailViewController*)vc;
@end
