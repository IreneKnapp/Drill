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
	NSMutableArray *_children;
	ModernPresentation *_parent;
}
@property (strong, nonatomic) Modern *node;
@property (strong, nonatomic) ModernStyle *style;

- (id) initWithNode: (Modern *) node;
- (NSArray *) children;
- (void) addChild: (ModernPresentation *) child;
- (void) addChild: (ModernPresentation *) child
         atIndex: (NSUInteger) index;
- (ModernPresentation *) getParent;
- (void) setParent: (ModernPresentation *) parent;
@end
