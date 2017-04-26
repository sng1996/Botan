//
//  Performer.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 09.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Performer : NSObject{
    NSInteger _id;
    NSString *name;
    UIColor *color;
    NSInteger cost;
    NSString *date;
    NSInteger rating;
}

@property NSInteger _id;
@property NSString *name;
@property UIColor *color;
@property NSInteger cost;
@property NSString *date;
@property NSInteger rating;

-(id)initWithData:(NSInteger)i
          theName:(NSString *)n
         theColor:(UIColor *)cl
          theCost:(NSInteger)c
          theDate:(NSString *)d
        theRating:(NSInteger)r;
@end
