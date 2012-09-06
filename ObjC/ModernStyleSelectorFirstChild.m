//
//  ModernStyleSelectorFirstChild.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorFirstChild.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorFirstChild

- (id) initWithPrimary: (id <ModernStyleSelector>) primary {
    self = [super init];
    if(self) {
        [self setPrimary: primary];
    }
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    ModernPresentation *parent = [presentation getStructuralParent];
    if(parent) {
        for(ModernPresentation *sibling in [parent structuralChildren]) {
            if(![sibling node]) continue;
            
            return [presentation isEqual: sibling];
        }
        return NO;
    } else {
        return YES;
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
