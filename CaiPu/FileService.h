//
//  FileService.h
//  CaiPu
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileService : NSObject
//计算单个文件夹的大小
+(float)fileSizeAtPath:(NSString *)path;
//计算目录的大小
+(float)folderSizeAtPath:(NSString *)path;
//清空缓存
+(void)clearCache:(NSString *)path;

@end
