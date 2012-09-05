//
//  SchemaMode.m
//  Drill
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "SchemaMode.h"
#import "AppDelegate.h"
#import "Command.h"
#import "Document.h"
#import "DocumentView.h"
#import "DocumentWindowController.h"
#import "Modern.h"

@implementation SchemaMode

- (id) init {
    self = [super init];
    if(self) {
        _topLevelCommands = [NSMutableArray arrayWithCapacity: 16];
        [_topLevelCommands addObject:
            [[Command alloc]
                initWithCharacters: @"t"
                headline: ^(DocumentView *documentView) {
                    return @"Add new type...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: addNewTypeSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        [_topLevelCommands addObject:
            [[Command alloc]
                initWithCharacters: @"v"
                headline: ^(DocumentView *documentView) {
                    return @"Add new value...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: addNewValueSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        [_topLevelCommands addObject:
            [[Command alloc]
                initWithCharacters: @"g"
                headline: ^(DocumentView *documentView) {
                    return @"Go to...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    NSLog(@"Go to...");
                }]];
        [_topLevelCommands addObject:
            [[Command alloc]
                initWithCharacters: @"m"
                headline: ^(DocumentView *documentView) {
                    return @"Toggle to value mode.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    NSLog(@"Toggle to value mode.");
                }]];
        
        _addNewTypeCommands = [NSMutableArray arrayWithCapacity: 16];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"i"
                headline: ^(DocumentView *documentView) {
                    return @"Add integer type...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: addNewIntegerTypeSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"n"
                headline: ^(DocumentView *documentView) {
                    return @"Add natural-number type...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: addNewNaturalTypeSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"f"
                headline: ^(DocumentView *documentView) {
                    return @"Add floating-point type...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: addNewFloatingTypeSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"t"
                headline: ^(DocumentView *documentView) {
                    return @"Add text (UTF8) type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeUTF8Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"b"
                headline: ^(DocumentView *documentView) {
                    return @"Add binary large-object type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeBlobType];
                    [document addSchemaNode: node];
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"z"
                headline: ^(DocumentView *documentView) {
                    return @"Add sigma type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add sigma type.");
                }]];
        [_addNewTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"\x1B"
                headline: ^(DocumentView *documentView) {
                    return @"Cancel adding type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        
        _addNewIntegerTypeCommands = [NSMutableArray arrayWithCapacity: 16];
        [_addNewIntegerTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"1"
                headline: ^(DocumentView *documentView) {
                    return @"Add 8-bit signed integer type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeInt8Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewIntegerTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"2"
                headline: ^(DocumentView *documentView) {
                    return @"Add 16-bit signed integer type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeInt16Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewIntegerTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"3"
                headline: ^(DocumentView *documentView) {
                    return @"Add 32-bit signed integer type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeInt32Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewIntegerTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"4"
                headline: ^(DocumentView *documentView) {
                    return @"Add 64-bit signed integer type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeInt64Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewIntegerTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"\x1B"
                headline: ^(DocumentView *documentView) {
                    return @"Cancel adding type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];

        _addNewNaturalTypeCommands = [NSMutableArray arrayWithCapacity: 16];
        [_addNewNaturalTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"1"
                headline: ^(DocumentView *documentView) {
                    return @"Add 8-bit natural number type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeNat8Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewNaturalTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"2"
                headline: ^(DocumentView *documentView) {
                    return @"Add 16-bit natural number type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeNat16Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewNaturalTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"3"
                headline: ^(DocumentView *documentView) {
                    return @"Add 32-bit natural number type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeNat32Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewNaturalTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"4"
                headline: ^(DocumentView *documentView) {
                    return @"Add 64-bit natural number type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeNat64Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewNaturalTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"\x1B"
                headline: ^(DocumentView *documentView) {
                    return @"Cancel adding type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        
        _addNewFloatingTypeCommands = [NSMutableArray arrayWithCapacity: 16];
        [_addNewFloatingTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"1"
                headline: ^(DocumentView *documentView) {
                    return @"Add 32-bit floating point type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeFloat32Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewFloatingTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"2"
                headline: ^(DocumentView *documentView) {
                    return @"Add 64-bit floating point type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeFloat64Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewFloatingTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"3"
                headline: ^(DocumentView *documentView) {
                    return @"Add 128-bit floating point type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    DocumentWindowController *documentWindowController =
                        [documentView documentWindowController];
                    Document *document = [documentWindowController document];
                    
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [documentWindowController updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    
                    Modern *node = [Modern makeFloat128Type];
                    [document addSchemaNode: node];
                }]];
        [_addNewFloatingTypeCommands addObject:
            [[Command alloc]
                initWithCharacters: @"\x1B"
                headline: ^(DocumentView *documentView) {
                    return @"Cancel adding type.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
        
        _addNewValueCommands = [NSMutableArray arrayWithCapacity: 16];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"i"
                headline: ^(DocumentView *documentView) {
                    return @"Add integer value...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add integer value...");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"n"
                headline: ^(DocumentView *documentView) {
                    return @"Add natural-number value...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add natural-number value...");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"f"
                headline: ^(DocumentView *documentView) {
                    return @"Add floating-point value...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add floating-point value...");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"t"
                headline: ^(DocumentView *documentView) {
                    return @"Add text (UTF8) value.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add text (UTF8) value.");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"b"
                headline: ^(DocumentView *documentView) {
                    return @"Add binary large-object value.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add binary large-object value.");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"z"
                headline: ^(DocumentView *documentView) {
                    return @"Add sigma value...";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                    NSLog(@"Add sigma value...");
                }]];
        [_addNewValueCommands addObject:
            [[Command alloc]
                initWithCharacters: @"\x1B"
                headline: ^(DocumentView *documentView) {
                    return @"Cancel adding value.";
                }
                isVisible: ^(DocumentView *documentView) {
                    return YES;
                }
                isEnabled: ^(DocumentView *documentView) {
                    return YES;
                }
                perform: ^(DocumentView *documentView) {
                    [self setSubmode: topLevelSchemaModeSubmode];
                    [[documentView documentWindowController] updateAdvice];
                    [(AppDelegate *) [NSApp delegate] adviceNeedsDisplay];
                }]];
    }
    return self;
}


- (NSArray *) availableCommands: (DocumentView *) documentView {
    switch([self submode]) {
    case topLevelSchemaModeSubmode: return _topLevelCommands;
    case addNewTypeSchemaModeSubmode: return _addNewTypeCommands;
    case addNewIntegerTypeSchemaModeSubmode: return _addNewIntegerTypeCommands;
    case addNewNaturalTypeSchemaModeSubmode: return _addNewNaturalTypeCommands;
    case addNewFloatingTypeSchemaModeSubmode: return _addNewFloatingTypeCommands;
    case addNewValueSchemaModeSubmode: return _addNewValueCommands;
    default: return [NSArray arrayWithObjects: nil];
    }
}


- (NSArray *) adviceHeaderItems: (DocumentView *) documentView {
    NSString *submodeExplanation = nil;
    switch([self submode]) {
    case addNewTypeSchemaModeSubmode:
        submodeExplanation = @"choosing what kind of type node to add";
        break;
    default: break;
    }
    
    NSString *modeExplanation = nil;
    if(!submodeExplanation) {
        modeExplanation = @"Currently in schema mode.";
    } else {
        modeExplanation =
            [NSString stringWithFormat: @"Currently in schema mode, %@.",
                submodeExplanation];
    }
    
    return [NSArray arrayWithObjects: modeExplanation, nil];
}


- (NSArray *) adviceFooterItems: (DocumentView *) documentView {
    return [NSArray arrayWithObjects:
               @"You can also use the mouse to select and move nodes, "
               @"except that there are none at the moment.",
               nil];
}

@end
