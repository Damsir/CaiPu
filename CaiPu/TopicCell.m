//
//  TopicCell.m
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopicCell.h"
#import "UIImageView+AFNetworking.h"

@interface TopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ImgV;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *accName;


@end

@implementation TopicCell


-(void)configUIWith:(shouYeInfo *)info
{
    [self.ImgV setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"]];
    
    self.titleName.backgroundColor=[UIColor clearColor];
    
    self.titleName.font=[UIFont systemFontOfSize:15.0];
    self.titleName.textColor=[UIColor whiteColor];
    self.titleName.text=[NSString stringWithFormat:@"   %@",info.title];
    self.bgView.backgroundColor=[UIColor blackColor];
    self.bgView.alpha=0.3;
    
    self.accName.text=[NSString stringWithFormat:@"   %@次浏览    %@次赞",info.views,info.likes];
    self.accName.font=[UIFont systemFontOfSize:12.0];
    self.accName.textColor=Main_Color;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
