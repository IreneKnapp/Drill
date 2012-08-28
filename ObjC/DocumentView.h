//
//  DocumentView.h
//  Drill
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;
@class DocumentWindowController;
@class LayoutManager;
@class ModernPresentation;
@protocol Mode;
@interface DocumentView : NSView {
    LayoutManager *_schemaLayoutManager;
}
@property (strong, nonatomic) id <Mode> mode;

- (id) initWithFrame: (NSRect) frame;
- (Document *) document;
- (DocumentWindowController *) documentWindowController;
- (void) drawRect: (NSRect) dirtyRect;
- (BOOL) acceptsFirstResponder;
- (void) keyDown: (NSEvent *) event;
@end
