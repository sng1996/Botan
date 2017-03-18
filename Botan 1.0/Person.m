//
//  Person.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 24.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Person.h"

@implementation Person
@synthesize email, phone, name, password, orders, rating, balance, reviews, photo;

-(id)initWithData: (NSString *)e
         thePhone:(NSString *)p
          theName:(NSString *)n
      thePassword:(NSString *)pas
        theOrders:(NSMutableArray *)o
        theRating:(NSInteger)r
       theBalance:(NSInteger)b
       theReviews:(NSMutableArray *)rev
         thePhoto:(NSString *)ph
          theCost:(NSInteger)c
          theDate:(NSString *)d
{
    
    if (self = [super init]){
        [self setEmail:e];
        [self setPhone:p];
        [self setName:n];
        [self setPassword:pas];
        [self setOrders:o];
        [self setRating:r];
        [self setBalance:b];
        [self setReviews:rev];
        [self setPhoto:ph];
        [self setCost:c];
        [self setDate:d];
    }
    return self;
    
}


@end
