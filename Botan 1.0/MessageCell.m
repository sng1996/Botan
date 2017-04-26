//
//  MessageCell.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 21.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
@synthesize avatarLbl, avatarView, nameLbl, msgLbl, dateLbl;

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
        
        msgLbl = [[UILabel alloc] initWithFrame:CGRectMake(70, 38, 220, 17)];
        msgLbl.textAlignment = NSTextAlignmentLeft;
        msgLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        msgLbl.textColor = [UIColor blackColor];
        
        dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(200, 4, 110, 17)];
        dateLbl.textAlignment = NSTextAlignmentRight;
        dateLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
        dateLbl.textColor = [UIColor colorWithRed:155.0/255.0f green:155.0/255.0f blue:155.0/255.0f alpha:1.0f];
        
        [self.contentView addSubview:avatarView];
        [self.contentView addSubview:nameLbl];
        [self.contentView addSubview:msgLbl];
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
