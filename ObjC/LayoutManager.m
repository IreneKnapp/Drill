//
//  LayoutManager.m
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "LayoutManager.h"
#import "HorizontalBox.h"
#import "PrimitiveBox.h"
#import "VerticalBox.h"

@implementation LayoutManager

- (id) initWithPresentation: (ModernPresentation *) rootPresentation {
    self = [super init];
    if(self) {
        _rootPresentation = rootPresentation;
        _layoutValid = NO;
        _characterBufferCount = 0;
        _characterBufferCapacity = 1024;
        _characterBuffer = malloc(sizeof(unichar) * _characterBufferCapacity);
    }
    return self;
}


- (void) dealloc {
    free(_characterBuffer);
}


- (void) appendCharacters: (unichar *) characters count: (size_t) count {
    while(_characterBufferCount + count < _characterBufferCapacity) {
        _characterBufferCapacity *= 2;
        _characterBuffer =
            realloc(_characterBuffer,
                    sizeof(unichar) * _characterBufferCapacity);
    }
    memcpy(_characterBuffer + _characterBufferCount,
           characters,
           sizeof(unichar) * count);
    _characterBufferCount += count;
}


- (void) recomputeLayout {
	VerticalBox *verticalBox = [[VerticalBox alloc] init];
    HorizontalBox *horizontalBox = [[HorizontalBox alloc] init];
    BOOL ignore_spaces = YES;
    for(size_t i = 0; i < _characterBufferCount; i++) {
        unichar character = _characterBuffer[i];
        if(character == ' ') {
            if(!ignore_spaces) {
                ignore_spaces = YES;
            }
        } else if(character == '\n') {
        	[verticalBox appendBox: horizontalBox];
        	horizontalBox = [[HorizontalBox alloc] init];
            ignore_spaces = YES;
        } else {
            PrimitiveBox *primitiveBox =
                [[PrimitiveBox alloc] initWithAscent: 7.0
                                      descent: 2.0
                                      width: 6.0
                                      draw: ^(NSPoint origin) {
                                          NSRect bounds;
                                          bounds.origin.x = origin.x;
                                          bounds.origin.y = origin.y - 2.0;
                                          bounds.size.width = 6.0;
                                          bounds.size.height = 8.0;
                                          
                                          [[NSColor blackColor] set];
                                          [NSBezierPath strokeRect: bounds];
                                  }];
            [horizontalBox appendBox: primitiveBox];
            ignore_spaces = NO;
        }
    }
	[verticalBox appendBox: horizontalBox];
    
    _layoutValid = YES;
    _box = verticalBox;
}


- (void) draw: (NSRect) dirtyRect {
    [[NSColor colorWithDeviceRed: 0.84 green: 0.87 blue: 8.90 alpha: 1.0] set];
    [NSBezierPath fillRect: dirtyRect];
    
    if(!_layoutValid) [self recomputeLayout];
    
    if(_box) {
        NSPoint origin = NSMakePoint(0.0, [_box descent]);
        NSLog(@"drawing root at %lf, %lf", origin.x, origin.y);
        [_box draw: origin];
    }
}

@end
