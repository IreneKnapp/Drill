//
//  PrimitiveBox.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box.h"

@interface PrimitiveBox : NSObject <Box> {
    CGFloat _ascent;
    CGFloat _descent;
    CGFloat _width;
    void (^_draw)(NSPoint origin);
}

- (id) initWithAscent: (CGFloat) ascent
       descent: (CGFloat) descent
       width: (CGFloat) width
       draw: (void (^)(NSPoint origin)) draw;
- (CGFloat) height;
- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) width;
- (void) draw: (NSPoint) origin;
@end
