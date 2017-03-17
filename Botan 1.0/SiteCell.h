//
//  SiteCell.h
//  Vocabulary
//
//  Created by Сергей Гаврилко on 12.07.16.
//  Copyright © 2016 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteCell : UITableViewCell{
    UILabel *typeLabel;
    UILabel *subjectLabel;
    UILabel *dateLabel;
    UILabel *costLabel;
    UILabel *descriptLabel;
    UIImageView *imageView;
}

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UILabel *descriptLabel;

@end
