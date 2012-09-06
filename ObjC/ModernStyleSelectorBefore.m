//
//  ModernStyleSelectorBefore.m
//  Drill
//
//  Created by Irene Knapp on 9/6/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorBefore.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorBefore

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
            if([inheritanceParent hasGeneratedChildBefore]
               && [presentation isEqual:
                      [inheritanceParent generatedChildBefore]])
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


- (void) generateIfNecessary: (ModernPresentation *) presentation {
    if([[self primary] test: presentation]) {
        (void) [presentation generatedChildBefore];
    }
}

@end
