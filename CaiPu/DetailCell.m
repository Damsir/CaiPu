//
//  DetailCell.m
//  CaiPu
//
//  Created by qianfeng on 15/11/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+AFNetworking.h"

@interface DetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *effect;

@end

@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)configUIWith:(shouYeInfo *)info
{
    [self.imgV setImageWithURL:[NSURL URLWithString:info.thumb] placeholderImage:[UIImage imageNamed:@"placeholder_Phone"]];
    
    self.titleName.text=info.title;
    self.titleName.font=[UIFont systemFontOfSize:13];
    self.titleName.textColor=[UIColor colorWithRed:0.288 green:0.473 blue:0.203 alpha:1.000];
    
    self.category.text=info.category;
    self.category.font=[UIFont systemFontOfSize:11];
    self.category.textColor=[UIColor grayColor];
    
    self.age.text=info.age;
    self.age.font=[UIFont systemFontOfSize:11];
    self.age.textColor=[UIColor grayColor];
    
    self.effect.text=info.effect;
    self.effect.font=[UIFont systemFontOfSize:11];
    self.effect.textColor=[UIColor grayColor];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
