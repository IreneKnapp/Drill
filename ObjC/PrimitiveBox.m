//
//  PrimitiveBox.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "PrimitiveBox.h"

@implementation PrimitiveBox

- (id) initWithAscent: (CGFloat) ascent
       descent: (CGFloat) descent
       width: (CGFloat) width
       draw: (void (^)(NSPoint origin)) draw
{
    self = [super init];
    if(self) {
        _ascent = ascent;
        _descent = descent;
        _baseWidth = width;
        _draw = draw;
    }
    return self;
}


- (CGFloat) ascent {
    return _ascent;
}


- (CGFloat) descent {
    return _descent;
}


- (CGFloat) baseWidth {
    return _baseWidth;
}


- (CGFloat) packedWidth {
	return _packedWidth;
}


- (void) setPackedWidth: (CGFloat) packedWidth {
	_packedWidth = packedWidth;
}


- (CGFloat) baseHeight {
    return _ascent + _descent;
}


- (CGFloat) packedHeight {
	return _packedHeight;
}


- (void) setPackedHeight: (CGFloat) packedHeight {
	_packedHeight = packedHeight;
}


- (void) draw: (NSPoint) origin {
    _draw(origin);
}

@end
