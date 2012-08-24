//
//  DocumentWindowController.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "DocumentWindowController.h"
#import "AppDelegate.h"
#import "Command.h"
#import "Document.h"
#import "DocumentView.h"

@implementation DocumentWindowController

- (id) initWithMode: (id <Mode>) mode {
    self = [super initWithWindowNibName: @"Document"];
    if(self) {
    	[self saveNonFullScreenFrame];
    	[self setAdviceItems: [NSMutableArray arrayWithCapacity: 32]];
    	[[self documentView] setMode: mode];
        [self updateDocumentViewSize];
        
        NSNotificationCenter *notificationCenter =
            [NSNotificationCenter defaultCenter];
        [notificationCenter addObserver: self
                            selector:
                              @selector(updateDocumentViewSizeWithNotification:)
                            name: NSViewFrameDidChangeNotification
                            object: [self scrollView]];
    }
    return self;
}


- (void) saveNonFullScreenFrame {
	NSWindow *window = [self window];
	NSRect frame = [window frame];
	[self setSavedNonFullScreenFrame: frame];
	[self setSavedNonFullScreenStyleMask: [window styleMask]];
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
		[window setFrame: newFrame display: NO];
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
	
	NSRect newFrame =
		[NSWindow contentRectForFrameRect: [self savedNonFullScreenFrame]
				  styleMask: [self savedNonFullScreenStyleMask]];
	
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
    	[advicePanel orderWindow: NSWindowAbove
    				 relativeTo: [window windowNumber]];
    	
		[animationContext setDuration: duration];
		[[window animator] setFrame: newFrame display: YES];
		[[advicePanel animator] setFrame: newAdviceFrame display: YES];
	} completionHandler: ^{
		[(AppDelegate *) [NSApp delegate] setInFullScreenTransition: NO];
    	[window addChildWindow: advicePanel ordered: NSWindowAbove];
		[document addWindowController: windowController];
		[window setFrame: [window frameRectForContentRect: newFrame]
				display: NO];
	}];
}


- (void) updateAdvice {
    DocumentView *documentView = [self documentView];
    id <Mode> mode = [documentView mode];
    
    [[self adviceItems] removeAllObjects];
    
    for(NSString *item in [mode adviceHeaderItems: documentView]) {
        [[self adviceItems] addObject: item];
    }
    
    for(Command *command in [mode availableCommands: documentView]) {
        NSString *keystroke = [command characters];
        
        if([keystroke isEqualToString: @"\x1B"])
            keystroke = @"esc";
        
        [[self adviceItems] addObject:
            [NSString stringWithFormat: @"%@\t%@",
                keystroke, [command headline: [self documentView]]]];
    }
    
    for(NSString *item in [mode adviceFooterItems: documentView]) {
        [[self adviceItems] addObject: item];
    }
}


- (void) windowWillClose: (NSNotification *) notification {
    NSNotificationCenter *notificationCenter =
        [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver: self];
}


- (void) updateDocumentViewSizeWithNotification: (NSNotification *) notification {
    [self updateDocumentViewSize];
}


- (void) updateDocumentViewSize {
    NSRect frame = [[self scrollView] frame];
    frame.origin = NSZeroPoint;
    [[self documentView] setFrame: frame];
}


- (void) keyDown: (NSEvent *) event inDocumentView: (DocumentView *) documentView {
    id <Mode> mode = [documentView mode];
    for(Command *command in [mode availableCommands: documentView]) {
        if([[command characters] isEqualToString: [event characters]]) {
            [command invoke: documentView];
            break;
        }
    }
}


- (void) updateDocumentContent {
    [[self documentView] setNeedsDisplay: YES];
}

@end
