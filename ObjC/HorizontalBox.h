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
    CGFloat _ascent;
    CGFloat _descent;
    CGFloat _baseWidth;
    CGFloat _stretch;
    CGFloat _shrink;
    CGFloat _justifiedWidth;
}

- (id) init;
- (CGFloat) height;
- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) width;
- (CGFloat) stretch;
- (CGFloat) shrink;
- (CGFloat) baseWidth;
- (CGFloat) justifiedWidth;
- (void) setJustifiedWidth: (CGFloat) justifiedWidth;
- (void) appendBox: (id <Box>) box;
- (void) appendGlue: (Glue *) glue;
- (void) draw: (NSPoint) origin;
@end
