//
//  Box.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Box <NSObject>

- (CGFloat) height;
- (CGFloat) ascent;
- (CGFloat) descent;
- (CGFloat) width;
- (void) draw: (NSPoint) origin;
@end
