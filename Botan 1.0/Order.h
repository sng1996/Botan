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
    NSInteger category;
    NSMutableArray *foto;
    NSString *description;
    NSInteger cost;
    NSString *date;
    Person *customer;
    Person *performer;
    NSString *dateOrder;
    NSInteger type;
    NSString *subject;
    NSInteger status;
}

@property NSInteger _id;
@property NSInteger category;
@property (nonatomic, strong) NSMutableArray *foto;
@property (nonatomic, strong) NSString *description;
@property NSInteger cost;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) Person *customer;
@property (nonatomic, strong) Person *performer;
@property (nonatomic, strong) NSString *dateOrder;
@property NSInteger type;
@property (nonatomic, strong) NSString *subject;
@property NSInteger status;

-(id)initWithData: (NSInteger)i
         theCategory: (NSInteger)c
         theFoto:(NSMutableArray *)f
         theDescription:(NSString *)d
         theCost:(NSInteger)cs
         theDate:(NSString *)dt
         theCustomer:(Person *)cus
         thePerformer:(Person *)p
         theDateOrder:(NSString *)dor
         theType:(NSInteger)t
         theSubject:(NSString *)s
         theStatus:(NSInteger)stat;

@end
