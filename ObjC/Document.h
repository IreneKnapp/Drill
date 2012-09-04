//
//  Document.h
//  Med
//
//  Created by Irene Knapp on 8/20/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Modern;
@class ModernPresentation;
@interface Document : NSDocument {
    NSMutableArray *_schemaNodes;
    NSMutableArray *_styleSheet;
}
@property (strong, nonatomic) NSWindow *mainWindow;
@property (strong, nonatomic) NSMutableArray *adviceItems;
@property (strong, nonatomic) ModernPresentation *schemaPresentation;

- (id) init;
- (void) windowControllerDidLoadNib: (NSWindowController *) controller;
- (void) makeWindowControllers;
+ (BOOL) autosavesInPlace;
- (NSData *) dataOfType: (NSString *) typeName error: (NSError **) outError;
- (BOOL) readFromData: (NSData *) data ofType: (NSString *) typeName error: (NSError **) outError;
- (NSArray *) schemaNodes;
- (void) addSchemaNode: (Modern *) node;
- (NSArray *) styleSheet;
@end
