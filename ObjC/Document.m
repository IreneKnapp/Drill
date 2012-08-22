//
//  Document.m
//  Med
//
//  Created by Irene Knapp on 8/20/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "Document.h"
#import "AppDelegate.h"

@implementation Document

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (NSString *) windowNibName {
    return @"Document";
}


- (void) windowControllerDidLoadNib: (NSWindowController *) controller {
    [super windowControllerDidLoadNib: controller];
    [(AppDelegate *) [NSApp delegate] showAdviceWithWindow: [self mainWindow]];
}


- (void) windowDidResize: (NSNotification *) notification {
    NSWindow *window = [notification object];
    if([window isEqual: [self mainWindow]]) {
        [(AppDelegate *) [NSApp delegate] showAdviceWithWindow: window];
    }
}


+ (BOOL) autosavesInPlace {
    return YES;
}


- (NSData *) dataOfType: (NSString *) typeName error: (NSError **) outError {
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}


- (BOOL) readFromData: (NSData *) data ofType: (NSString *) typeName error: (NSError **) outError {
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
