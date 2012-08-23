//
//  AppDelegate.h
//  modern-data-editor
//
//  Created by Irene Knapp on 8/22/12.
//  Copyright (c) 2012 Irene Knapp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AdviceView;
@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (strong, nonatomic) IBOutlet NSPanel *advicePanel;
@property (strong, nonatomic) IBOutlet AdviceView *adviceView;
@property (nonatomic) BOOL inFullScreenTransition;

- (void) applicationDidFinishLaunching: (NSNotification *) notification;
- (void) applicationDidBecomeActive: (NSNotification *) notification;
- (void) hideAdviceWithNotification: (NSNotification *) notification;
- (void) hideAdvice;
- (void) showAdviceWithNotification: (NSNotification *) notification;
- (void) showAdviceWithWindow: (NSWindow *) window;
- (void) setAdvice: (NSString *) advice;
@end