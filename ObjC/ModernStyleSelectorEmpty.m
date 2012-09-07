//
//  ModernStyleSelectorEmpty.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorEmpty.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorEmpty

- (id) initWithPrimary: (id <ModernStyleSelector>) primary {
    self = [super init];
    if(self) {
        [self setPrimary: primary];
    }
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    if([[self primary] test: presentation]) {
        return [[presentation structuralChildren] count] == 0;
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
