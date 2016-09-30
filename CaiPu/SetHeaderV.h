//
//  SetHeaderV.h
//  CaiPu
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SheZhiController.h"

@protocol SetHeaderVDelegate <NSObject>

-(void)changeIcon;

@end

@interface SetHeaderV : UIView

-(void)configUIWithVC:(SheZhiController*)sheZhiVC;
@property(nonatomic,assign)id delegate;

@end
