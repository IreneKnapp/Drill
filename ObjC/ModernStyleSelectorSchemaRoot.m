//
//  ModernStyleSelectorSchemaRoot.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorSchemaRoot.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorSchemaRoot

- (id) init {
    self = [super init];
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    return ![presentation node] && ![presentation getInheritanceParent];
}


- (uint8_t) specificity {
    return 3;
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
