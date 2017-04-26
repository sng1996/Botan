//
//  Message.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    NSInteger _id;
    Boolean is_my;
    NSInteger order_id;
    NSString *contact_name;
    NSString *message;
    NSString *date;
}

@property NSInteger _id;
@property Boolean is_my;
@property NSInteger order_id;
@property (nonatomic, strong) NSString *contact_name;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *date;

-(id)initWithData:(NSInteger)i
         theIs_my:(Boolean)my
      theOrder_id:(NSInteger)o
  theContact_name:(NSString *)c
       theMessage:(NSString *)m
          theDate:(NSString *)d;
@end
