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

@synthesize typeLabel, subjectLabel, beginDateLabel, endDateLabel, costLabel, rubLbl;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier: reuseIdentifier];
    mainDelegate = (AppDelegate *)[[ UIApplication sharedApplication] delegate];
    
    if (self){
        
        subjectLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 6, 0.7*mainDelegate.viewWidth, 21)];
        subjectLabel.textAlignment = NSTextAlignmentLeft;
        subjectLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
        subjectLabel.textColor = [UIColor colorWithRed:58.0f/255.0f green:57.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        
        
        typeLabel = [[UILabel alloc] initWithFrame: CGRectMake(10, 27, 0.7*self.contentView.frame.size.width, 14)];
        typeLabel.textAlignment = NSTextAlignmentLeft;
        typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
        typeLabel.textColor = [UIColor colorWithRed:58.0f/255.0f green:57.0f/255.0f blue:66.0f/255.0f alpha:1.0f];
        
        //typeLabel.numberOfLines = 3;
        //typeLabel.minimumFontSize = 10;
        //typeLabel.adjustsFontSizeToFitWidth = YES;
        
        beginDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 53, 50, 12)];
        beginDateLabel.textAlignment = NSTextAlignmentLeft;
        beginDateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
        beginDateLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:169.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
        
        endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*mainDelegate.viewWidth, 53, 0.3*mainDelegate.viewWidth - 9, 12)];
        endDateLabel.textAlignment = NSTextAlignmentRight;
        endDateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:9];
        endDateLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:169.0f/255.0f blue:171.0f/255.0f alpha:1.0f];
        
        costLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.7*mainDelegate.viewWidth, 6, 0.3*mainDelegate.viewWidth - 27, 23)];
        costLabel.textAlignment = NSTextAlignmentRight;
        costLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        costLabel.textColor = [UIColor colorWithRed:56.0f/255.0f green:188.0f/255.0f blue:156.0f/255.0f alpha:1.0f];        
        rubLbl = [[UILabel alloc] initWithFrame:CGRectMake(mainDelegate.viewWidth - 27, 6, 18, 23)];
        rubLbl.textAlignment = NSTextAlignmentRight;
        rubLbl.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        rubLbl.textColor = [UIColor colorWithRed:56.0f/255.0f green:188.0f/255.0f blue:156.0f/255.0f alpha:1.0f];
        rubLbl.text = @"₽";
        
        NSLog(@"%f", mainDelegate.viewWidth);
        
        [self.contentView addSubview:typeLabel];
        [self.contentView addSubview:subjectLabel];
        [self.contentView addSubview:beginDateLabel];
        [self.contentView addSubview:endDateLabel];
        [self.contentView addSubview:costLabel];
        [self.contentView addSubview:rubLbl];

        
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
