//
//  DocumentWindowController.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "DocumentWindowController.h"
#import "AppDelegate.h"
#import "Document.h"

@implementation DocumentWindowController

- (id) init {
    self = [super initWithWindowNibName: @"Document"];
    if(self) {
    	[self saveNonFullScreenFrame];
    }
    return self;
}


- (void) saveNonFullScreenFrame {
	NSWindow *window = [self window];
	NSRect frame = [window frame];
	[self setSavedNonFullScreenFrame: frame];
}


- (void) windowDidResize: (NSNotification *) notification {
    NSWindow *window = [notification object];
    if([window isEqual: [[self document] mainWindow]]) {
        [(AppDelegate *) [NSApp delegate] showAdviceWithWindow: window];
    }
}


- (NSArray *) customWindowsToEnterFullScreenForWindow: (NSWindow *) window {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity: 2];
	[result addObject: window];
	[result addObject: [(AppDelegate *) [NSApp delegate] advicePanel]];
	return result;
}


- (void) window: (NSWindow *) windowIn
         startCustomAnimationToEnterFullScreenWithDuration:
             (NSTimeInterval) duration
{
	[self saveNonFullScreenFrame];
	
	NSWindow *window = windowIn;
	NSPanel *advicePanel =
		[(AppDelegate *) [NSApp delegate] advicePanel];
	NSWindowController *windowController = [window windowController];
	Document *document = [windowController document];
	
	NSRect newFrame = [[NSScreen mainScreen] frame];
	
	NSRect newAdviceFrame = [advicePanel frame];
	newAdviceFrame.origin.x =
		newFrame.origin.x + newFrame.size.width - newAdviceFrame.size.width;
	newAdviceFrame.origin.y =
		newFrame.origin.y + newFrame.size.height - newAdviceFrame.size.height;
    
	[NSAnimationContext runAnimationGroup:
						    ^(NSAnimationContext *animationContext)
	{
		[(AppDelegate *) [NSApp delegate] setInFullScreenTransition: YES];
    	[window removeChildWindow: advicePanel];
    	[document removeWindowController: windowController];
    	
		[animationContext setDuration: duration];
		[[window animator] setFrame: newFrame display: YES];
		[[advicePanel animator] setFrame: newAdviceFrame display: YES];
	} completionHandler: ^{
		[(AppDelegate *) [NSApp delegate] setInFullScreenTransition: NO];
    	[window addChildWindow: advicePanel ordered: NSWindowAbove];
		[document addWindowController: windowController];
	}];
}


- (NSArray *) customWindowsToExitFullScreenForWindow: (NSWindow *) window {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity: 2];
	[result addObject: window];
	[result addObject: [(AppDelegate *) [NSApp delegate] advicePanel]];
	return result;
}


- (void) window: (NSWindow *) windowIn
         startCustomAnimationToExitFullScreenWithDuration:
             (NSTimeInterval) duration
{
	NSWindow *window = windowIn;
	NSPanel *advicePanel =
		[(AppDelegate *) [NSApp delegate] advicePanel];
	NSWindowController *windowController = [window windowController];
	Document *document = [windowController document];
	
	NSRect newFrame = [self savedNonFullScreenFrame];
	
	NSRect newAdviceFrame = [advicePanel frame];
	newAdviceFrame.origin.x = newFrame.origin.x + newFrame.size.width;
	newAdviceFrame.origin.y =
		newFrame.origin.y + newFrame.size.height - newAdviceFrame.size.height;
	
	[NSAnimationContext runAnimationGroup:
						    ^(NSAnimationContext *animationContext)
	{
		[(AppDelegate *) [NSApp delegate] setInFullScreenTransition: YES];
    	[window removeChildWindow: advicePanel];
    	[document removeWindowController: windowController];
    	
		[animationContext setDuration: duration];
		[[window animator] setFrame: newFrame display: YES];
		[[advicePanel animator] setFrame: newAdviceFrame display: YES];
	} completionHandler: ^{
		[(AppDelegate *) [NSApp delegate] setInFullScreenTransition: NO];
    	[window addChildWindow: advicePanel ordered: NSWindowAbove];
		[document addWindowController: windowController];
	}];
}

@end
