//
//  FilterCell.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterCell : UITableViewCell{
    UILabel *label;
    UILabel *label2;
    UIButton *deleteBtn;
}

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UIButton *deleteBtn;

@end
