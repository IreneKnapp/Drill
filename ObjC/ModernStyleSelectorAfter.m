//
//  ModernStyleSelectorAfter.m
//  Drill
//
//  Created by Irene Knapp on 9/6/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorAfter.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorAfter

- (id) initWithPrimary: (id <ModernStyleSelector>) primary {
    self = [super init];
    if(self) {
        [self setPrimary: primary];
    }
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    ModernPresentation *inheritanceParent =
        [presentation getInheritanceParent];
    
    if(![presentation node] && inheritanceParent) {
        if([[self primary] test: inheritanceParent]) {
            if([inheritanceParent hasGeneratedChildAfter]
               && [presentation isEqual:
                      [inheritanceParent generatedChildAfter]])
            {
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}


- (uint8_t) specificity {
    return [[self primary] specificity];
}


- (BOOL) pseudoElement {
    return YES;
}


- (id <ModernStyleSelector>) nonPseudoElementPrimary {
    return [[self primary] nonPseudoElementPrimary];
}


- (void) generateIfNecessary: (ModernPresentation *) presentation {
    if([[self primary] test: presentation]) {
        (void) [presentation generatedChildAfter];
    }
}

@end
