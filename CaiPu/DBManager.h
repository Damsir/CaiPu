//
//  DBManager.h
//  FreeLimitDemo
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject
+(instancetype)sharedDBManager;
-(instancetype)init;
-(void)addDataWithDictionary:(NSDictionary *)dataDic;
//增加头像
-(void)addIconWtihDic:(NSDictionary*)iconDic;

-(void)deleteDataWithDictionary:(NSDictionary*)dataDic;
//删除头像
-(void)deleteIconWithDic:(NSDictionary*)iconDic;

-(void)searchDataWithDictionary:(NSDictionary*)dataDic;

-(NSArray*)receaveData;
//显示所有icon
-(NSArray*)receaveIcon;
@end
