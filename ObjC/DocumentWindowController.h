//
//  DocumentWindowController.h
//  Drill
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DocumentView;
@protocol Mode;
@interface DocumentWindowController : NSWindowController
@property (strong, nonatomic) IBOutlet NSScrollView *scrollView;
@property (strong, nonatomic) IBOutlet DocumentView *documentView;
@property (nonatomic) NSRect savedNonFullScreenFrame;
@property (nonatomic) NSUInteger savedNonFullScreenStyleMask;
@property (strong, nonatomic) NSMutableArray *adviceItems;

- (id) initWithMode: (id <Mode>) mode;
- (void) windowDidResize: (NSNotification *) notification;
- (NSArray *) customWindowsToEnterFullScreenForWindow: (NSWindow *) window;
- (void) window: (NSWindow *) window
         startCustomAnimationToEnterFullScreenWithDuration:
             (NSTimeInterval) duration;
- (NSArray *) customWindowsToExitFullScreenForWindow: (NSWindow *) window;
- (void) window: (NSWindow *) window
         startCustomAnimationToExitFullScreenWithDuration:
             (NSTimeInterval) duration;
- (void) updateAdvice;
- (void) windowWillClose: (NSNotification *) notification;
- (void) updateDocumentViewSizeWithNotification: (NSNotification *) notification;
- (void) updateDocumentViewSize;
- (void) keyDown: (NSEvent *) event inDocumentView: (DocumentView *) documentView;
- (void) updateDocumentContent;
@end
