//
//  ImageButton.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageButton : NSObject{
    UIImage *image;
    UIButton *button;
}

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIButton *button;

-(id)initWithData: (UIImage *)i
      theButton: (UIButton *)b;

@end
