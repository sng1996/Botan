//
//  Review.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 08.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Review.h"

@implementation Review
@synthesize head, name, date, text;

-(id)initWithData:(NSString *)h
          theName:(NSString *)n
          theDate:(NSString *)d
          theText:(NSString *)t{
    
    if (self = [super init]){
        [self setHead:h];
        [self setName:n];
        [self setDate:d];
        [self setText:t];
    }
    return self;
    
}

@end
