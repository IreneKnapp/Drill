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
#import "Modern.h"

@implementation Document

- (id) init {
    self = [super init];
    if (self) {
        _schemaNodes = [NSMutableArray arrayWithCapacity: 128];
        _valueNodes = [NSMutableArray arrayWithCapacity: 128];
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
		[[DocumentWindowController alloc]
		    initWithMode: [(AppDelegate *) [NSApp delegate] schemaMode]];
	[self setMainWindow: [mainWindowController window]];
	[self addWindowController: mainWindowController];
	[mainWindowController updateAdvice];
	[(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
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


- (NSArray *) schemaNodes {
    return _schemaNodes;
}


- (void) addSchemaNode: (Modern *) node {
    [_schemaNodes addObject: node];
    [(DocumentWindowController *) [[self mainWindow] windowController]
        updateDocumentContent];
}

@end
