//
//  LayoutManager.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Glue;
@class ModernPresentation;
@protocol Box;
@interface LayoutManager : NSObject {
    ModernPresentation *_rootPresentation;
    BOOL _layoutValid;
    size_t _characterBufferCount;
    size_t _characterBufferCapacity;
    unichar *_characterBuffer;
    id <Box> _box;
}

- (id) initWithPresentation: (ModernPresentation *) rootPresentation;
- (void) appendCharacters: (unichar *) characters count: (size_t) count;
- (void) recomputeLayout;
- (void) draw: (NSRect) dirtyRect;
@end
