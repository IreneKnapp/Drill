//
//  ModernStyle.m
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyle.h"
#import "ModernStyleContent.h"

@implementation ModernStyle

+ (NSArray *) allProperties {
    static NSMutableArray *result = nil;
    
    if(!result) {
        result = [NSMutableArray arrayWithCapacity: 8];
        [result addObject: @"display"];
        [result addObject: @"text-alignment"];
        [result addObject: @"content"];
    }
    
    return (NSArray *) result;
}


+ (size_t) propertyInitialValueSize: (NSString *) name {
    if([name isEqualToString: @"display"]) {
        return sizeof(ModernStyleDisplay);
    } else if([name isEqualToString: @"text-alignment"]) {
        return sizeof(ModernStyleTextAlignment);
    } else if([name isEqualToString: @"content"]) {
        return sizeof(ModernStyleContent *);
    } else {
        return 0;
    }
}


+ (BOOL) copyPropertyInitialValue: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize
{
    if(propertySize < [ModernStyle propertyInitialValueSize: name]) return NO;
    
    if([name isEqualToString: @"display"]) {
        *((ModernStyleDisplay *) data) = NoneModernStyleDisplay;
    } else if([name isEqualToString: @"text-alignment"]) {
        *((ModernStyleTextAlignment *) data) = LeftModernStyleTextAlignment;
    } else if([name isEqualToString: @"content"]) {
        id result = [[ModernStyleContent alloc] initAsNone];
        *((void **) data) = (__bridge_retained void *) result;
    } else {
        return NO;
    }
    
    return YES;
}


- (id) init {
	self = [super init];
	if(self) {
		_displaySet = NO;
		_textAlignmentSet = NO;
		_contentSet = NO;
		_content = nil;
	}
	return self;
}


- (size_t) propertySize: (NSString *) name {
    if([name isEqualToString: @"display"]) {
        return sizeof(ModernStyleDisplay);
    } else if([name isEqualToString: @"text-alignment"]) {
        return sizeof(ModernStyleTextAlignment);
    } else if([name isEqualToString: @"content"]) {
        return sizeof(ModernStyleContent *__strong *);
    } else {
        return 0;
    }
}


- (BOOL) propertyIsSet: (NSString *) name {
    if([name isEqualToString: @"display"]) {
        return _displaySet;
    } else if([name isEqualToString: @"text-alignment"]) {
        return _textAlignmentSet;
    } else if([name isEqualToString: @"content"]) {
        return _contentSet;
    } else {
        return NO;
    }
}


- (BOOL) propertyIsInherit: (NSString *) name {
    if(![self propertyIsSet: name]) return NO;
    
    if([name isEqualToString: @"display"]) {
        return _display == InheritModernStyleDisplay;
    } else if([name isEqualToString: @"text-alignment"]) {
        return _textAlignment == InheritModernStyleTextAlignment;
    } else if([name isEqualToString: @"content"]) {
        return NO;
    } else {
        return NO;
    }
}


- (BOOL) copyProperty: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize
{
    if(propertySize < [self propertySize: name]) return NO;
    if(![self propertyIsSet: name]) return NO;
    
    if([name isEqualToString: @"display"]) {
        *((ModernStyleDisplay *) data) = _display;
    } else if([name isEqualToString: @"text-alignment"]) {
        *((ModernStyleTextAlignment *) data) = _textAlignment;
    } else if([name isEqualToString: @"content"]) {
        *((void **) data) = (__bridge_retained void *) _content;
    } else {
        return NO;
    }
    
    return YES;
}


- (BOOL) setProperty: (NSString *) name
         data: (void *) data
         size: (size_t) propertySize
{
    if(propertySize < [self propertySize: name]) return NO;
    
    if([name isEqualToString: @"display"]) {
        _displaySet = YES;
        _display = *(ModernStyleDisplay *) data;
    } else if([name isEqualToString: @"text-alignment"]) {
        _textAlignmentSet = YES;
        _textAlignment = *(ModernStyleTextAlignment *) data;
    } else if([name isEqualToString: @"content"]) {
        _contentSet = YES;
        _content = (__bridge id) *(void **) data;
    } else {
        return NO;
    }
    
    return YES;
}


- (BOOL) unsetProperty: (NSString *) name {
    if([name isEqualToString: @"display"]) {
        _displaySet = NO;
    } else if([name isEqualToString: @"text-alignment"]) {
        _textAlignmentSet = NO;
    } else if([name isEqualToString: @"content"]) {
        _contentSet = NO;
        _content = nil;
    } else {
        return NO;
    }
    
    return YES;
}


- (BOOL) setProperty: (NSString *) name
         from: (ModernStyle *) otherStyle
{
    BOOL result = YES;
    
    size_t propertySize = [otherStyle propertySize: name];
    
    void *propertyValue = malloc(propertySize);
    
    if([otherStyle copyProperty: name
                   data: propertyValue
                   size: propertySize])
    {
        if(![self setProperty: name
                  data: propertyValue
                  size: propertySize])
        {
            result = NO;
        }
    } else {
        result = NO;
    }
    
    free(propertyValue);
    
    return result;
}


- (BOOL) setPropertyToInitialValue: (NSString *) name
{
    BOOL result = YES;
    
    size_t propertySize = [ModernStyle propertyInitialValueSize: name];
    
    void *propertyValue = malloc(propertySize);
    
    if([ModernStyle copyPropertyInitialValue: name
                    data: propertyValue
                    size: propertySize])
    {
        if(![self setProperty: name
                  data: propertyValue
                  size: propertySize])
        {
            result = NO;
        }
    } else {
        result = NO;
    }
    
    free(propertyValue);
    
    return result;
}

@end
