//
//  ModernStyleContentItem.m
//  Drill
//
//  Created by Irene Knapp on 9/5/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleContentItem.h"

@implementation ModernStyleContentItem

- (id) initAsContents {
    self = [super init];
    if(self) {
        _type = ContentsModernStyleContentItemType;
        _stringValue = nil;
    }
    return self;
}


- (id) initAsString: (NSString *) string {
    self = [super init];
    if(self) {
        _type = StringModernStyleContentItemType;
        _stringValue = string;
    }
    return self;
}


- (BOOL) isContents {
    return _type == ContentsModernStyleContentItemType;
}


- (BOOL) isString {
    return _type == StringModernStyleContentItemType;
}


- (NSString *) stringValue {
    if(_type != StringModernStyleContentItemType) return nil;
    
    return _stringValue;
}


- (void) setStringValue: (NSString *) string {
    if(_type != StringModernStyleContentItemType) return;
    
    _stringValue = string;
}

@end
