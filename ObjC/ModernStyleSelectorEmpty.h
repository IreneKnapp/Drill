//
//  ModernStyleSelectorEmpty.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModernStyleSelector.h"

@interface ModernStyleSelectorEmpty : NSObject <ModernStyleSelector>
@property (strong, nonatomic) id <ModernStyleSelector> primary;

- (id) initWithPrimary: (id <ModernStyleSelector>) primary;
- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
- (BOOL) pseudoElement;
- (id <ModernStyleSelector>) nonPseudoElementPrimary;
- (void) generateIfNecessary: (ModernPresentation *) presentation;
@end
