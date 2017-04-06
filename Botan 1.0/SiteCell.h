//
//  SiteCell.h
//  Vocabulary
//
//  Created by Сергей Гаврилко on 12.07.16.
//  Copyright © 2016 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SiteCell : UITableViewCell{
    AppDelegate *mainDelegate;
    UILabel *typeLabel;
    UILabel *subjectLabel;
    UILabel *beginDateLabel;
    UILabel *endDateLabel;
    UILabel *costLabel;
    UILabel *rubLbl;
}

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *costLabel;
@property (nonatomic, strong) UILabel *beginDateLabel;
@property (nonatomic, strong) UILabel *endDateLabel;
@property (nonatomic, strong) UILabel *rubLbl;


@end
