//
//  VerticalBox.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"

@class Glue;
@interface VerticalBox : NSObject <Box> {
    NSMutableArray *_boxesAndGlue;
    CGFloat _width;
    CGFloat _stretch;
    CGFloat _shrink;
    CGFloat _baseHeight;
    CGFloat _packedHeight;
}

- (id) init;
- (CGFloat) height;
- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) width;
- (CGFloat) stretch;
- (CGFloat) shrink;
- (CGFloat) baseHeight;
- (CGFloat) packedHeight;
- (void) setPackedHeight: (CGFloat) packedHeight;
- (void) appendBox: (id <Box>) box;
- (void) appendGlue: (Glue *) glue;
- (void) draw: (NSPoint) origin;
@end
