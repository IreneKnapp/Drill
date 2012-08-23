//
//  Document.h
//  Med
//
//  Created by Irene Knapp on 8/20/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
@property (strong, nonatomic) NSWindow *mainWindow;

- (id) init;
- (void) windowControllerDidLoadNib: (NSWindowController *) controller;
- (void) makeWindowControllers;
+ (BOOL) autosavesInPlace;
- (NSData *) dataOfType: (NSString *) typeName error: (NSError **) outError;
- (BOOL) readFromData: (NSData *) data ofType: (NSString *) typeName error: (NSError **) outError;
@end
