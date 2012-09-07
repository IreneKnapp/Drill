//
//  ModernStyleSelectorList.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModernStyleSelector.h"

@interface ModernStyleSelectorList : NSObject <ModernStyleSelector> {
    NSMutableArray *_selectors;
}

- (id) init;
- (void) addSelector: (id <ModernStyleSelector>) selector;
- (void) removeSelector: (id <ModernStyleSelector>) selector;
- (NSArray *) selectors;
- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
- (BOOL) pseudoElement;
- (id <ModernStyleSelector>) nonPseudoElementPrimary;
- (void) generateIfNecessary: (ModernPresentation *) presentation;
@end
