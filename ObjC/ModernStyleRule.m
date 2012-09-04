//
//  ModernStyleRule.m
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleRule.h"

@implementation ModernStyleRule

- (id) initWithSelector: (id <ModernStyleSelector>) selector
       style: (ModernStyle *) style
{
    self = [super init];
    if(self) {
        [self setSelector: selector];
        [self setStyle: style];
    }
    return self;
}

@end
