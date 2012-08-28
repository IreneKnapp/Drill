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
    	_isInfinite = NO;
    	_base = base;
    	_stretch = stretch;
    	_shrink = shrink;
    }
    return self;
}


- (id) initAsInfinite
{
    self = [super init];
    if(self) {
    	_isInfinite = YES;
    	_base = 0.0;
    	_stretch = INFINITY;
    	_shrink = 0.0;
    }
    return self;
}


- (BOOL) isInfinite {
	return _isInfinite;
}


- (CGFloat) base {
	return _base;
}


- (CGFloat) stretch {
	return _stretch;
}


- (CGFloat) shrink {
	return _shrink;
}

@end
