//
//  Document.h
//  Med
//
//  Created by Irene Knapp on 8/20/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Modern;
@interface Document : NSDocument {
    NSMutableArray *_schemaNodes;
    NSMutableArray *_valueNodes;
}
@property (strong, nonatomic) NSWindow *mainWindow;
@property (strong, nonatomic) NSMutableArray *adviceItems;

- (id) init;
- (void) windowControllerDidLoadNib: (NSWindowController *) controller;
- (void) makeWindowControllers;
+ (BOOL) autosavesInPlace;
- (NSData *) dataOfType: (NSString *) typeName error: (NSError **) outError;
- (BOOL) readFromData: (NSData *) data ofType: (NSString *) typeName error: (NSError **) outError;
- (NSArray *) schemaNodes;
- (void) addSchemaNode: (Modern *) node;
@end
