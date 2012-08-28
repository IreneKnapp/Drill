//
//  Box.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Box <NSObject>

- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) baseWidth;
- (CGFloat) packedWidth;
- (void) setPackedWidth: (CGFloat) packedWidth;
- (CGFloat) baseHeight;
- (CGFloat) packedHeight;
- (void) setPackedHeight: (CGFloat) packedHeight;
- (void) draw: (NSPoint) origin;
@end
