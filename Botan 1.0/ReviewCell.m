//
//  ReviewCell.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 08.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ReviewCell.h"

@implementation ReviewCell
@synthesize headLabel, dateLabel, textLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    
    if (self){
        
        headLabel = [[UILabel alloc] initWithFrame: CGRectMake(13, 6, 210, 18)];
        headLabel.textAlignment = NSTextAlignmentLeft;
        headLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
        headLabel.textColor = [UIColor colorWithRed:58.0f/255.0f green:57.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        
        
        dateLabel = [[UILabel alloc] initWithFrame: CGRectMake(13, 23, 100, 12)];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
        dateLabel.textColor = [UIColor colorWithRed:58.0f/255.0f green:57.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        
        //typeLabel.numberOfLines = 3;
        //typeLabel.minimumFontSize = 10;
        //typeLabel.adjustsFontSizeToFitWidth = YES;
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 41, 296, 29)];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
        textLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:169.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
        textLabel.numberOfLines = 2;

        
        [self.contentView addSubview:headLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:textLabel];
        
        
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
