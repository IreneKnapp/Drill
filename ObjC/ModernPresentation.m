//
//  ModernPresentation.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernPresentation.h"
#import "ModernStyle.h"
#import "ModernStyleContent.h"
#import "ModernStyleContentItem.h"
#import "ModernStyleRule.h"
#import "ModernStyleSelector.h"

@implementation ModernPresentation

- (id) initWithNode: (Modern *) node {
	self = [super init];
	if(self) {
		[self setNode: node];
		_structuralChildren = [NSMutableArray arrayWithCapacity: 8];
		_structuralParent = nil;
		_inheritanceParent = nil;
		_computedStyle = nil;
		_generatedChildBefore = nil;
		_generatedChildAfter = nil;
		_generatedChildAround = nil;
	}
	return self;
}


- (NSArray *) structuralChildren {
	return (NSArray *) _structuralChildren;
}


- (void) addStructuralChild: (ModernPresentation *) child {
	if(child->_structuralParent)
	    [child->_structuralParent->_structuralChildren removeObject: child];
	[_structuralChildren addObject: child];
	child->_structuralParent = self;
}


- (void) addStructuralChild: (ModernPresentation *) child
         atIndex: (NSUInteger) index
{
	if(child->_structuralParent)
	    [child->_structuralParent->_structuralChildren removeObject: child];
	[_structuralChildren insertObject: child atIndex: index];
	child->_structuralParent = self;
}


- (ModernPresentation *) getStructuralParent {
	return _structuralParent;
}


- (void) setStructuralParent: (ModernPresentation *) parent {
	if(_structuralParent) [_structuralParent->_structuralChildren removeObject: self];
	[parent->_structuralChildren addObject: self];
	_structuralParent = parent;
}


- (NSUInteger) indexOfStructuralChild: (ModernPresentation *) child {
    return [_structuralChildren indexOfObject: child];
}


- (ModernPresentation *) getInheritanceParent {
	return _inheritanceParent;
}


- (void) setInheritanceParent: (ModernPresentation *) parent {
	_inheritanceParent = parent;
}


- (BOOL) hasGeneratedChildBefore {
    if(!_structuralParent) return NO;
    return _generatedChildBefore != nil;
}


- (void) removeGeneratedChildBefore {
    if(!_structuralParent) return;
    if(_generatedChildBefore)
        [_generatedChildBefore setStructuralParent: nil];
    _generatedChildBefore = nil;
}


- (ModernPresentation *) generatedChildBefore {
    if(!_structuralParent) return nil;
    if(!_generatedChildBefore) {
        NSUInteger selfIndex =
            [_structuralParent indexOfStructuralChild: self];
        _generatedChildBefore =
            [[ModernPresentation alloc] initWithNode: nil];
        [_generatedChildBefore setInheritanceParent: self];
        [_structuralParent addStructuralChild: _generatedChildBefore
                           atIndex: selfIndex];
    }
    return _generatedChildBefore;
}


- (BOOL) hasGeneratedChildAfter {
    if(!_structuralParent) return NO;
    return _generatedChildAfter != nil;
}


- (void) removeGeneratedChildAfter {
    if(!_structuralParent) return;
    if(_generatedChildAfter)
        [_generatedChildAfter setStructuralParent: nil];
    _generatedChildAfter = nil;
}


- (ModernPresentation *) generatedChildAfter {
    if(!_structuralParent) return nil;
    if(!_generatedChildAfter) {
        NSUInteger selfIndex =
            [_structuralParent indexOfStructuralChild: self];
        _generatedChildAfter =
            [[ModernPresentation alloc] initWithNode: nil];
        [_generatedChildAfter setInheritanceParent: self];
        [_structuralParent addStructuralChild: _generatedChildAfter
                           atIndex: selfIndex + 1];
    }
    return _generatedChildAfter;
}


- (BOOL) hasGeneratedChildAround {
    if(!_structuralParent) return NO;
    return _generatedChildAround != nil;
}


- (void) removeGeneratedChildAround {
    if(!_structuralParent) return;
    if(_generatedChildAround)
        [_generatedChildAround setStructuralParent: nil];
    _generatedChildAround = nil;
}


- (ModernPresentation *) generatedChildAround {
    if(!_structuralParent) return nil;
    if(!_generatedChildAround) {
        NSUInteger selfIndex =
            [_structuralParent indexOfStructuralChild: self];
        _generatedChildAround =
            [[ModernPresentation alloc] initWithNode: nil];
        [_generatedChildAround setInheritanceParent: self];
        [_structuralParent addStructuralChild: _generatedChildAround
                           atIndex: selfIndex];
        [_generatedChildAround addStructuralChild: self];
    }
    return _generatedChildAround;
}


- (void) recomputeStyleWithSheets: (NSArray *) styleSheets
         evenIfGenerated: (BOOL) evenIfGenerated
{
    if(!evenIfGenerated && ![self node] && _inheritanceParent) {
        for(ModernPresentation *child in _structuralChildren) {
            [child recomputeStyleWithSheets: styleSheets
                   evenIfGenerated: NO];
        }
        
        return;
    }
    
    for(NSArray *styleSheet in styleSheets) {
        for(ModernStyleRule *rule in styleSheet) {
            [[rule selector] generateIfNecessary: self];
        }
    }
    
    ModernStyle *computedStyle = [[ModernStyle alloc] init];
    
    for(NSString *propertyName in [ModernStyle allProperties]) {
        BOOL found = NO;
        uint8_t foundSpecificity = 0;
        
        if([_style propertyIsSet: propertyName]) {
            [computedStyle setProperty: propertyName
                           from: _style];
            found = YES;
            foundSpecificity = 255;
        }
        
        for(NSArray *styleSheet in styleSheets) {
            if(found) break;
            
            for(ModernStyleRule *rule in styleSheet) {
                if([[rule selector] test: self]) {
                    if([[rule style] propertyIsSet: propertyName]) {
                        uint8_t specificity = [[rule selector] specificity];
                        if(!found || (specificity >= foundSpecificity)) {
                            [computedStyle setProperty: propertyName
                                           from: [rule style]];
                            found = YES;
                            foundSpecificity = specificity;
                        }
                    }
                }
            }
        }
        
        if(!found) {
            [computedStyle setPropertyToInitialValue: propertyName];
        }
        
        if([computedStyle propertyIsInherit: propertyName] && _inheritanceParent) {
            [computedStyle setProperty: propertyName
                           from: [_inheritanceParent computedStyle]];
        }
    }
    
    [self setComputedStyle: computedStyle];
    
    if(_generatedChildBefore)
        [_generatedChildBefore recomputeStyleWithSheets: styleSheets
                               evenIfGenerated: YES];
    if(_generatedChildAfter)
        [_generatedChildAfter recomputeStyleWithSheets: styleSheets
                              evenIfGenerated: YES];
    if(_generatedChildAround)
        [_generatedChildAround recomputeStyleWithSheets: styleSheets
                               evenIfGenerated: YES];
    
    for(ModernPresentation *child in _structuralChildren) {
        [child recomputeStyleWithSheets: styleSheets
               evenIfGenerated: NO];
    }
}


- (NSString *) text {
    NSMutableString *result = [NSMutableString stringWithCapacity: 1024];
    
    ModernStyle *style = [self computedStyle];
    if(style) {
        ModernStyleContent *content;
        [style copyProperty: @"content"
               data: &content
               size: sizeof(content)];
        
        if([content isContentList]) {
            for(size_t itemIndex = 0; itemIndex < [content count]; itemIndex++) {
                ModernStyleContentItem *item = [content itemAtIndex: itemIndex];
                
                if([item isContents]) {
                    for(ModernPresentation *child in _structuralChildren) {
                        [result appendString: [child text]];
                    }
                } else if([item isString]) {
                    [result appendString: [item stringValue]];
                }
            }
        }
    }
    
    return (NSString *) result;
}

@end
