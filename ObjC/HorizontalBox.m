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
        _ascent = 0.0;
        _descent = 0.0;
        _stretch = 0.0;
        _shrink = 0.0;
        _baseWidth = 0.0;
        _justifiedWidth = 0.0;
    }
    return self;
}


- (CGFloat) height {
    return _ascent + _descent;
}


- (CGFloat) ascent {
    return _ascent;
}


- (CGFloat) descent {
    return _descent;
}


- (CGFloat) width {
    return _justifiedWidth;
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


- (CGFloat) justifiedWidth {
    return _justifiedWidth;
}


- (void) setJustifiedWidth: (CGFloat) justifiedWidth {
    _justifiedWidth = justifiedWidth;
}


- (void) appendBox: (id <Box>) box {
    CGFloat boxAscent = [box ascent];
    CGFloat boxDescent = [box descent];
    CGFloat boxWidth = [box width];
    
    if(boxAscent > _ascent) _ascent = boxAscent;
    if(boxDescent > _descent) _descent = boxDescent;
    _baseWidth += boxWidth;
    
    [_boxesAndGlue addObject: box];
}


- (void) appendGlue: (Glue *) glue {
    CGFloat glueWidth = [glue base];
    CGFloat glueStretch = [glue stretch];
    CGFloat glueShrink = [glue shrink];
    
    _baseWidth += glueWidth;
    _stretch += glueStretch;
    _shrink += glueShrink;
    
    [_boxesAndGlue addObject: glue];
}


- (void) draw: (NSPoint) origin {
    NSLog(@"drawing hbox at %lf, %lf", origin.x, origin.y);
    CGFloat adjustment = _justifiedWidth - _baseWidth;
    if(adjustment > 0.0) {
        adjustment /= _stretch;
    } else if(adjustment < 0.0) {
        adjustment /= _shrink;
    }
    
    for(id boxOrGlue in _boxesAndGlue) {
        if([boxOrGlue conformsToProtocol: @protocol(Box)]) {
            id <Box> box = (id <Box>) boxOrGlue;
            
            [box draw: origin];
            
            origin.x += [box width];
        } else if([boxOrGlue isKindOfClass: [Glue class]]) {
            Glue *glue = (Glue *) boxOrGlue;
            
            CGFloat base = [glue base];
            if(adjustment > 0.0) {
                base += [glue stretch] * adjustment;
            } else if(adjustment < 0.0) {
                base -= [glue shrink] * adjustment;
            }
            
            origin.x += base;
        }
    }
}

@end
