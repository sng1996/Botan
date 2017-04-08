//
//  Order.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize science, foto, description, cost, beginDate, customer, performer, endDate, type, subject, _id, status;

-(id)initWithData:(NSInteger)i
      theScience:(NSInteger)c
          theFoto:(NSMutableArray *)f
   theDiscription:(NSString *)d
          theCost:(NSInteger)cs
     theBeginDate:(NSString *)bd
      theCustomer:(Person *)cus
     thePerformer:(Person *)p
     theEndDate:(NSString *)ed
          theType:(NSInteger)t
       theSubject:(NSString *)s
        theStatus:(NSInteger)stat{
    
    if (self = [super init]){
        [self set_id:i];
        [self setScience:c];
        [self setFoto:f];
        [self setDescription:d];
        [self setCost:cs];
        [self setBeginDate:bd];
        [self setCustomer:cus];
        [self setPerformer:p];
        [self setEndDate:ed];
        [self setType:t];
        [self setSubject:s];
        [self setStatus:stat];
    }
    return self;
    
}

@end
