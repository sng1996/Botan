//
//  SiteCell.m
//  Vocabulary
//
//  Created by Сергей Гаврилко on 12.07.16.
//  Copyright © 2016 Сергей Гаврилко. All rights reserved.
//

#import "SiteCell.h"
#import "ViewController.h"

@implementation SiteCell

@synthesize typeLabel, subjectLabel, imageView, dateLabel, costLabel, descriptLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    
    if (self){
        imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.png"]];
        
        typeLabel = [[UILabel alloc] init];
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.font = [UIFont systemFontOfSize:10];
        typeLabel.font = [UIFont fontWithName:@"Gurmukhi MN" size:10];
        typeLabel.backgroundColor = [UIColor clearColor];
        typeLabel.textColor = [UIColor blackColor];
        typeLabel.numberOfLines = 1;
        typeLabel.minimumFontSize = 10;
        typeLabel.adjustsFontSizeToFitWidth = YES;
        
        descriptLabel = [[UILabel alloc] init];
        descriptLabel.textAlignment = NSTextAlignmentLeft;
        descriptLabel.font = [UIFont systemFontOfSize:8];
        descriptLabel.font = [UIFont fontWithName:@"Gurmukhi MN" size:10];
        descriptLabel.backgroundColor = [UIColor clearColor];
        descriptLabel.textColor = [UIColor blackColor];
        descriptLabel.numberOfLines = 3;
        descriptLabel.minimumFontSize = 10;
        descriptLabel.adjustsFontSizeToFitWidth = YES;
        
        subjectLabel = [[UILabel alloc] init];
        subjectLabel.textAlignment = NSTextAlignmentLeft;
        subjectLabel.font = [UIFont systemFontOfSize:15];
        subjectLabel.font = [UIFont fontWithName:@"Gurmukhi MN" size:15];
        subjectLabel.backgroundColor = [UIColor clearColor];
        subjectLabel.textColor = [UIColor blackColor];
        subjectLabel.numberOfLines = 1;
        subjectLabel.minimumFontSize = 10;
        subjectLabel.adjustsFontSizeToFitWidth = YES;
        
        dateLabel = [[UILabel alloc] init];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.font = [UIFont systemFontOfSize:10];
        dateLabel.font = [UIFont fontWithName:@"Gurmukhi MN" size:10];
        dateLabel.backgroundColor = [UIColor clearColor];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.numberOfLines = 1;
        dateLabel.minimumFontSize = 10;
        dateLabel.adjustsFontSizeToFitWidth = YES;
        
        costLabel = [[UILabel alloc] init];
        costLabel.textAlignment = NSTextAlignmentCenter;
        costLabel.font = [UIFont systemFontOfSize:15];
        costLabel.font = [UIFont fontWithName:@"Gurmukhi MN" size:15];
        costLabel.backgroundColor = [UIColor clearColor];
        costLabel.textColor = [UIColor blackColor];
        costLabel.numberOfLines = 1;
        costLabel.minimumFontSize = 10;
        costLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:imageView];
        [self.contentView addSubview:typeLabel];
        [self.contentView addSubview:subjectLabel];
        [self.contentView addSubview:dateLabel];
        [self.contentView addSubview:costLabel];
        [self.contentView addSubview:descriptLabel];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
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
