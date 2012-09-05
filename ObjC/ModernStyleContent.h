//
//  ModernStyleContent.h
//  Drill
//
//  Created by Irene Knapp on 9/5/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    ContentListModernStyleContentType,
    NoneModernStyleContentType,
} ModernStyleContentType;

@class ModernStyleContentItem;
@interface ModernStyleContent : NSObject {
    ModernStyleContentType _type;
    NSMutableArray *_items;
}

- (id) initAsNone;
- (id) initAsContentList;
- (BOOL) isNone;
- (BOOL) isContentList;
- (size_t) count;
- (ModernStyleContentItem *) itemAtIndex: (size_t) index;
- (void) insertItem: (ModernStyleContentItem *) item
         atIndex: (size_t) index;
- (void) removeItemAtIndex: (size_t) index;
- (void) addItem: (ModernStyleContentItem *) item;
- (void) removeLastItem;
- (void) replaceItemAtIndex: (size_t) index
         withItem: (ModernStyleContentItem *) item;
@end
