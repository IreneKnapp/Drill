//
//  ModernStyleSelectorNodeType.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorNodeType.h"
#import "ModernPresentation.h"

@implementation ModernStyleSelectorNodeType

- (id) initWithNodeType: (ModernNodeType) nodeType {
    self = [super init];
    if(self) {
        _nodeType = nodeType;
    }
    return self;
}


- (ModernNodeType) nodeType {
    return _nodeType;
}


- (BOOL) test: (ModernPresentation *) presentation {
    Modern *node = [presentation node];
    if(!node) return NO;
    return [node nodeType] == _nodeType;
}


- (uint8_t) specificity {
    return 1;
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
