//
//  Order.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize category, foto, description, cost, date, customer, performer, dateOrder, type, subject, _id, status;

-(id)initWithData:(NSInteger)i
      theCategory:(NSInteger)c
          theFoto:(NSMutableArray *)f
   theDiscription:(NSString *)d
          theCost:(NSInteger)cs
          theDate:(NSString *)dt
      theCustomer:(Person *)cus
     thePerformer:(Person *)p
     theDateOrder:(NSString *)dor
          theType:(NSInteger)t
       theSubject:(NSString *)s
        theStatus:(NSInteger)stat{
    
    if (self = [super init]){
        [self set_id:i];
        [self setCategory:c];
        [self setFoto:f];
        [self setDescription:d];
        [self setCost:cs];
        [self setDate:dt];
        [self setCustomer:cus];
        [self setPerformer:p];
        [self setDateOrder:dor];
        [self setType:t];
        [self setSubject:s];
        [self setStatus:stat];
    }
    return self;
    
}

@end
