//
//  Document.m
//  Med
//
//  Created by Irene Knapp on 8/20/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "Document.h"
#import "AppDelegate.h"
#import "DocumentWindowController.h"

@implementation Document

- (id) init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (void) windowControllerDidLoadNib: (NSWindowController *) controller {
    [super windowControllerDidLoadNib: controller];
    [(AppDelegate *) [NSApp delegate]
    	showAdviceWithWindow: [controller window]];
}


- (void) makeWindowControllers {
	DocumentWindowController *mainWindowController =
		[[DocumentWindowController alloc] init];
	[self setMainWindow: [mainWindowController window]];
	[self addWindowController: mainWindowController];
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
