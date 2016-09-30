//
//  SetCell.m
//  CaiPu
//
//  Created by qianfeng on 15/11/26.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "SetCell.h"

@interface SetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImgV;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *huanCunLab;


@end

@implementation SetCell


-(void)configUIWithDic:(NSDictionary *)dic andIndex:(NSInteger)index andCache:(CGFloat)caches
{
    self.ImgV.image=[UIImage imageNamed:dic[@"img"]];
    
    self.nameLab.text=dic[@"name"];
    
    if (index==1) {
        self.huanCunLab.text=[NSString stringWithFormat:@"%.2fMB",caches];
    }
    else
    {
        self.huanCunLab.text=@"";
    }
    
    self.huanCunLab.textAlignment=NSTextAlignmentRight;
    self.huanCunLab.textColor=[UIColor grayColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
