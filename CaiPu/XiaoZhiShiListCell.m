//
//  XiaoZhiShiListCell.m
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "XiaoZhiShiListCell.h"


@interface XiaoZhiShiListCell ()
{
    UILabel*numLab;
    UILabel*titleLab;
}

@end

@implementation XiaoZhiShiListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        numLab=[[UILabel alloc] init];
        numLab.center=CGPointMake(25.0, 22.0);
        numLab.bounds=CGRectMake(0, 0, 30.0, 30.0);
        numLab.layer.cornerRadius=15.0;
        numLab.layer.masksToBounds=YES;
        numLab.backgroundColor=Main_Color;
        numLab.textColor=[UIColor whiteColor];
        numLab.textAlignment=NSTextAlignmentCenter;
        numLab.font=[UIFont systemFontOfSize:13.0];
        [self.contentView addSubview:numLab];
        
        titleLab=[[UILabel alloc] initWithFrame:CGRectMake(75.0, 0, Screen_W-75.0, 44.0)];
        titleLab.textAlignment=NSTextAlignmentJustified;
        [self.contentView addSubview:titleLab];
        
    }
    return self;
}

-(void)configUIWith:(shouYeInfo*)info
                and:(NSInteger)indexNum
{
    numLab.text=[NSString stringWithFormat:@"%ld",(long)indexNum];
    
    titleLab.text=info.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
