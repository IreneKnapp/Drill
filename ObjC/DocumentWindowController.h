//
//  DocumentWindowController.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DocumentWindowController : NSWindowController
@property (nonatomic) NSRect savedNonFullScreenFrame;

- (id) init;
- (void) windowDidResize: (NSNotification *) notification;
- (NSArray *) customWindowsToEnterFullScreenForWindow: (NSWindow *) window;
- (void) window: (NSWindow *) window
         startCustomAnimationToEnterFullScreenWithDuration:
             (NSTimeInterval) duration;
- (NSArray *) customWindowsToExitFullScreenForWindow: (NSWindow *) window;
- (void) window: (NSWindow *) window
         startCustomAnimationToExitFullScreenWithDuration:
             (NSTimeInterval) duration;
@end
