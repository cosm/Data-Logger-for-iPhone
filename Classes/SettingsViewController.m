//
//  SettingsViewController.m
//  pachubeTab
//
//  Created by Christopher  on 19/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"

@implementation SettingsViewController
@synthesize userName, passWord, feedNumber, streamNumber;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */




- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	
	
	userName.delegate = self;
	passWord.delegate = self;
	feedNumber.delegate = self;
	streamNumber.delegate = self;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//	NSString *mainTitleText =[NSString stringWithFormat:@"THIS IS NEW"];	
//	[prefs setObject:mainTitleText forKey:@"mainTitle"];
	
	NSString* titleTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
	userName.text = titleTemp;
	
	NSString* passWordTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
	passWord.text = passWordTemp;
	
	NSString* feedNumberTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
	feedNumber.text = feedNumberTemp;
	
	NSString* streamNumberTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"streamid"]; 
	streamNumber.text = streamNumberTemp;
	
}

- (IBAction)savePrefs: (id)sender{
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSString *userNameTemp2 =[NSString stringWithFormat:@"%@", userName.text];	
	[prefs setObject:userNameTemp2 forKey:@"username"];
	
	NSString *passWordTemp2 =[NSString stringWithFormat:@"%@", passWord.text];	
	[prefs setObject:passWordTemp2 forKey:@"password"];
	
	NSString *feedNumberTemp2 =[NSString stringWithFormat:@"%@", feedNumber.text];	
	[prefs setObject:feedNumberTemp2 forKey:@"feedid"];
	
	NSString *streamNumberTemp2 =[NSString stringWithFormat:@"%@", streamNumber.text];	
	[prefs setObject:streamNumberTemp2 forKey:@"streamid"];
	
};

- (BOOL) textFieldShouldReturn:(UITextField *)aTextField 
{
	// The return key is set to Done, so hide the keyboard
	[aTextField resignFirstResponder];
	return YES;
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}




@end
