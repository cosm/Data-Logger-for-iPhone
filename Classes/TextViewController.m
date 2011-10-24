//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 0.28


//	This file is part of Data Logger for iPhone.
//
//	Data Logger for iPhone is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	Data Logger for iPhone is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with Data Logger for iPhone.  If not, see <http://www.gnu.org/licenses/>.


#import "TextViewController.h"

@implementation TextViewController

@synthesize textView, mainText, feedNumber;

- (void)dealloc
{
	[textView release];
	[super dealloc];
}


#pragma mark Save Changes

- (void)storeDesc {
	
	mainText = textView.text;
	

	NSMutableArray *tempArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
	NSMutableDictionary *tempDict = [[tempArray objectAtIndex:[feedNumber integerValue]] mutableCopy];
	
	[tempDict setObject:mainText forKey:@"fdDescription"];
	[tempArray replaceObjectAtIndex:[feedNumber integerValue] withObject:tempDict];
	[[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"AllTheFeeds"];
	
	[tempDict release];
	[tempArray release];
	
}

- (void)setupTextView
{
	self.textView = [[[UITextView alloc] initWithFrame:self.view.frame] autorelease];
	self.textView.textColor = [UIColor blackColor];
	self.textView.font = [UIFont fontWithName:@"Arial" size:18];
	self.textView.delegate = self;
	self.textView.backgroundColor = [UIColor whiteColor];
	
	//self.textView.text = @"This is the default description.";
	self.textView.returnKeyType = UIReturnKeyDefault;
	self.textView.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	self.textView.scrollEnabled = YES;
	
	// this will cause automatic vertical resize when the table is resized
	self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
	
	// note: for UITextView, if you don't like autocompletion while typing use:
	// myTextView.autocorrectionType = UITextAutocorrectionTypeNo;
	
	self.textView.text = mainText;
	
	[self.view addSubview: self.textView];
}

- (void)viewDidLoad
{
	if (mainText == nil){
	
		mainText = @"Please add a text Description...";
	}
	
	
	
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"Edit Description", @"");
	[self setupTextView];
	
}

// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload
{
	[super viewDidUnload];
	
	self.textView = nil;
}

- (void)viewWillAppear:(BOOL)animated 
{
    // listen for keyboard hide/show notifications so we can properly adjust the table's height
	[super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated 
{
    [super viewDidDisappear:animated];
	
	[self storeDesc];
	
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
	
}


- (void)keyboardWillShow:(NSNotification *)aNotification 
{
	// the keyboard is showing so resize the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
   // NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height -= keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
   // [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    // the keyboard is hiding reset the table's height
	CGRect keyboardRect = [[[aNotification userInfo] objectForKey:UIKeyboardBoundsUserInfoKey] CGRectValue];
    //NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = self.view.frame;
    frame.size.height += keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
  //  [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
	[self storeDesc];
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
	// provide my own Save button to dismiss the keyboard
	UIBarButtonItem* saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
															target:self action:@selector(saveAction:)];
	self.navigationItem.rightBarButtonItem = saveItem;
	[saveItem release];
}

- (void)saveAction:(id)sender
{
	// finish typing text/dismiss the keyboard by removing it as the first responder
	//
	[self.textView resignFirstResponder];
	self.navigationItem.rightBarButtonItem = nil;	// this will remove the "save" button
}

@end

