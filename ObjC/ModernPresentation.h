//
//  ModernPresentation.h
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Modern;
@class ModernStyle;
@interface ModernPresentation : NSObject
@property (strong, nonatomic) Modern *node;
@property (strong, nonatomic) NSMutableArray *children;
@property (strong, nonatomic) ModernPresentation *parent;
@property (strong, nonatomic) ModernStyle *style;

- (id) initWithNode: (Modern *) node;
@end
