//
//  Glue.h
//  Drill
//
//  Created by Irene Knapp on 8/27/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Glue : NSObject
@property (nonatomic) CGFloat base;
@property (nonatomic) CGFloat stretch;
@property (nonatomic) CGFloat shrink;

- (id) initWithBase: (CGFloat) base
       stretch: (CGFloat) stretch
       shrink: (CGFloat) shrink;
@end
