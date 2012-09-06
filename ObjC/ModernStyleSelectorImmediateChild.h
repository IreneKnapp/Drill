//
//  ModernStyleSelectorImmediateChild.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModernStyleSelector.h"

@interface ModernStyleSelectorImmediateChild : NSObject <ModernStyleSelector>
@property (strong, nonatomic) id <ModernStyleSelector> parentPrimary;
@property (strong, nonatomic) id <ModernStyleSelector> childPrimary;

- (id) initWithParent: (id <ModernStyleSelector>) parent
       child: (id <ModernStyleSelector>) child;
- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
- (BOOL) pseudoElement;
- (id <ModernStyleSelector>) nonPseudoElementPrimary;
- (void) generateIfNecessary: (ModernPresentation *) presentation;
@end
