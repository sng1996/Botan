//
//  Filter.m
//  Botan 1.0
//
//  Created by Сергей Гаврилко on 06.04.17.
//  Copyright © 2017 Сергей Гаврилко. All rights reserved.
//

#import "Filter.h"

@implementation Filter
@synthesize science, type, sort, sortSubject, minCost, maxCost;

-(id)initWithData:(NSInteger)sc
          theType:(NSInteger)t
          theSort:(NSInteger)s
   theSortSubject:(NSInteger)ss
       theMinCost:(NSInteger)min
       theMaxCost:(NSInteger)max
{
    
    if (self = [super init]){
        [self setScience:sc];
        [self setType:t];
        [self setSort:s];
        [self setSortSubject:ss];
        [self setMinCost:min];
        [self setMaxCost:max];
    }
    return self;
    
}


@end
