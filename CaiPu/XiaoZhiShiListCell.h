//
//  XiaoZhiShiListCell.h
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shouYeModel.h"

@interface XiaoZhiShiListCell : UITableViewCell
-(void)configUIWith:(shouYeInfo*)info
                and:(NSInteger)indexNum;
@end
