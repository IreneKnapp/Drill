//
//  ModernStyle.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyle.h"

@implementation ModernStyle

- (id) initWithParent: (ModernStyle *) parent {
	self = [super init];
	if(self) {
		[self setParent: parent];
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


- (ModernStyleDisplay) display {
	if(_displaySet) return _display;
	if([self parent]) return [[self parent] display];
	return noneModernStyleDisplay;
}


- (ModernStyleDisplay) computedDisplay: (ModernStyle *) inherited {
	ModernStyleDisplay local = [self display];
	if(local == inheritModernStyleDisplay) return [inherited display];
	else return local;
}

@end
