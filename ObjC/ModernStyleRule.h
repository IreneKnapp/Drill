//
//  ModernStyleRule.h
//  Drill
//
//  Created by Irene Knapp on 9/4/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ModernStyle;
@protocol ModernStyleSelector;
@interface ModernStyleRule : NSObject
@property (strong, nonatomic) id <ModernStyleSelector> selector;
@property (strong, nonatomic) ModernStyle *style;

- (id) initWithSelector: (id <ModernStyleSelector>) selector
       style: (ModernStyle *) style;
@end
