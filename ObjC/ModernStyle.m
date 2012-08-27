//
//  ModernStyle.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyle.h"

@implementation ModernStyle

- (id) initWithParent: (ModernStyle *) parent
       container: (ModernStyle *) container
{
	self = [super init];
	if(self) {
		[self setParent: parent];
		[self setContainer: container];
		_displaySet = NO;
	}
	return self;
}


- (BOOL) displayIsSet {
	return _displaySet;
}


- (void) unsetDisplay {
	_displaySet = NO;
}


- (void) setDisplay: (ModernStyleDisplay) display {
	_displaySet = YES;
	_display = display;
}


+ (ModernStyleDisplay) defaultDisplay {
    return noneModernStyleDisplay;
}


- (ModernStyleDisplay) display {
	if(_displaySet) return _display;
	if([self parent]) return [[self parent] display];
	return [[self class] defaultDisplay];
}


- (ModernStyleDisplay) computedDisplay {
	ModernStyleDisplay local = [self display];
	if(local == inheritModernStyleDisplay) {
	    ModernStyle *container = [self container];
	    if(container) return [container computedDisplay];
	    else return [[self class] defaultDisplay];
	}
	else return local;
}

@end
