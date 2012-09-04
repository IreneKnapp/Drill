//
//  DocumentView.m
//  Drill
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "DocumentView.h"
#import "AppDelegate.h"
#import "Document.h"
#import "DocumentWindowController.h"
#import "LayoutManager.h"
#import "ModernPresentation.h"

@implementation DocumentView

- (id) initWithFrame: (NSRect) frame
{
    self = [super initWithFrame:frame];
    if(self) {
        _schemaLayoutManager = nil;
    }
    return self;
}


- (Document *) document {
    DocumentWindowController *documentWindowController =
        [self documentWindowController];
    if(!documentWindowController) return nil;
    return [documentWindowController document];
}


- (DocumentWindowController *) documentWindowController {
    NSWindow *window = [self window];
    if(!window) return nil;
    NSWindowController *windowController = [window windowController];
    if(!windowController) return nil;
    if(![windowController isKindOfClass: [DocumentWindowController class]])
        return nil;
    return (DocumentWindowController *) windowController;
}


- (void) drawRect: (NSRect) dirtyRect
{
    if(!_schemaLayoutManager) {
        _schemaLayoutManager =
            [[LayoutManager alloc] initWithPresentation:
                [[self document] schemaPresentation]];
        /*
        unichar characters[8];
        characters[0] = 'F';
        characters[1] = 'o';
        characters[2] = 'o';
        characters[3] = '\n';
        characters[4] = 'B';
        characters[5] = 'a';
        characters[6] = 'r';
        characters[7] = '\n';
        [_schemaLayoutManager appendCharacters: characters count: 8];
        */
    }
    
    Document *document = [self document];
    ModernPresentation *presentation = [document schemaPresentation];
    NSArray *applicationStyleSheet =
        [(AppDelegate *) [NSApp delegate] styleSheet];
    NSArray *documentStyleSheet = [document styleSheet];
    NSArray *styleSheets =
        [NSArray arrayWithObjects: documentStyleSheet,
                                   applicationStyleSheet,
                                   nil];
    
    [presentation recomputeStyleWithSheets: styleSheets];
    
    [_schemaLayoutManager removeAllCharacters];
    NSString *text = [presentation text];
    unichar *characters = malloc(sizeof(unichar) * [text length]);
    for(size_t i = 0; i < [text length]; i++) {
        characters[i] = [text characterAtIndex: i];
    }
    [_schemaLayoutManager appendCharacters: characters count: [text length]];
    free(characters);
    
    NSRect bounds = [self bounds];
    
    [_schemaLayoutManager setWrapWidth: bounds.size.width];
    [_schemaLayoutManager draw: dirtyRect inBounds: bounds];
}


- (BOOL) acceptsFirstResponder {
    return YES;
}


- (void) keyDown: (NSEvent *) event {
    [[self documentWindowController] keyDown: event inDocumentView: self];
}

@end
