//
//  ModernPresentation.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernPresentation.h"

@implementation ModernPresentation

- (id) initWithNode: (Modern *) node {
	self = [super init];
	if(self) {
		[self setNode: node];
		[self setChildren: [NSMutableArray arrayWithCapacity: 8]];
		[self setParent: nil];
	}
	return self;
}

@end
