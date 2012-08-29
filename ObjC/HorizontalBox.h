//
//  HorizontalBox.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"

@class Glue;
@interface HorizontalBox : NSObject <Box> {
    NSMutableArray *_boxesAndGlue;
    NSUInteger _nInfiniteGlues;
    CGFloat _ascent;
    CGFloat _descent;
    CGFloat _baseWidth;
    CGFloat _stretch;
    CGFloat _shrink;
    CGFloat _packedWidth;
    CGFloat _packedHeight;
    BOOL _adjustmentValid;
    CGFloat _adjustment;
}

- (id) init;
- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) stretch;
- (CGFloat) shrink;
- (CGFloat) baseWidth;
- (CGFloat) packedWidth;
- (void) setPackedWidth: (CGFloat) packedWidth;
- (CGFloat) baseHeight;
- (CGFloat) packedHeight;
- (void) setPackedHeight: (CGFloat) packedHeight;
- (void) appendBox: (id <Box>) box;
- (void) appendGlue: (Glue *) glue;
- (void) draw: (NSPoint) origin;
- (void) recomputeAdjustment;
@end
