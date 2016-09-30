//
//  ShouYeTableViewCell.m
//  CaiPu
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ShouYeTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface ShouYeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation ShouYeTableViewCell

-(void)configUIWith:(shouYeInfo *)info
{
    [self.imgV setImageWithURL:[NSURL URLWithString:info.thumb_2] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"]];
    
    self.titleName.backgroundColor=[UIColor clearColor];

    self.titleName.font=[UIFont systemFontOfSize:15];
    self.titleName.textColor=[UIColor whiteColor];
    self.titleName.text=[NSString stringWithFormat:@"   %@",info.title];
    self.bgView.backgroundColor=[UIColor blackColor];
    self.bgView.alpha=0.3;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
