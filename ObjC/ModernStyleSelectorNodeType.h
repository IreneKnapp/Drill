//
//  ModernStyleSelectorNodeType.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Modern.h"
#import "ModernStyleSelector.h"

@interface ModernStyleSelectorNodeType : NSObject <ModernStyleSelector> {
    ModernNodeType _nodeType;
}

- (id) initWithNodeType: (ModernNodeType) nodeType;
- (ModernNodeType) nodeType;
- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
- (BOOL) pseudoElement;
- (id <ModernStyleSelector>) nonPseudoElementPrimary;
- (void) generateIfNecessary: (ModernPresentation *) presentation;
@end
