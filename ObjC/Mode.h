//
//  Mode.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DocumentView;
@protocol Mode <NSObject>
- (NSArray *) availableCommands: (DocumentView *) documentView;
- (NSArray *) adviceHeaderItems: (DocumentView *) documentView;
- (NSArray *) adviceFooterItems: (DocumentView *) documentView;
@end
