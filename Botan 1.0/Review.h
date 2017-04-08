//
//  Review.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 08.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject {
    NSString *head;
    NSString *name;
    NSString *date;
    NSString *text;
}

@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *text;

-(id)initWithData:(NSString *)h
          theName:(NSString *)n
          theDate:(NSString *)d
          theText:(NSString *)t;
@end
