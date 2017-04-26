//
//  PerformerCell.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "PerformerCell.h"

@implementation PerformerCell
@synthesize avatarLbl, avatarView, nameLbl, costLbl, dateLbl;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    
    if (self){
        
        avatarView = [[UIView alloc] initWithFrame:CGRectMake(12, 12, 42, 42)];
        avatarView.backgroundColor = [UIColor cyanColor];
        avatarView.layer.cornerRadius = 100;
        
        avatarLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
        avatarLbl.textAlignment = NSTextAlignmentCenter;
        avatarLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        avatarLbl.textColor = [UIColor whiteColor];
        [avatarView addSubview:avatarLbl];
        
        nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 200, 21)];
        nameLbl.textAlignment = NSTextAlignmentLeft;
        nameLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        nameLbl.textColor = [UIColor blackColor];
        
        costLbl = [[UILabel alloc] initWithFrame:CGRectMake(200, 19, 60, 23)];
        costLbl.textAlignment = NSTextAlignmentRight;
        costLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:19];
        costLbl.textColor = [UIColor colorWithRed:56.0/255.0f green:188.0/255.0f blue:156.0/255.0f alpha:1.0f];
        
        dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 37, 100, 17)];
        dateLbl.textAlignment = NSTextAlignmentLeft;
        dateLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        dateLbl.textColor = [UIColor colorWithRed:155.0/255.0f green:155.0/255.0f blue:155.0/255.0f alpha:1.0f];
        
        [self.contentView addSubview:avatarView];
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:costLbl];
        [self.contentView addSubview:dateLbl];
        
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
