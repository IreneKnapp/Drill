//
//  AppDelegate.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "AppDelegate.h"
#import "AdviceView.h"
#import "Command.h"
#import "Document.h"
#import "SchemaMode.h"

@implementation AppDelegate

- (void) applicationWillFinishLaunching: (NSNotification *) notification {
    _schemaMode = [[SchemaMode alloc] init];
}


- (void) applicationDidFinishLaunching: (NSNotification *) notification {
	[self setInFullScreenTransition: NO];
	
    [[self advicePanel] setOpaque: NO];
    [[self advicePanel] setBackgroundColor: [NSColor clearColor]];
    [[self advicePanel] setLevel: NSFloatingWindowLevel];
    
    NSNotificationCenter *notificationCenter =
        [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver: self
                        selector: @selector(hideAdviceWithNotification:)
                        name: NSWindowDidResignMainNotification
                        object: nil];
    [notificationCenter addObserver: self
                        selector: @selector(showAdviceWithNotification:)
                        name: NSWindowDidBecomeMainNotification
                        object: nil];
}


- (void) applicationDidBecomeActive: (NSNotification *) notification {
    NSWindow *window = [NSApp mainWindow];
    if(window) [self showAdviceWithWindow: window];
}


- (void) hideAdviceWithNotification: (NSNotification *) notification {
	[self hideAdvice];
}


- (void) hideAdvice {
    [[self advicePanel] orderOut: self];
}


- (void) showAdviceWithNotification: (NSNotification *) notification {
    NSWindow *window = [NSApp mainWindow];
    if(window) [self showAdviceWithWindow: window];
}


- (void) showAdviceWithWindow: (NSWindow *) window {
	NSWindowController *windowController = [window windowController];
	if(!windowController) return;
	
	NSDocument *document = [windowController document];
	if(!document) return;
	
	NSPanel *panel = [self advicePanel];
	
    if(![self inFullScreenTransition]) {
		NSRect windowFrame = [window contentRectForFrameRect: [window frame]];
		
		NSRect adviceFrame = [panel frame];
		adviceFrame.origin.x = windowFrame.origin.x + windowFrame.size.width;
		adviceFrame.origin.y = windowFrame.origin.y + windowFrame.size.height
			- adviceFrame.size.height;
		
		if(([window styleMask] & NSFullScreenWindowMask)
		   == NSFullScreenWindowMask)
		{
			adviceFrame.origin.x -= adviceFrame.size.width;
		}
		
		[panel setFrame: adviceFrame display: NO];
    	[window addChildWindow: panel ordered: NSWindowAbove];
		[document addWindowController: windowController];
		[[self adviceView] setAttachedWindow: window];
		[[self adviceView] setNeedsDisplay: YES];
    }
}


- (void) adviceNeedsDisplay {
    [[self adviceView] setNeedsDisplay: YES];
}


- (id <Mode>) schemaMode {
    return _schemaMode;
}

@end
