//
//  Performer.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Performer.h"

@implementation Performer
@synthesize _id, name, color, cost, date, rating;

-(id)initWithData:(NSInteger)i
          theName:(NSString *)n
         theColor:(UIColor *)cl
          theCost:(NSInteger)c
          theDate:(NSString *)d
        theRating:(NSInteger)r
{
    
    if (self = [super init]){
        [self set_id:i];
        [self setName:n];
        [self setColor:cl];
        [self setCost:c];
        [self setDate:d];
        [self setRating:r];
    }
    return self;
    
}


@end
