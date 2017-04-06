//
//  FilterCell.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell
@synthesize label;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    
    if (self){
        label = [[UILabel alloc] initWithFrame:CGRectMake(19, 10, 300, 19)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        label.textColor = [UIColor blackColor];//[UIColor colorWithRed:56.0f/255.0f green:188.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
        label.numberOfLines = 1;
        label.minimumFontSize = 10;
        label.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:label];

    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
