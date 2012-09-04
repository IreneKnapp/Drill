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
#import "ModernPresentation.h"

@implementation Document

- (id) init {
    self = [super init];
    if (self) {
        [self setSchemaPresentation:
                [[ModernPresentation alloc] initWithNode: nil]];
        
        _schemaNodes = [NSMutableArray arrayWithCapacity: 128];
        
        _styleSheet = [NSMutableArray arrayWithCapacity: 64];
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
/*
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
    */
    NSLog(@"type name %@", typeName);
    NSMutableData *data = [NSMutableData dataWithCapacity: 1];
    uint8_t buffer[1];
    buffer[0] = 42;
    [data appendBytes: buffer length: sizeof(buffer)];
    return data;
}


- (BOOL) readFromData: (NSData *) data ofType: (NSString *) typeName error: (NSError **) outError {
/*
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    */
    return YES;
}


- (NSArray *) schemaNodes {
    return _schemaNodes;
}


- (void) addSchemaNode: (Modern *) node {
    [_schemaNodes addObject: node];
    
    ModernPresentation *presentation =
        [[ModernPresentation alloc] initWithNode: node];
    [[self schemaPresentation] addChild: presentation];
    
    [(DocumentWindowController *) [[self mainWindow] windowController]
        updateDocumentContent];
}


- (NSArray *) styleSheet {
    return (NSArray *) _styleSheet;
}

@end
