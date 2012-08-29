//
//  ModernStyle.h
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TextModernStyleDisplay,
	MathModernStyleDisplay,
	GraphicModernStyleDisplay,
	InheritModernStyleDisplay,
	NoneModernStyleDisplay,
} ModernStyleDisplay;

typedef enum {
    LeftModernStyleTextAlignment,
    CenterModernStyleTextAlignment,
    RightModernStyleTextAlignment,
    JustifyModernStyleTextAlignment,
    InheritModernStyleTextAlignment,
} ModernStyleTextAlignment;

@interface ModernStyle : NSObject {
	BOOL _displaySet;
	ModernStyleDisplay _display;
	BOOL _textAlignmentSet;
	ModernStyleTextAlignment _textAlignment;
}
@property (strong, nonatomic) ModernStyle *parent;
@property (strong, nonatomic) ModernStyle *container;

- (id) initWithParent: (ModernStyle *) parent
       container: (ModernStyle *) container;

- (BOOL) displayIsSet;
- (void) unsetDisplay;
- (void) setDisplay: (ModernStyleDisplay) display;
+ (ModernStyleDisplay) defaultDisplay;
- (ModernStyleDisplay) display;
- (ModernStyleDisplay) computedDisplay;

- (BOOL) textAlignmentIsSet;
- (void) unsetTextAlignment;
- (void) setTextAlignment: (ModernStyleTextAlignment) textAlignment;
+ (ModernStyleTextAlignment) defaultTextAlignment;
- (ModernStyleTextAlignment) textAlignment;
- (ModernStyleTextAlignment) computedTextAlignment;
@end
