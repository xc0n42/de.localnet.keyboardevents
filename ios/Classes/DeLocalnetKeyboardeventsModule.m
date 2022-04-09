/**
 * de.localnet.keyboardevents
 *
 * Created by Your Name
 * Copyright (c) 2022 Your Company. All rights reserved.
 */

#import "DeLocalnetKeyboardeventsModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation DeLocalnetKeyboardeventsModule

#pragma mark Internal

// This is generated for your module, please do not change it
- (id)moduleGUID
{
  return @"79ad6670-df80-4019-ab7a-26893d5c7f9f";
}

// This is generated for your module, please do not change it
- (NSString *)moduleId
{
  return @"de.localnet.keyboardevents";
}

#pragma mark Lifecycle

- (void)startup
{
	// This method is called when the module is first loaded
	// You *must* call the superclass
	[super startup];
	
	// Register for keyboard notifications
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	DebugLog(@"[DEBUG] %@ loaded", self);
}

-(void)shutdown:(id)sender
{
	// This method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// Unregister keyboard notifications
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
	// you *must* call the superclass
	[super shutdown:sender];
}


#pragma mark Event handlers

- (void)keyboardWillShow:(NSNotification *)aNotification
{
	NSDictionary* userInfo = [aNotification userInfo];
	
	// Get height of keyboard
	CGRect keyboardEndFrame;
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
	NSNumber *keyboardHeight = [NSNumber numberWithFloat:keyboardEndFrame.size.height];
	
	// Event object
	NSMutableDictionary *event = [NSMutableDictionary dictionary];
	[event setValue:keyboardHeight forKey:@"keyboardHeight"];
	
	[self fireEvent:@"keyboardWillShow" withObject:event];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
	[self fireEvent:@"keyboardWillHide" withObject:nil];
}

@end
