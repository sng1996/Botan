//
//  FilterCell.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell
@synthesize label, label2, deleteBtn;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    
    if (self){
        label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:20];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 1;
        label.minimumFontSize = 10;
        label.adjustsFontSizeToFitWidth = YES;
        
        label2 = [[UILabel alloc] init];
        label2.textAlignment = NSTextAlignmentLeft;
        label2.font = [UIFont systemFontOfSize:12];
        label2.backgroundColor = [UIColor clearColor];
        label2.textColor = [UIColor grayColor];
        label2.numberOfLines = 1;
        label2.minimumFontSize = 10;
        label2.adjustsFontSizeToFitWidth = YES;
        
        deleteBtn = [[UIButton alloc] init];
        
        [self.contentView addSubview:label];
        [self.contentView addSubview:label2];
        [self.contentView addSubview:deleteBtn];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
