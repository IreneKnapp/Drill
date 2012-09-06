//
//  ModernStyleSelectorWild.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorWild.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorWild

- (id) init {
    self = [super init];
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    if([presentation node]) {
        return YES;
    } else {
        if([presentation getInheritanceParent]) {
            return NO;
        } else {
            return YES;
        }
    }
}


- (uint8_t) specificity {
    return 0;
}


- (BOOL) pseudoElement {
    return NO;
}


- (void) generateIfNecessary: (ModernPresentation *) presentation {
    return;
}

@end
