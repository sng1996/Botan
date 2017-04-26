//
//  Message.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 23.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Message.h"

@implementation Message
@synthesize _id, is_my, order_id, message, date;

-(id)initWithData:(NSInteger)i
         theIs_my:(Boolean)my
      theOrder_id:(NSInteger)o
  theContact_name:(NSString *)c
       theMessage:(NSString *)m
          theDate:(NSString *)d{
    
    
    if (self = [super init]){
        [self set_id:i];
        [self setIs_my:my];
        [self setOrder_id:o];
        [self setContact_name:c];
        [self setMessage:m];
        [self setDate:d];
    }
    
    return self;
    
    
}


@end
