//
//  ModernPresentation.h
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Modern;
@class ModernStyle;
@interface ModernPresentation : NSObject {
	NSMutableArray *_structuralChildren;
	ModernPresentation *_structuralParent;
	ModernPresentation *_inheritanceParent;
	ModernPresentation *_generatedChildBefore;
	ModernPresentation *_generatedChildAfter;
	ModernPresentation *_generatedChildAround;
}
@property (strong, nonatomic) Modern *node;
@property (strong, nonatomic) ModernStyle *style;
@property (strong, nonatomic) ModernStyle *computedStyle;

- (id) initWithNode: (Modern *) node;

- (NSArray *) structuralChildren;
- (void) addStructuralChild: (ModernPresentation *) child;
- (void) addStructuralChild: (ModernPresentation *) child
         atIndex: (NSUInteger) index;
- (ModernPresentation *) getStructuralParent;
- (void) setStructuralParent: (ModernPresentation *) parent;
- (NSUInteger) indexOfStructuralChild: (ModernPresentation *) child;

- (ModernPresentation *) getInheritanceParent;
- (void) setInheritanceParent: (ModernPresentation *) parent;

- (BOOL) hasGeneratedChildBefore;
- (void) removeGeneratedChildBefore;
- (ModernPresentation *) generatedChildBefore;

- (BOOL) hasGeneratedChildAfter;
- (void) removeGeneratedChildAfter;
- (ModernPresentation *) generatedChildAfter;

- (BOOL) hasGeneratedChildAround;
- (void) removeGeneratedChildAround;
- (ModernPresentation *) generatedChildAround;

- (void) recomputeStyleWithSheets: (NSArray *) styleSheets
         evenIfGenerated: (BOOL) evenIfGenerated;
- (NSString *) text;
@end
