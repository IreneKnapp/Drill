//
//  ModernStyleSelectorList.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorList.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorList

- (id) init {
    self = [super init];
    if(self) {
        _selectors = [NSMutableArray arrayWithCapacity: 8];
    }
    return self;
}


- (void) addSelector: (id <ModernStyleSelector>) selector {
    [_selectors addObject: selector];
}


- (void) removeSelector: (id <ModernStyleSelector>) selector {
    [_selectors removeObject: selector];
}


- (NSArray *) selectors {
    return (NSArray *) _selectors;
}


- (BOOL) test: (ModernPresentation *) presentation {
    for(id <ModernStyleSelector> child in _selectors) {
        if([child test: presentation]) return YES;
    }
    return NO;
}


- (uint8_t) specificity {
    return 2;
}


- (BOOL) pseudoElement {
    for(id <ModernStyleSelector> child in _selectors) {
        if([child pseudoElement]) return YES;
    }
    return NO;
}


- (id <ModernStyleSelector>) nonPseudoElementPrimary {
    if([self pseudoElement]) {
        return nil;
    } else {
        return self;
    }
}


- (void) generateIfNecessary: (ModernPresentation *) presentation {
    for(id <ModernStyleSelector> child in _selectors) {
        [child generateIfNecessary: presentation];
    }
}

@end
