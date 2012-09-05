//
//  ModernStyleSelector.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModernPresentation;
@protocol ModernStyleSelector <NSObject>

- (BOOL) test: (ModernPresentation *) presentation;
- (uint8_t) specificity;
@end
