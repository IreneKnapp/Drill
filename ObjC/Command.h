//
//  Command.h
//  Drill
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DocumentView;
@interface Command : NSObject {
    NSString *_characters;
    NSString *(^_headline)(DocumentView *documentView);
    BOOL (^_isVisible)(DocumentView *documentView);
    BOOL (^_isEnabled)(DocumentView *documentView);
    void (^_perform)(DocumentView *documentView);
}

- (id) initWithCharacters: (NSString *) characters
       headline: (NSString *(^)(DocumentView *documentView)) headline
       isVisible: (BOOL (^)(DocumentView *documentView)) isVisible
       isEnabled: (BOOL (^)(DocumentView *documentView)) isEnabled
       perform: (void (^)(DocumentView *documentView)) perform;
- (NSString *) characters;
- (NSString *) headline: (DocumentView *) documentView;
- (BOOL) isVisible: (DocumentView *) documentView;
- (BOOL) isEnabled: (DocumentView *) documentView;
- (void) invoke: (DocumentView *) documentView;
@end
