//
//  AdviceView.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "AdviceView.h"
#import "Document.h"
#import "DocumentWindowController.h"

@implementation AdviceView

- (id) initWithCoder: (NSCoder *) coder {
    self = [super initWithCoder: coder];
    if(self) {
        adviceAttributes = [NSMutableDictionary dictionaryWithCapacity: 3];
        
        NSFont *font = [NSFont systemFontOfSize: 14.0];
        [adviceAttributes setObject: font forKey: NSFontAttributeName];
        
        NSShadow *shadow = [[NSShadow alloc] init];
        [shadow setShadowBlurRadius: 1.0];
        [shadow setShadowColor: [NSColor whiteColor]];
        [adviceAttributes setObject: shadow forKey: NSShadowAttributeName];
    }
    return self;
}


- (void) drawRect: (NSRect) dirtyRect {
    if(![self attachedWindow]) return;
    
    [[self window] invalidateShadow];
    
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
    
    [[NSColor colorWithDeviceWhite: 1.0 alpha: 0.95] set];
    [path fill];
    
    NSWindow *window = [self attachedWindow];
    if(!window) return;
    NSWindowController *windowController = [window windowController];
    if(!windowController
       || ![windowController isKindOfClass: [DocumentWindowController class]])
        return;
    NSArray *adviceItems = [(DocumentWindowController *) windowController adviceItems];
    
    NSStringDrawingOptions options =
        NSStringDrawingUsesLineFragmentOrigin
        | NSStringDrawingTruncatesLastVisibleLine;
    
    CGFloat textTop = top - radius;
    CGFloat textBottom = bottom + radius;
    CGFloat textLeft = left + radius;
    CGFloat textRight = right - radius;
    for(NSString *adviceItem in adviceItems) {
        NSAttributedString *attributedString =
            [[NSAttributedString alloc] initWithString: adviceItem
                                        attributes: adviceAttributes];
        
        NSSize textMaxSize = NSMakeSize(textRight - textLeft, textTop - textBottom);
        NSRect textBounds =
            [attributedString boundingRectWithSize: textMaxSize options: options];
        textBounds.origin.x = textLeft;
        textBounds.origin.y = textTop - textBounds.size.height;
        
        [attributedString drawWithRect: textBounds options: options];
        
        CGFloat lineHeight = [attributedString size].height;
        textTop -= textBounds.size.height + lineHeight / 2.0;
    }
}

@end
