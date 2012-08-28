//
//  Glue.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Glue : NSObject {
	BOOL _isInfinite;
	CGFloat _base;
	CGFloat _stretch;
	CGFloat _shrink;
}

- (id) initWithBase: (CGFloat) base
       stretch: (CGFloat) stretch
       shrink: (CGFloat) shrink;
- (id) initAsInfinite;
- (BOOL) isInfinite;
- (CGFloat) base;
- (CGFloat) stretch;
- (CGFloat) shrink;
@end
