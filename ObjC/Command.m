//
//  Command.m
//  modern-data-editor
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "Command.h"

@implementation Command

- (id) initWithCharacters: (NSString *) characters
       headline: (NSString *(^)(DocumentView *documentView)) headline
       isVisible: (BOOL (^)(DocumentView *documentView)) isVisible
       isEnabled: (BOOL (^)(DocumentView *documentView)) isEnabled
       perform: (void (^)(DocumentView *documentView)) perform;
{
    self = [super init];
    if(self) {
        _characters = characters;
        _headline = headline;
        _isVisible = isVisible;
        _isEnabled = isEnabled;
        _perform = perform;
    }
    return self;   
}


- (NSString *) characters {
    return _characters;
}


- (NSString *) headline: (DocumentView *) documentView {
    return _headline(documentView);
}


- (BOOL) isVisible: (DocumentView *) documentView {
    return _isVisible(documentView);
}


- (BOOL) isEnabled: (DocumentView *) documentView {
    return _isEnabled(documentView);
}


- (void) invoke: (DocumentView *) documentView {
    _perform(documentView);
}

@end
