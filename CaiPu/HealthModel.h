//
//  HealthModel.h
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthModel : NSObject

@property(nonatomic,strong)NSArray*indexs;
@property(nonatomic,strong)NSArray*items;

@end

@interface HealthItems : NSObject

@property(nonatomic,copy)NSString*title;
@property(nonatomic,strong)NSArray*items;

@end

