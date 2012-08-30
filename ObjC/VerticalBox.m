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
        _nInfiniteGlues = 0;
        _stretch = 0.0;
        _shrink = 0.0;
        _baseWidth = 0.0;
        _packedWidth = 0.0;
        _baseHeight = 0.0;
        _packedHeight = 0.0;
        _adjustmentValid = NO;
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


- (CGFloat) baseWidth {
    return _baseWidth;
}


- (CGFloat) packedWidth {
	return _packedWidth;
}


- (void) setPackedWidth: (CGFloat) packedWidth {
	_packedWidth = packedWidth;
	
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
        	id <Box> box = (id <Box>) boxOrGlue;
        	
        	[box setPackedWidth: _packedWidth];
        }
    }
}


- (CGFloat) baseHeight {
	return _baseHeight;
}


- (CGFloat) packedHeight {
	return _packedHeight;
}


- (void) setPackedHeight: (CGFloat) packedHeight {
    if(_packedHeight != packedHeight) _adjustmentValid = NO;
	_packedHeight = packedHeight;
}


- (void) appendBox: (id <Box>) box {
    CGFloat boxHeight = [box packedHeight];
    CGFloat boxWidth = [box packedWidth];
    
    _baseHeight += boxHeight;
    if(boxWidth > _baseWidth) _baseWidth = boxWidth;
    
    [box setPackedHeight: [box baseHeight]];
    
	_adjustmentValid = NO;
    [_boxesAndGlue addObject: box];
}


- (void) appendGlue: (Glue *) glue {
	if(![glue isInfinite]) {
        CGFloat glueHeight = [glue base];
        CGFloat glueStretch = [glue stretch];
        CGFloat glueShrink = [glue shrink];
        
        _baseHeight += glueHeight;
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
    
    origin.y += _packedHeight;
    
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
            id <Box> box = (id <Box>) boxOrGlue;
            
            origin.y -= [box ascent];
            
            [box draw: origin];
            
            origin.y -= [box descent];
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
				
                origin.y -= base;
			} else {
				origin.y -= _adjustment;
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
