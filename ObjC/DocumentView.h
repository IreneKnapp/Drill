//
//  DocumentView.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Document;
@class DocumentWindowController;
@class ModernPresentation;
@protocol Mode;
@interface DocumentView : NSView
@property (strong, nonatomic) id <Mode> mode;

- (id) initWithFrame: (NSRect) frame;
- (Document *) document;
- (DocumentWindowController *) documentWindowController;
- (void) drawRect: (NSRect) dirtyRect;
- (void) drawPresentation: (ModernPresentation *) presentation
		 inRect: (NSRect) dirtyRect;
- (BOOL) acceptsFirstResponder;
- (void) keyDown: (NSEvent *) event;
@end
