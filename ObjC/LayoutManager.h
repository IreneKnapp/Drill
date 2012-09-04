//
//  LayoutManager.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Glue;
@class HorizontalBox;
@class ModernPresentation;
@class VerticalBox;
@protocol Box;

typedef enum {
    LeftLayoutManagerTextAlignment,
    CenterLayoutManagerTextAlignment,
    RightLayoutManagerTextAlignment,
    JustifyLayoutManagerTextAlignment,
} LayoutManagerTextAlignment;

typedef struct {
    size_t characterCount;
    size_t glyphCount;
    LayoutManagerTextAlignment textAlignment;
} LayoutManagerLineFragment;

typedef enum {
    VerticalLayoutManagerState,
    HorizontalLayoutManagerState,
} LayoutManagerState;

@interface LayoutManager : NSObject {
    ModernPresentation *_rootPresentation;
    BOOL _layoutValid;
    CGFloat _wrapWidth;
    CTFontRef _font;
    
    size_t _characterBufferCount;
    size_t _characterBufferCapacity;
    unichar *_characterBuffer;
    
    size_t _glyphBufferCount;
    size_t _glyphBufferCapacity;
    CGGlyph *_glyphBuffer;
    
    size_t _lineFragmentBufferCount;
    size_t _lineFragmentBufferCapacity;
    LayoutManagerLineFragment *_lineFragmentBuffer;
    HorizontalBox * __strong *_lineFragmentBoxBuffer;
    
    LayoutManagerState _state;
    VerticalBox *_verticalBox;
    HorizontalBox *_horizontalBox;
    
    id <Box> _box;
}

- (id) initWithPresentation: (ModernPresentation *) rootPresentation;
- (void) dealloc;
- (CGFloat) wrapWidth;
- (void) setWrapWidth: (CGFloat) wrapWidth;
- (void) removeAllCharacters;
- (void) appendCharacters: (unichar *) characters count: (size_t) count;
- (void) recomputeLayout;
- (void) recomputeLineFragments;
- (void) startLineFragment: (size_t) lineFragmentOffset;
- (void) endLineFragment: (size_t) lineFragmentOffset;
- (void) emitPrimitiveBox: (CGGlyph) glyph;
- (void) emitIntercharacterGlue;
- (void) draw: (NSRect) dirtyRect inBounds: (NSRect) bounds;
@end
