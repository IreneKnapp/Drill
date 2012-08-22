//
//  DocumentView.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "DocumentView.h"

@implementation DocumentView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) drawRect: (NSRect) dirtyRect
{
    [[NSColor redColor] set];
    [NSBezierPath fillRect: dirtyRect];
}

@end
