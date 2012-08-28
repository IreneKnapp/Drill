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
		_children = [NSMutableArray arrayWithCapacity: 8];
		_parent = nil;
	}
	return self;
}


- (NSArray *) children {
	return (NSArray *) _children;
}


- (void) addChild: (ModernPresentation *) child {
	if(child->_parent) [child->_parent->_children removeObject: child];
	[_children addObject: child];
	child->_parent = self;
}


- (void) addChild: (ModernPresentation *) child
         atIndex: (NSUInteger) index
{
	if(child->_parent) [child->_parent->_children removeObject: child];
	[_children insertObject: child atIndex: index];
	child->_parent = self;
}


- (ModernPresentation *) getParent {
	return _parent;
}


- (void) setParent: (ModernPresentation *) parent {
	if(_parent) [_parent->_children removeObject: self];
	[parent->_children addObject: self];
	_parent = parent;
}

@end
