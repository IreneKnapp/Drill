//
//  ModernStyleSelectorWild.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModernStyleSelector.h"

@interface ModernStyleSelectorWild : NSObject <ModernStyleSelector>

- (id) init;
- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
@end
