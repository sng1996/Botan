//
//  ImageButton.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.03.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "ImageButton.h"

@implementation ImageButton

-(id)initWithData:(UIImage *)i
        theButton:(UIButton *)b{
    
    if (self = [super init]){
        [self setImage:i];
        [self setButton:b];
    }
    return self;
    
}


@end
