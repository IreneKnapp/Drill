//
//  Glue.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "Glue.h"

@implementation Glue

- (id) initWithBase: (CGFloat) base
       stretch: (CGFloat) stretch
       shrink: (CGFloat) shrink
{
    self = [super init];
    if(self) {
        [self setBase: base];
        [self setStretch: stretch];
        [self setShrink: shrink];
    }
    return self;
}

@end
