//
//  VerticalBox.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "VerticalBox.h"
#import "Glue.h"

@implementation VerticalBox

- (id) init {
    self = [super init];
    if(self) {
        _boxesAndGlue = [NSMutableArray arrayWithCapacity: 16];
        _stretch = 0.0;
        _shrink = 0.0;
        _baseWidth = 0.0;
        _packedWidth = 0.0;
        _baseHeight = 0.0;
        _packedHeight = 0.0;
    }
    return self;
}


- (CGFloat) ascent {
    return _packedHeight;
}


- (CGFloat) descent {
    return 0.0;
}


- (CGFloat) stretch {
    return _stretch;
}


- (CGFloat) shrink {
    return _shrink;
}


- (CGFloat) baseHeight {
	return _baseHeight;
}


- (CGFloat) packedHeight {
	return _packedHeight;
}


- (void) setPackedHeight: (CGFloat) packedHeight {
	_packedHeight = packedHeight;
}


- (CGFloat) baseWidth {
    return _baseWidth;
}


- (CGFloat) packedWidth {
	return _packedWidth;
}


- (void) setPackedWidth: (CGFloat) packedWidth {
	packedWidth = _packedWidth;
}


- (void) appendBox: (id <Box>) box {
    CGFloat boxHeight = [box packedHeight];
    CGFloat boxWidth = [box packedWidth];
    
    _baseHeight += boxHeight;
    if(boxWidth > _baseWidth) _baseWidth = boxWidth;
    
    [_boxesAndGlue addObject: box];
}


- (void) appendGlue: (Glue *) glue {
    CGFloat glueHeight = [glue base];
    CGFloat glueStretch = [glue stretch];
    CGFloat glueShrink = [glue shrink];
    
    _baseHeight += glueHeight;
    _stretch += glueStretch;
    _shrink += glueShrink;
    
    [_boxesAndGlue addObject: glue];
}


- (void) fixContentWidths {
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
        	id <Box> box = (id <Box>) boxOrGlue;
        	
        	[box setPackedWidth: _packedWidth];
        }
    }
}


- (void) draw: (NSPoint) origin {
    CGFloat adjustment = _packedHeight - _baseHeight;
    if(adjustment > 0.0) {
        adjustment /= _stretch;
    } else if(adjustment < 0.0) {
        adjustment /= _shrink;
    }
    
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
            id <Box> box = (id <Box>) boxOrGlue;
            
            [box draw: origin];
            
            origin.y -= [box packedHeight];
        } else if([boxOrGlue isKindOfClass: [Glue class]]) {
            Glue *glue = (Glue *) boxOrGlue;
            
            CGFloat base = [glue base];
            if(adjustment > 0.0) {
                base += [glue stretch] * adjustment;
            } else if(adjustment < 0.0) {
                base -= [glue shrink] * adjustment;
            }
            
            origin.y -= base;
        }
    }
}

@end
