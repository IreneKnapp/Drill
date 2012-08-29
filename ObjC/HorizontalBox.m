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
        _adjustmentValid = NO;
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
    if(_packedWidth != packedWidth) _adjustmentValid = NO;
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
	
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
        	id <Box> box = (id <Box>) boxOrGlue;
        	
        	[box setPackedHeight: _packedHeight];
        }
    }
}


- (void) appendBox: (id <Box>) box {
    CGFloat boxAscent = [box ascent];
    CGFloat boxDescent = [box descent];
    CGFloat boxWidth = [box baseWidth];
    
    if(boxAscent > _ascent) _ascent = boxAscent;
    if(boxDescent > _descent) _descent = boxDescent;
    _baseWidth += boxWidth;
    
    [box setPackedWidth: [box baseWidth]];
    
	_adjustmentValid = NO;
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
	
	_adjustmentValid = NO;
    [_boxesAndGlue addObject: glue];
}


- (void) draw: (NSPoint) origin {
	if(!_adjustmentValid) [self recomputeAdjustment];
    
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
            id <Box> box = (id <Box>) boxOrGlue;
            
            [box draw: origin];
            
            origin.x += [box packedWidth];
        } else if([boxOrGlue isKindOfClass: [Glue class]]) {
            Glue *glue = (Glue *) boxOrGlue;
            
            if(![glue isInfinite]) {
                CGFloat base = [glue base];
                
            	if(_nInfiniteGlues == 0) {
					if(_adjustment > 0.0) {
						base += [glue stretch] * _adjustment;
					} else if(_adjustment < 0.0) {
						base += [glue shrink] * _adjustment;
					}
				}
				
                origin.x += base;
			} else {
				origin.x += _adjustment;
			}
        }
    }
}


- (void) recomputeAdjustment {
	_adjustmentValid = YES;
	
    _adjustment = _packedWidth - _baseWidth;
    if(_nInfiniteGlues == 0) {
		if(_adjustment > 0.0) {
			_adjustment /= _stretch;
		} else if(_adjustment < 0.0) {
			_adjustment /= _shrink;
		}
	} else {
	    _adjustment /= _nInfiniteGlues;
	}
}

@end
