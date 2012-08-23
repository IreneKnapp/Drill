//
//  SchemaMode.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/23/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mode.h"

typedef enum {
    topLevelSchemaModeSubmode,
    addNewTypeSchemaModeSubmode,
    addNewValueSchemaModeSubmode,
} SchemaModeSubmode;

@interface SchemaMode : NSObject <Mode> {
    NSMutableArray *_topLevelCommands;
    NSMutableArray *_addNewTypeCommands;
    NSMutableArray *_addNewValueCommands;
}
@property (nonatomic) SchemaModeSubmode submode;

- (id) init;
- (NSArray *) availableCommands: (DocumentView *) documentView;
- (NSArray *) adviceHeaderItems: (DocumentView *) documentView;
- (NSArray *) adviceFooterItems: (DocumentView *) documentView;
@end
