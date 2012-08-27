//
//  DocumentView.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "DocumentView.h"
#import "Document.h"
#import "DocumentWindowController.h"
#import "ModernPresentation.h"

@implementation DocumentView

- (id) initWithFrame: (NSRect) frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


- (Document *) document {
    DocumentWindowController *documentWindowController =
        [self documentWindowController];
    if(!documentWindowController) return nil;
    return [documentWindowController document];
}


- (DocumentWindowController *) documentWindowController {
    NSWindow *window = [self window];
    if(!window) return nil;
    NSWindowController *windowController = [window windowController];
    if(!windowController) return nil;
    if(![windowController isKindOfClass: [DocumentWindowController class]])
        return nil;
    return (DocumentWindowController *) windowController;
}


- (void) drawRect: (NSRect) dirtyRect
{
    [[NSColor colorWithDeviceRed: 0.84 green: 0.87 blue: 8.90 alpha: 1.0] set];
    [NSBezierPath fillRect: dirtyRect];
    
    [self drawPresentation: [[self document] schemaPresentation]
    	  inRect: dirtyRect];
}


- (void) drawPresentation: (ModernPresentation *) presentation
		 inRect: (NSRect) dirtyRect
{
    NSString *string =
        [NSString stringWithFormat: @"%lu\nfoo",
            (unsigned long) [[[self document] schemaNodes] count]];
    NSDictionary *attributes = [NSDictionary dictionary];
    [string drawInRect: [self bounds]
            withAttributes: attributes];
    /*
    [[NSColor blackColor] set];
    [NSBezierPath setDefaultLineWidth: 10.0];
    [NSBezierPath strokeRect: [self bounds]];
    */
}


- (BOOL) acceptsFirstResponder {
    return YES;
}


- (void) keyDown: (NSEvent *) event {
    [[self documentWindowController] keyDown: event inDocumentView: self];
}

@end
