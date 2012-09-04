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

+ (NSArray *) allProperties;
+ (size_t) propertyInitialValueSize: (NSString *) name;
+ (BOOL) copyPropertyInitialValue: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize;
- (id) init;
- (size_t) propertySize: (NSString *) name;
- (BOOL) propertyIsSet: (NSString *) name;
- (BOOL) copyProperty: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize;
- (BOOL) setProperty: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize;
- (BOOL) unsetProperty: (NSString *) name;
- (BOOL) setProperty: (NSString *) name
         from: (ModernStyle *) otherStyle;
- (BOOL) setPropertyToInitialValue: (NSString *) name;
@end
