//
//  AdviceView.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AdviceView : NSView {
    NSMutableDictionary *adviceAttributes;
}
@property (strong, nonatomic) NSString *advice;

- (id) initWithFrame: (NSRect) frame;
- (void) drawRect: (NSRect) dirtyRect;
@end
