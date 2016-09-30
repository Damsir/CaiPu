//
//  SheZhiController.h
//  CaiPu
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SuperViewController.h"

@interface SheZhiController : SuperViewController
@property(nonatomic,copy)void(^block)(CGFloat);

@property(nonatomic,copy)void(^imgBlock)(UIImage*);
@property(nonatomic,copy)void(^imgBlock1)(UIImage*);
@property(nonatomic,copy)void(^cacheBlock)(CGFloat);

@end
