//
//  ModernPresentation.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernPresentation.h"
#import "ModernStyle.h"
#import "ModernStyleRule.h"
#import "ModernStyleSelector.h"

@implementation ModernPresentation

- (id) initWithNode: (Modern *) node {
	self = [super init];
	if(self) {
		[self setNode: node];
		_children = [NSMutableArray arrayWithCapacity: 8];
		_parent = nil;
		_computedStyle = nil;
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


- (void) recomputeStyleWithSheets: (NSArray *) styleSheets {
    ModernStyle *containerStyle = nil;
    if(_parent) containerStyle = [_parent computedStyle];
    ModernStyle *computedStyle = [[ModernStyle alloc] init];
    
    for(NSString *propertyName in [ModernStyle allProperties]) {
        BOOL found = NO;
        
        if([_style propertyIsSet: propertyName]) {
            [computedStyle setProperty: propertyName
                           from: _style];
            found = YES;
        }
        
        for(NSArray *styleSheet in styleSheets) {
            if(found) break;
            
            for(ModernStyleRule *rule in styleSheet) {
                if([[rule selector] test: self]) {
                    if([[rule style] propertyIsSet: propertyName]) {
                        [computedStyle setProperty: propertyName
                                       from: [rule style]];
                        found = YES;
                    }
                }
            }
        }
        
        if(!found) {
            
        }
    }
    
    [self setComputedStyle: computedStyle];
    
    for(ModernPresentation *child in _children) {
        [child recomputeStyleWithSheets: styleSheets];
    }
}


- (NSString *) text {
    NSMutableString *result = [NSMutableString stringWithCapacity: 1024];
    
    ModernStyle *style = [self computedStyle];
    if(style) {
        [result appendString: @"("];
        for(ModernPresentation *child in _children) {
            [result appendString: [child text]];
        }
        [result appendString: @")"];
    }
    
    return (NSString *) result;
}

@end
