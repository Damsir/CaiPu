//
//  DBManager.m
//  FreeLimitDemo
//
//  Created by qianfeng on 15/11/7.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"
#import "FMResultSet.h"


@interface DBManager()
@property(nonatomic,strong)FMDatabase*fmdb;
@end
@implementation DBManager

static DBManager * _db;
+(instancetype)sharedDBManager
{
    @synchronized(self)
    {
        if (!_db) {
            _db=[[DBManager alloc] init];
        }
    }
    return _db;
}

-(instancetype)init
{
    if (self=[super init]) {
        
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/appdb.db"];
        NSLog(@"%@",path);
        FMDatabase*fmdb=[FMDatabase databaseWithPath:path];
        _fmdb=fmdb;
        
       [fmdb open];
//创建收藏表格
       NSString*sql=@"create table if not exists appdsb(ID varchar(32),title varchar(1024),thumb_2 varchar(1024))";
//创建头像表格
        NSString*iconSql=@"create table if not exists icondb(icon varchar(1024))";
        
       [fmdb executeUpdate:sql];
        [fmdb executeUpdate:iconSql];
        
    }
    return self;
}
//增加收藏
-(void)addDataWithDictionary:(NSDictionary *)dataDic
{
    //增加收藏
    NSString*sql=@"insert into appdsb (ID,title,thumb_2) values (?,?,?)" ;
    NSArray*array=[self receaveData];
    for (NSDictionary*dic in array) {
        if ([dic[@"ID"] isEqualToString:dataDic[@"ID"]]) {
            return;
        }
    }
     BOOL isAdd=[_fmdb executeUpdate:sql,dataDic[@"ID"],dataDic[@"title"],dataDic[@"thumb_2"]];
    if (isAdd) {
        NSLog(@"插入成功");
    }
#if 0
    
#endif
}
//增加头像
-(void)addIconWtihDic:(NSDictionary *)iconDic
{
    //增加头像
    NSString*iconSql=@"insert into icondb (icon) values (?)";
    NSArray*array=[self receaveIcon];
    for (NSDictionary*dic in array) {
        if ([dic[@"icon"] isEqualToString:iconDic[@"icon"]]) {
            return;
        }
    }
    BOOL isSusIcon=[_fmdb executeUpdate:iconSql,iconDic[@"icon"]];
    if (isSusIcon) {
        NSLog(@"增加头像成功");
    }
}



//删
-(void)deleteDataWithDictionary:(NSDictionary*)dataDic
{
    //删除收藏
    NSString*sql=@"delete from appdsb where ID = ?" ;
    BOOL isDeleted=[_fmdb executeUpdate:sql, dataDic[@"ID"]];
    if (isDeleted) {
        NSLog(@"删除成功");
    }
#if 0
   
#endif
}
//删除头像
-(void)deleteIconWithDic:(NSDictionary *)iconDic
{
    //删除头像
    NSString*iconSql=@"delete from icondb where icon = ?";
    BOOL isDeleteIcon=[_fmdb executeUpdate:iconSql,iconDic[@"icon"]];
    if (isDeleteIcon) {
        NSLog(@"删除头像成功");
    }
}

//查
-(void)searchDataWithDictionary:(NSDictionary*)dataDic
{
    NSString*sql=@"select applicationId from appdsb where ID = ?" ;
    
    [_fmdb executeUpdate:sql,dataDic[@"ID"]];
}
//显示数据库内所有收藏数据
-(NSArray*)receaveData
{
    NSString * sql = @"select * from appdsb" ;
    
    FMResultSet*set=[_fmdb executeQuery:sql];
    
    NSMutableArray*array=[NSMutableArray array];
    while ([set next]) {
        NSDictionary*dic=[set resultDictionary];
        [array addObject:dic];
    }
    return array;
}
//显示数据库内所有头像
-(NSArray *)receaveIcon
{
    NSString *iconSql=@"select * from icondb";
    FMResultSet *set=[_fmdb executeQuery:iconSql];
    NSMutableArray*array=[NSMutableArray array];
    while ([set next]) {
        NSDictionary*dic=[set resultDictionary];
        [array addObject:dic];
    }
    return array;
}


@end


