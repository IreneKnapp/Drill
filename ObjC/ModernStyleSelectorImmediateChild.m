//
//  ModernStyleSelectorImmediateChild.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorImmediateChild.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorImmediateChild

- (id) initWithParent: (id <ModernStyleSelector>) parent
       child: (id <ModernStyleSelector>) child
{
    if([parent pseudoElement]) return nil;
    if([child pseudoElement]) return nil;
    
    self = [super init];
    if(self) {
        [self setParentPrimary: parent];
        [self setChildPrimary: child];
    }
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    ModernPresentation *parent = [presentation getStructuralParent];
    if(parent) {
        return [[self parentPrimary] test: parent]
               && [[self childPrimary] test: presentation];
    } else {
        return NO;
    }
}


- (uint8_t) specificity {
    return 2;
}


- (BOOL) pseudoElement {
    return NO;
}


- (id <ModernStyleSelector>) nonPseudoElementPrimary {
    return self;
}


- (void) generateIfNecessary: (ModernPresentation *) presentation {
    return;
}

@end
