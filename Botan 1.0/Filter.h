//
//  Filter.h
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 06.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filter : NSObject <NSCopying> {
    NSInteger science;
    NSInteger type;
    NSInteger sort;
    NSInteger sortSubject;
    NSInteger minCost;
    NSInteger maxCost;
}

@property NSInteger science;
@property NSInteger type;
@property NSInteger sort;
@property NSInteger sortSubject;
@property NSInteger minCost;
@property NSInteger maxCost;

-(id)initWithData:(NSInteger)sc
          theType:(NSInteger)t
          theSort:(NSInteger)s
   theSortSubject:(NSInteger)ss
       theMinCost:(NSInteger)min
       theMaxCost:(NSInteger)max;

-(id)copyWithZone:(NSZone *)zone;

@end
