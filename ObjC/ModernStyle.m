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
		_textAlignmentSet = NO;
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
    return NoneModernStyleDisplay;
}


- (ModernStyleDisplay) display {
	if(_displaySet) return _display;
	if([self parent]) return [[self parent] display];
	return [[self class] defaultDisplay];
}


- (ModernStyleDisplay) computedDisplay {
	ModernStyleDisplay local = [self display];
	if(local == InheritModernStyleDisplay) {
	    ModernStyle *container = [self container];
	    if(container) return [container computedDisplay];
	    else return [[self class] defaultDisplay];
	}
	else return local;
}


- (BOOL) textAlignmentIsSet {
    return _textAlignmentSet;
}


- (void) unsetTextAlignment {
    _textAlignmentSet = NO;
}


- (void) setTextAlignment: (ModernStyleTextAlignment) textAlignment {
    _textAlignmentSet = YES;
    _textAlignment = textAlignment;
}


+ (ModernStyleTextAlignment) defaultTextAlignment {
    return LeftModernStyleTextAlignment;
}


- (ModernStyleTextAlignment) textAlignment {
	if(_textAlignmentSet) return _textAlignment;
	if([self parent]) return [[self parent] textAlignment];
	return [[self class] defaultTextAlignment];
}


- (ModernStyleTextAlignment) computedTextAlignment {
	ModernStyleTextAlignment local = [self textAlignment];
	if(local == InheritModernStyleTextAlignment) {
	    ModernStyle *container = [self container];
	    if(container) return [container computedTextAlignment];
	    else return [[self class] defaultTextAlignment];
	}
	else return local;
}

@end
