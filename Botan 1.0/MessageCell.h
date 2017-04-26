//
//  MessageCell.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 21.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell{
    
    UIView *avatarView;
    UILabel *avatarLbl;
    UILabel *nameLbl;
    UILabel *msgLbl;
    UILabel *dateLbl;
    
}

@property (nonatomic, strong) UIView *avatarView;
@property (nonatomic, strong) UILabel *avatarLbl;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *msgLbl;
@property (nonatomic, strong) UILabel *dateLbl;

@end
