//
//  AppDelegate.m
//  Drill
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "AppDelegate.h"
#import "AdviceView.h"
#import "Command.h"
#import "Document.h"
#import "Modern.h"
#import "ModernStyle.h"
#import "ModernStyleContent.h"
#import "ModernStyleContentItem.h"
#import "ModernStyleRule.h"
#import "ModernStyleSelector.h"
#import "ModernStyleSelectorAfter.h"
#import "ModernStyleSelectorBefore.h"
#import "ModernStyleSelectorEmpty.h"
#import "ModernStyleSelectorFirstChild.h"
#import "ModernStyleSelectorImmediateChild.h"
#import "ModernStyleSelectorList.h"
#import "ModernStyleSelectorNodeType.h"
#import "ModernStyleSelectorSchemaRoot.h"
#import "ModernStyleSelectorWild.h"
#import "SchemaMode.h"

@implementation AppDelegate

- (void) applicationWillFinishLaunching: (NSNotification *) notification {
    _schemaMode = [[SchemaMode alloc] init];
    
    _styleSheet = [NSMutableArray arrayWithCapacity: 64];
    
    ModernNodeType simpleNodeTypes[] = {
        int8ValueModernNodeType,
        int16ValueModernNodeType,
        int32ValueModernNodeType,
        int64ValueModernNodeType,
        nat8ValueModernNodeType,
        nat16ValueModernNodeType,
        nat32ValueModernNodeType,
        nat64ValueModernNodeType,
        float32ValueModernNodeType,
        float64ValueModernNodeType,
        float128ValueModernNodeType,
        utf8ValueModernNodeType,
        blobValueModernNodeType,
        sigmaValueModernNodeType,
        namedValueModernNodeType,
        int8TypeModernNodeType,
        int16TypeModernNodeType,
        int32TypeModernNodeType,
        int64TypeModernNodeType,
        nat8TypeModernNodeType,
        nat16TypeModernNodeType,
        nat32TypeModernNodeType,
        nat64TypeModernNodeType,
        float32TypeModernNodeType,
        float64TypeModernNodeType,
        float128TypeModernNodeType,
        utf8TypeModernNodeType,
        blobTypeModernNodeType,
        sigmaTypeModernNodeType,
        namedTypeModernNodeType,
        universeTypeModernNodeType,
    };
    
    NSString *simpleNames[] = {
        @"int8-value",
        @"int16-value",
        @"int32-value",
        @"int64-value",
        @"nat8-value",
        @"nat16-value",
        @"nat32-value",
        @"nat64-value",
        @"float32-value",
        @"float64-value",
        @"float128-value",
        @"utf8-value",
        @"blob-value",
        @"sigma-value",
        @"named-value",
        @"int8-type",
        @"int16-type",
        @"int32-type",
        @"int64-type",
        @"nat8-type",
        @"nat16-type",
        @"nat32-type",
        @"nat64-type",
        @"float32-type",
        @"float64-type",
        @"float128-type",
        @"utf8-type",
        @"blob-type",
        @"sigma-type",
        @"named-type",
        @"universe-type",
    };
    
    for(size_t i = 0; i < 31; i++) {
        id <ModernStyleSelector> selector =
            [[ModernStyleSelectorNodeType alloc]
                initWithNodeType: simpleNodeTypes[i]];
        ModernStyle *style = [[ModernStyle alloc] init];
        ModernStyleContent *content =
            [[ModernStyleContent alloc] initAsContentList];
        [content addItem: [[ModernStyleContentItem alloc]
                               initAsString: simpleNames[i]]];
        [style setProperty: @"content"
               data: &content
               size: sizeof(content)];
        ModernStyleRule *rule =
            [[ModernStyleRule alloc] initWithSelector: selector
                                     style: style];
        
        [_styleSheet addObject: rule];
    }
    
    {
        id <ModernStyleSelector> selector =
            [[ModernStyleSelectorBefore alloc]
                initWithPrimary: [[ModernStyleSelectorWild alloc] init]];
        ModernStyle *style = [[ModernStyle alloc] init];
        ModernStyleContent *content =
            [[ModernStyleContent alloc] initAsContentList];
        [content addItem: [[ModernStyleContentItem alloc] initAsString: @"("]];
        [style setProperty: @"content"
               data: &content
               size: sizeof(content)];
        ModernStyleRule *rule =
            [[ModernStyleRule alloc] initWithSelector: selector
                                     style: style];
        
        [_styleSheet addObject: rule];
    }
    
    {
        id <ModernStyleSelector> selector =
            [[ModernStyleSelectorAfter alloc]
                initWithPrimary: [[ModernStyleSelectorWild alloc] init]];
        ModernStyle *style = [[ModernStyle alloc] init];
        ModernStyleContent *content =
            [[ModernStyleContent alloc] initAsContentList];
        [content addItem:
            [[ModernStyleContentItem alloc] initAsString: @")\n"]];
        [style setProperty: @"content"
               data: &content
               size: sizeof(content)];
        ModernStyleRule *rule =
            [[ModernStyleRule alloc] initWithSelector: selector
                                     style: style];
        
        [_styleSheet addObject: rule];
    }
    
    {
        id <ModernStyleSelector> selectorA =
            [[ModernStyleSelectorBefore alloc]
              initWithPrimary:
                [[ModernStyleSelectorBefore alloc]
                  initWithPrimary:
                    [[ModernStyleSelectorImmediateChild alloc]
                      initWithParent:
                        [[ModernStyleSelectorSchemaRoot alloc] init]
                      child:
                        [[ModernStyleSelectorFirstChild alloc]
                          initWithPrimary:
                            [[ModernStyleSelectorWild alloc] init]]]]];
        id <ModernStyleSelector> selectorB =
            [[ModernStyleSelectorEmpty alloc]
              initWithPrimary:
                [[ModernStyleSelectorSchemaRoot alloc] init]];
        ModernStyleSelectorList *selector =
            [[ModernStyleSelectorList alloc] init];
        [selector addSelector: selectorA];
        [selector addSelector: selectorB];
        ModernStyle *style = [[ModernStyle alloc] init];
        ModernStyleContent *content =
            [[ModernStyleContent alloc] initAsContentList];
        [content addItem: [[ModernStyleContentItem alloc]
                 initAsString: @"Schema\n"]];
        [style setProperty: @"content"
               data: &content
               size: sizeof(content)];
        ModernStyleRule *rule =
            [[ModernStyleRule alloc] initWithSelector: selector
                                     style: style];
        
        [_styleSheet addObject: rule];
    }
    
    {
        id <ModernStyleSelector> selector =
            [[ModernStyleSelectorWild alloc] init];
        ModernStyle *style = [[ModernStyle alloc] init];
        
        ModernStyleContent *content =
            [[ModernStyleContent alloc] initAsContentList];
        [content addItem: [[ModernStyleContentItem alloc] initAsContents]];
        [style setProperty: @"content"
               data: &content
               size: sizeof(content)];
        ModernStyleRule *rule =
            [[ModernStyleRule alloc] initWithSelector: selector
                                     style: style];
        
        [_styleSheet addObject: rule];
    }
}


- (void) applicationDidFinishLaunching: (NSNotification *) notification {
	[self setInFullScreenTransition: NO];
	
    [[self advicePanel] setOpaque: NO];
    [[self advicePanel] setBackgroundColor: [NSColor clearColor]];
    [[self advicePanel] setLevel: NSFloatingWindowLevel];
    
    NSNotificationCenter *notificationCenter =
        [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver: self
                        selector: @selector(hideAdviceWithNotification:)
                        name: NSWindowDidResignMainNotification
                        object: nil];
    [notificationCenter addObserver: self
                        selector: @selector(showAdviceWithNotification:)
                        name: NSWindowDidBecomeMainNotification
                        object: nil];
}


- (void) applicationDidBecomeActive: (NSNotification *) notification {
    NSWindow *window = [NSApp mainWindow];
    if(window) [self showAdviceWithWindow: window];
}


- (void) hideAdviceWithNotification: (NSNotification *) notification {
	[self hideAdvice];
}


- (void) hideAdvice {
    [[self advicePanel] orderOut: self];
}


- (void) showAdviceWithNotification: (NSNotification *) notification {
    NSWindow *window = [NSApp mainWindow];
    if(window) [self showAdviceWithWindow: window];
}


- (void) showAdviceWithWindow: (NSWindow *) window {
	NSWindowController *windowController = [window windowController];
	if(!windowController) return;
	
	NSDocument *document = [windowController document];
	if(!document) return;
	
	NSPanel *panel = [self advicePanel];
	
    if(![self inFullScreenTransition]) {
		NSRect windowFrame = [window contentRectForFrameRect: [window frame]];
		
		NSRect adviceFrame = [panel frame];
		adviceFrame.origin.x = windowFrame.origin.x + windowFrame.size.width;
		adviceFrame.origin.y = windowFrame.origin.y + windowFrame.size.height
			- adviceFrame.size.height;
		
		if(([window styleMask] & NSFullScreenWindowMask)
		   == NSFullScreenWindowMask)
		{
			adviceFrame.origin.x -= adviceFrame.size.width;
		}
		
		[panel setFrame: adviceFrame display: NO];
    	[window addChildWindow: panel ordered: NSWindowAbove];
		[document addWindowController: windowController];
		[[self adviceView] setAttachedWindow: window];
		[[self adviceView] setNeedsDisplay: YES];
    }
}


- (void) adviceNeedsDisplay {
    [[self adviceView] setNeedsDisplay: YES];
}


- (id <Mode>) schemaMode {
    return _schemaMode;
}


- (NSArray *) styleSheet {
    return (NSArray *) _styleSheet;
}

@end
