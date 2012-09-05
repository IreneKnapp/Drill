//
//  ModernStyleContentItem.h
//  Drill
//
//  Created by Irene Knapp on 9/5/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ContentsModernStyleContentItemType,
    StringModernStyleContentItemType,
} ModernStyleContentItemType;

@interface ModernStyleContentItem : NSObject {
    ModernStyleContentItemType _type;
    NSString *_stringValue;
}

- (id) initAsContents;
- (id) initAsString: (NSString *) string;
- (BOOL) isContents;
- (BOOL) isString;
- (NSString *) stringValue;
- (void) setStringValue: (NSString *) string;
@end
