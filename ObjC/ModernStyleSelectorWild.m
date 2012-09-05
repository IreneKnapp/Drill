//
//  ModernStyleSelectorWild.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleSelectorWild.h"

@implementation ModernStyleSelectorWild

- (id) init {
    self = [super init];
    return self;
}


- (BOOL) test: (ModernPresentation *) presentation {
    return YES;
}


- (uint8_t) specificity {
    return 0;
}

@end
