//
//  Order.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 15.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface Order : NSObject{
    NSInteger _id;
    NSInteger science;
    NSMutableArray *foto;
    NSString *description;
    NSInteger cost;
    NSString *beginDate;
    Person *customer;
    Person *performer;
    NSString *endDate;
    NSInteger type;
    NSString *subject;
    NSInteger status;
}

@property NSInteger _id;
@property NSInteger science;
@property (nonatomic, strong) NSMutableArray *foto;
@property (nonatomic, strong) NSString *description;
@property NSInteger cost;
@property (nonatomic, strong) NSString *beginDate;
@property (nonatomic, strong) Person *customer;
@property (nonatomic, strong) Person *performer;
@property (nonatomic, strong) NSString *endDate;
@property NSInteger type;
@property (nonatomic, strong) NSString *subject;
@property NSInteger status;

-(id)initWithData: (NSInteger)i
         theScience: (NSInteger)c
         theFoto:(NSMutableArray *)f
         theDescription:(NSString *)d
         theCost:(NSInteger)cs
         theBeginDate:(NSString *)bd
         theCustomer:(Person *)cus
         thePerformer:(Person *)p
         theEndDate:(NSString *)ed
         theType:(NSInteger)t
         theSubject:(NSString *)s
         theStatus:(NSInteger)stat;

@end
