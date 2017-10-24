//
//  Cat.m
//  Cats
//
//  Created by Carlo Namoca on 2017-10-23.
//  Copyright © 2017 Carlo Namoca. All rights reserved.
//

#import "Cat.h"

@implementation Cat

-(instancetype)initWithInfo:(NSDictionary*)infoDict
{
    self = [super init];
    if (self)
    {
        _catID = [infoDict[@"id"] integerValue];
        _owner = infoDict[@"owner"];
        _secret = infoDict[@"secret"];
        _server = [infoDict[@"server"] integerValue];
        _farm = [infoDict[@"farm"] integerValue];
        _title = infoDict[@"title"];
    }
    return self;
}


@end
