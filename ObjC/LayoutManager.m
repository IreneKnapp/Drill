//
//  LayoutManager.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "LayoutManager.h"
#import "Glue.h"
#import "HorizontalBox.h"
#import "PrimitiveBox.h"
#import "VerticalBox.h"

@implementation LayoutManager

- (id) initWithPresentation: (ModernPresentation *) rootPresentation {
    self = [super init];
    if(self) {
        _rootPresentation = rootPresentation;
        _layoutValid = NO;
        _wrapWidth = 0.0;
        NSString *fontName = @"LucidaGrande";
        _font = CTFontCreateWithName((__bridge CFStringRef) fontName, 14.0, NULL);
        if(!_font) {
            NSLog(@"No font named %@.", fontName);
            return nil;
        }
        
        _characterBufferCount = 0;
        _characterBufferCapacity = 1024;
        _characterBuffer = malloc(sizeof(unichar) * _characterBufferCapacity);
        
        _glyphBufferCount = 0;
        _glyphBufferCapacity = 1024;
        _glyphBuffer = malloc(sizeof(CGGlyph) * _glyphBufferCapacity);
        
        _lineFragmentBufferCount = 0;
        _lineFragmentBufferCapacity = 128;
        
        size_t lineFragmentBufferSize =
            (sizeof(LayoutManagerLineFragment) * _lineFragmentBufferCapacity);
        _lineFragmentBuffer = malloc(lineFragmentBufferSize);
        
        size_t lineFragmentBoxBufferSize =
            sizeof(HorizontalBox *) * _lineFragmentBufferCapacity;
        _lineFragmentBoxBuffer =
            (HorizontalBox * __strong *)
            malloc(lineFragmentBoxBufferSize);
        bzero(_lineFragmentBoxBuffer, lineFragmentBoxBufferSize);
    }
    return self;
}


- (void) dealloc {
    free(_characterBuffer);
}


- (CGFloat) wrapWidth {
    return _wrapWidth;
}


- (void) setWrapWidth: (CGFloat) wrapWidth {
    if(_wrapWidth != wrapWidth) _layoutValid = NO;
    _wrapWidth = wrapWidth;
}


- (void) removeAllCharacters {
    _characterBufferCount = 0;
    _layoutValid = NO;
}


- (void) appendCharacters: (unichar *) characters count: (size_t) count {
    size_t characterBufferOriginalCapacity = _characterBufferCapacity;
    while(_characterBufferCount + count > _characterBufferCapacity) {
        _characterBufferCapacity *= 2;
    }
    if(_characterBufferCapacity != characterBufferOriginalCapacity) {
        _characterBuffer =
            realloc(_characterBuffer, sizeof(unichar) * _characterBufferCapacity);
    }
    memcpy(_characterBuffer + _characterBufferCount,
           characters,
           sizeof(unichar) * count);
    _characterBufferCount += count;
    _layoutValid = NO;
}


- (void) recomputeLayout {
    [self recomputeLineFragments];
    
    _verticalBox = [[VerticalBox alloc] init];
    _state = VerticalLayoutManagerState;
    
    size_t glyphOffset = 0;
    for(size_t lineFragmentOffset = 0;
        lineFragmentOffset < _lineFragmentBufferCount;
        lineFragmentOffset++)
    {
        LayoutManagerLineFragment *lineFragment =
            _lineFragmentBuffer + lineFragmentOffset;
        [self startLineFragment: lineFragmentOffset];
        
        for(size_t i = 0; i < lineFragment->glyphCount; i++) {
            CGGlyph glyph = _glyphBuffer[glyphOffset + i];
            [self emitPrimitiveBox: glyph];
            [self emitIntercharacterGlue];
        }
        
        [self endLineFragment: lineFragmentOffset];
        
        glyphOffset += lineFragment->glyphCount;
    }
    
    [_verticalBox setPackedHeight: [_verticalBox baseHeight]];
    
    _box = _verticalBox;
    _layoutValid = YES;
}


- (void) recomputeLineFragments {
    _lineFragmentBufferCount = 0;
    
    size_t lineFragmentOffset = 0;
    size_t glyphOffset = 0;
    for(size_t characterOffset = 0;
        characterOffset < _characterBufferCount;
        characterOffset++)
    {
        size_t lineFragmentBufferOriginalCapacity =
            _lineFragmentBufferCapacity;
        while(_lineFragmentBufferCount + 1 > _lineFragmentBufferCapacity) {
            _lineFragmentBufferCapacity *= 2;
        }
        if(_lineFragmentBufferCapacity != lineFragmentBufferOriginalCapacity)
        {
            _lineFragmentBuffer =
                realloc(_lineFragmentBuffer,
                        sizeof(LayoutManagerLineFragment)
                               * _lineFragmentBufferCapacity);
            _lineFragmentBoxBuffer = 
                (HorizontalBox * __strong *)
                realloc(_lineFragmentBoxBuffer,
                        sizeof(HorizontalBox *) * _lineFragmentBufferCapacity);
            bzero(_lineFragmentBoxBuffer + lineFragmentBufferOriginalCapacity,
                  sizeof(HorizontalBox *)
                  * (_lineFragmentBufferCapacity
                     - lineFragmentBufferOriginalCapacity));
        }
        
        _lineFragmentBufferCount++;
        
        _lineFragmentBuffer[lineFragmentOffset].textAlignment =
            LeftLayoutManagerTextAlignment;
        
        _lineFragmentBuffer[lineFragmentOffset].characterCount = 0;
        while((characterOffset < _characterBufferCount) &&
              (_characterBuffer[characterOffset] != '\n'))
        {
            _lineFragmentBuffer[lineFragmentOffset].characterCount++;
            characterOffset++;
        }
        
        size_t glyphBufferOriginalCapacity = _glyphBufferCapacity;
        while(glyphOffset + _lineFragmentBuffer[lineFragmentOffset].characterCount
              > _glyphBufferCapacity)
        {
            _glyphBufferCapacity *= 2;
        }
        if(_glyphBufferCapacity != glyphBufferOriginalCapacity) {
            _glyphBuffer =
                realloc(_glyphBuffer, sizeof(CGGlyph) * _glyphBufferCapacity);
        }
        
        CTFontGetGlyphsForCharacters
            (_font,
             _characterBuffer
             + (characterOffset - _lineFragmentBuffer[lineFragmentOffset].characterCount),
             _glyphBuffer + glyphOffset,
             _lineFragmentBuffer[lineFragmentOffset].characterCount);
        {
            size_t i;
            for(i = 0;
                _glyphBuffer[glyphOffset + i]
                && (i < _lineFragmentBuffer[lineFragmentOffset].characterCount);
                i++);
            _lineFragmentBuffer[lineFragmentOffset].glyphCount = i;
        }
        glyphOffset += _lineFragmentBuffer[lineFragmentOffset].glyphCount;
        
        if(characterOffset < _characterBufferCount)
            _lineFragmentBuffer[lineFragmentOffset].characterCount++;
        
        lineFragmentOffset++;
    }
}


- (void) startLineFragment: (size_t) lineFragmentOffset
{
    switch(_state) {
	case VerticalLayoutManagerState:
	    _horizontalBox = [[HorizontalBox alloc] init];
        _lineFragmentBoxBuffer[lineFragmentOffset] = _horizontalBox;
        
    case HorizontalLayoutManagerState:
        switch(_lineFragmentBuffer[lineFragmentOffset].textAlignment) {
        case CenterLayoutManagerTextAlignment:
        case RightLayoutManagerTextAlignment:
        	[_horizontalBox appendGlue: [[Glue alloc] initAsInfinite]];
        	break;
    	default: break;
        }
    	break;
    }
    
    _state = HorizontalLayoutManagerState;
}


- (void) endLineFragment: (size_t) lineFragmentOffset
{
    switch(_state) {
    case HorizontalLayoutManagerState:
        [_horizontalBox setPackedWidth: [_horizontalBox baseWidth]];
        [_horizontalBox setPackedHeight: [_horizontalBox baseHeight]];
        
        switch(_lineFragmentBuffer[lineFragmentOffset].textAlignment) {
        case LeftLayoutManagerTextAlignment:
        case CenterLayoutManagerTextAlignment:
        	[_horizontalBox appendGlue: [[Glue alloc] initAsInfinite]];
        	break;
        default: break;
        }
        
        [_verticalBox appendBox: _horizontalBox];
        break;
    default: break;
    }
    
    _state = VerticalLayoutManagerState;
}


- (void) emitPrimitiveBox: (CGGlyph) glyph {
    CGFloat ascent = CTFontGetAscent(_font);
    CGFloat descent = CTFontGetDescent(_font);
    
    CGSize advancesBuffer[1];
    CTFontGetAdvancesForGlyphs
        (_font,
         kCTFontHorizontalOrientation,
         &glyph,
         advancesBuffer,
         1);
    CGFloat advance = advancesBuffer[0].width;
    
    PrimitiveBox *primitiveBox =
        [[PrimitiveBox alloc] initWithAscent: ascent
                              descent: descent
                              width: advance
                              draw: ^(NSPoint origin) {
                                  CGPoint cgOrigin;
                                  cgOrigin.x = origin.x;
                                  cgOrigin.y = origin.y;
                                  
                                  CGContextRef cgContext =
                                    [[NSGraphicsContext currentContext]
                                       graphicsPort];
                                  
                                  CGContextSaveGState(cgContext);
                                  
                                  CGFontRef cgFont =
                                      CTFontCopyGraphicsFont(_font, NULL);
                                  
                                  CGAffineTransform cgMatrix;
                                  cgMatrix.a = 1.0;
                                  cgMatrix.b = 0.0;
                                  cgMatrix.c = 0.0;
                                  cgMatrix.d = 1.0;
                                  cgMatrix.tx = 0.0;
                                  cgMatrix.ty = 0.0;
                                  
                                  CGContextSetTextMatrix(cgContext, cgMatrix);
                                  CGContextSetFont(cgContext, cgFont);
                                  CGContextSetFontSize(cgContext, CTFontGetSize(_font));
                                  CGContextSetRGBFillColor(cgContext, 0.0, 0.0, 0.0, 1.0);
                                  CGContextShowGlyphsAtPositions(cgContext, &glyph, &origin, 1);
                                  
                                  CGFontRelease(cgFont);
                                  
                                  CGContextRestoreGState(cgContext);
                          }];
    
    switch(_state) {
    case HorizontalLayoutManagerState:
        [_horizontalBox appendBox: primitiveBox];
        break;
    default: break;
    }
}


- (void) emitIntercharacterGlue {
    Glue *glue = [[Glue alloc] initWithBase: 0.1
                               stretch: 0.1
                               shrink: 0.1];
    
    switch(_state) {
    case HorizontalLayoutManagerState:
        [_horizontalBox appendGlue: glue];
        break;
    default: break;
    }
}


- (void) draw: (NSRect) dirtyRect inBounds: (NSRect) bounds {
    [[NSColor colorWithDeviceRed: 0.84 green: 0.87 blue: 8.90 alpha: 1.0] set];
    [NSBezierPath fillRect: bounds];
    
    if(!_layoutValid) [self recomputeLayout];
    
    if(_box) {
        NSPoint origin;
        origin.x = bounds.origin.x;
        origin.y = bounds.origin.y + bounds.size.height
        		   - [_box packedHeight] + [_box descent];
        [_box draw: origin];
    }
}

@end
