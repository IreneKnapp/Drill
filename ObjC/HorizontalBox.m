//
//  HorizontalBox.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "HorizontalBox.h"
#import "Glue.h"

@implementation HorizontalBox

- (id) init {
    self = [super init];
    if(self) {
        _boxesAndGlue = [NSMutableArray arrayWithCapacity: 16];
        _nInfiniteGlues = 0;
        _ascent = 0.0;
        _descent = 0.0;
        _stretch = 0.0;
        _shrink = 0.0;
        _baseWidth = 0.0;
        _packedWidth = 0.0;
    }
    return self;
}


- (CGFloat) ascent {
    return _ascent;
}


- (CGFloat) descent {
    return _descent;
}


- (CGFloat) stretch {
    return _stretch;
}


- (CGFloat) shrink {
    return _shrink;
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


- (void) appendBox: (id <Box>) box {
    CGFloat boxAscent = [box ascent];
    CGFloat boxDescent = [box descent];
    CGFloat boxWidth = [box packedWidth];
    
    if(boxAscent > _ascent) _ascent = boxAscent;
    if(boxDescent > _descent) _descent = boxDescent;
    _baseWidth += boxWidth;
    
    [_boxesAndGlue addObject: box];
}


- (void) appendGlue: (Glue *) glue {
	if(![glue isInfinite]) {
		CGFloat glueWidth = [glue base];
		CGFloat glueStretch = [glue stretch];
		CGFloat glueShrink = [glue shrink];
		
		_baseWidth += glueWidth;
		_stretch += glueStretch;
		_shrink += glueShrink;
	} else {
		_nInfiniteGlues++;
	}
	    
    [_boxesAndGlue addObject: glue];
}


- (void) draw: (NSPoint) origin {
    CGFloat adjustment = _packedWidth - _baseWidth;
    if(_nInfiniteGlues == 0) {
		if(adjustment > 0.0) {
			adjustment /= _stretch;
		} else if(adjustment < 0.0) {
			adjustment /= _shrink;
		}
	}
    
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
            id <Box> box = (id <Box>) boxOrGlue;
            
            [box draw: origin];
            
            origin.x += [box packedWidth];
        } else if([boxOrGlue isKindOfClass: [Glue class]]) {
            Glue *glue = (Glue *) boxOrGlue;
            
            if(![glue isInfinite]) {
            	if(_nInfiniteGlues == 0) {
					CGFloat base = [glue base];
					if(adjustment > 0.0) {
						base += [glue stretch] * adjustment;
					} else if(adjustment < 0.0) {
						base += [glue shrink] * adjustment;
					}
					
					origin.x += base;
				}
			} else {
				origin.x += adjustment / _nInfiniteGlues;
			}
        }
    }
}

@end
