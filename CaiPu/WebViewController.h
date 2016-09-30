//
//  WebViewController.h
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property(nonatomic,copy)NSString*Id;
@property(nonatomic,copy)NSString*kindStr;
@property(nonatomic,assign)int index;
@property(nonatomic,copy)NSString*imgStr;
@property(nonatomic,copy)NSString*Title;
-(void)configIndex;
@end
