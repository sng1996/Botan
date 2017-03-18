//
//  Person.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 24.02.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSInteger _id;
    NSString *email;
    NSString *phone;
    NSString *name;
    NSString *password;
    NSMutableArray *orders;
    NSInteger rating;
    NSInteger balance;
    NSMutableArray *reviews;
    NSString *photo;
    NSInteger cost;
    NSString *date;
}

@property NSInteger _id;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSMutableArray *orders;
@property NSInteger rating;
@property NSInteger balance;
@property (nonatomic, strong) NSMutableArray *reviews;
@property (nonatomic, strong) NSString *photo;
@property NSInteger cost;
@property (nonatomic, strong) NSString *date;

-(id)initWithData:(NSInteger)i
            theEmail:(NSString *)e
            thePhone:(NSString *)p
             theName:(NSString *)n
         thePassword:(NSString *)pas
           theOrders:(NSMutableArray *)o
           theRating:(NSInteger)r
          theBalance:(NSInteger)b
          theReviews:(NSMutableArray *)rev
            thePhoto:(NSString *)ph
             theCost:(NSInteger)c
             theDate:(NSString *)d;
@end
