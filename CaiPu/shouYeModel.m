//
//  shouYeModel.m
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "shouYeModel.h"

@implementation shouYeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"results":@"shouYeInfo",@"list":@"shouYeInfo"};
}

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"list":@"tlist[0].list"};
}
@end

@implementation shouYeInfo
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
