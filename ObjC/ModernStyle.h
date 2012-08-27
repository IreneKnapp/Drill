//
//  ModernStyle.h
//  Drill
//
//  Created by Irene Knapp on 8/25/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	textModernStyleDisplay,
	mathModernStyleDisplay,
	graphicModernStyleDisplay,
	inheritModernStyleDisplay,
	noneModernStyleDisplay,
} ModernStyleDisplay;

@interface ModernStyle : NSObject {
	BOOL _displaySet;
	ModernStyleDisplay _display;
}
@property (strong, nonatomic) ModernStyle *parent;

- (id) initWithParent: (ModernStyle *) parent;
- (BOOL) displayIsSet;
- (void) unsetDisplay;
- (void) setDisplay: (ModernStyleDisplay) display;
- (ModernStyleDisplay) display;
- (ModernStyleDisplay) computedDisplay: (ModernStyle *) inherited;
@end
