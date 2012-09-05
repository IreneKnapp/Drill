//
//  ModernStyleContent.m
//  Drill
//
//  Created by Irene Knapp on 9/5/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import "ModernStyleContent.h"
#import "ModernStyleContentItem.h"

@implementation ModernStyleContent

- (id) initAsNone {
    self = [super init];
    if(self) {
        _type = NoneModernStyleContentType;
        _items = nil;
    }
    return self;
}


- (id) initAsContentList {
    self = [super init];
    if(self) {
        _type = ContentListModernStyleContentType;
        _items = [NSMutableArray arrayWithCapacity: 8];
    }
    return self;
}


- (BOOL) isNone {
    return _type == NoneModernStyleContentType;
}


- (BOOL) isContentList {
    return _type == ContentListModernStyleContentType;
}


- (size_t) count {
    if(_type != ContentListModernStyleContentType) return 0;
    
    return [_items count];
}


- (ModernStyleContentItem *) itemAtIndex: (size_t) index {
    if(_type != ContentListModernStyleContentType) return nil;
    
    return [_items objectAtIndex: index];
}


- (void) insertItem: (ModernStyleContentItem *) item
         atIndex: (size_t) index
{
    if(_type != ContentListModernStyleContentType) return;
    
    [_items insertObject: item atIndex: index];
}


- (void) removeItemAtIndex: (size_t) index {
    if(_type != ContentListModernStyleContentType) return;
    
    [_items removeObjectAtIndex: index];
}


- (void) addItem: (ModernStyleContentItem *) item {
    if(_type != ContentListModernStyleContentType) return;
    
    [_items addObject: item];
}


- (void) removeLastItem {
    if(_type != ContentListModernStyleContentType) return;
    
    [_items removeLastObject];
}


- (void) replaceItemAtIndex: (size_t) index
         withItem: (ModernStyleContentItem *) item
{
    if(_type != ContentListModernStyleContentType) return;
    
    [_items replaceObjectAtIndex: index withObject: item];
}

@end
