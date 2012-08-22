//
//  AdviceView.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "AdviceView.h"

@implementation AdviceView

- (id) initWithFrame: (NSRect) frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self setAdvice: @"Foo."];
        
        adviceAttributes = [NSMutableDictionary dictionaryWithCapacity: 1];
    }
    return self;
}


- (void) drawRect: (NSRect) dirtyRect {
    [[NSColor windowBackgroundColor] set];
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    
    NSRect bounds = [self bounds];
    
    CGFloat left = 0.0;
    CGFloat right = bounds.size.width;
    CGFloat bottom = 0.0;
    CGFloat top = bounds.size.height;
    CGFloat radius = 25.0;
    CGFloat nearRight = right - radius;
    CGFloat nearBottom = bottom + radius;
    CGFloat nearTop = top - radius;
    
    NSRect textBounds = NSInsetRect(bounds, radius, radius);
    
    [path moveToPoint: NSMakePoint(left, bottom)];
    [path lineToPoint: NSMakePoint(nearRight, bottom)];
    [path appendBezierPathWithArcWithCenter: NSMakePoint(nearRight, nearBottom)
          radius: radius
          startAngle: -90.0
          endAngle: 0.0
          clockwise: NO];
    [path lineToPoint: NSMakePoint(right, nearTop)];
    [path appendBezierPathWithArcWithCenter: NSMakePoint(nearRight, nearTop)
          radius: radius
          startAngle: 0.0
          endAngle: 90.0
          clockwise: NO];
    [path lineToPoint: NSMakePoint(left, top)];
    [path lineToPoint: NSMakePoint(left, bottom)];
    [path closePath];
    
    [[NSColor colorWithDeviceWhite: 1.0 alpha: 0.5] set];
    [path fill];
    
    if([self advice]) {
        NSAttributedString *attributedString =
            [[NSAttributedString alloc] initWithString: [self advice]
                                        attributes: adviceAttributes];
        [attributedString drawInRect: textBounds];
    }
}

@end
