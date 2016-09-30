//
//  shouYeModel.h
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shouYeModel : NSObject

@property(nonatomic,strong)NSArray*results;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *jianjie;
@property(nonatomic,strong)NSArray*list;

@end

@interface shouYeInfo : NSObject

@property (nonatomic, copy) NSString *edittime;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *yuanliao;
@property (nonatomic, copy) NSString *thumb_2;
@property (nonatomic, copy) NSString *yingyang;
@property (nonatomic, copy) NSString *effect;
@property (nonatomic, copy) NSString *views;

@end
