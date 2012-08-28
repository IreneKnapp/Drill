//
//  AdviceView.h
//  Drill
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AdviceView : NSView {
    NSMutableDictionary *adviceAttributes;
}
@property (strong, nonatomic) NSWindow *attachedWindow;

- (id) initWithCoder: (NSCoder *) coder;
- (void) drawRect: (NSRect) dirtyRect;
@end
