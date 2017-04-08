//
//  ReviewCell.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 08.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell{
    
    UILabel *headLabel;
    UILabel *dateLabel;
    UILabel *textLabel;
    
}

@property UILabel *headLabel;
@property UILabel *dateLabel;
@property UILabel *textLabel;

@end
