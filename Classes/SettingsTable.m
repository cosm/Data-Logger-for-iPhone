//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 1.0.01


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

// TODO: Make switching between forms count as finishing an edit


#import "SettingsTable.h"


@implementation SettingsTable

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kUsernameTextField = @"usernameKey";
static NSString *kPasswordTextField = @"passwordKey";


#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0
#define kTextFieldHeight		30.0
#define kTextFieldWidth			260.0

@synthesize textFieldNormal, textFieldSecure, dataSourceArray;


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
		
	static NSString *CellIdentifier = @"Cell";
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Set up the cell...
	
	if (section == 0){	
	if (row == 0){
		
		NSString *cellValue = @"Username";
		cell.text = cellValue;
		UITextField *usernameTextField = textFieldNormal;
		usernameTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
		[cell.contentView addSubview:usernameTextField];

	}
	
	if (row == 1){
		
		NSString *cellValue = @"Password";
		cell.text = cellValue;
		UITextField *passwordTextField = textFieldSecure;
		passwordTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
		[cell.contentView addSubview:passwordTextField];
		
	} 
	} else {
	
	if (row == 0)	{
		NSString *cellValue = @"Update Locations";
				cell.text = cellValue;
		}
	}
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	return cell;
	
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
}
    
	
-(void)textFieldDidEndEditing:(UITextField *)textField {
		
		textFieldNormal.userInteractionEnabled = YES;
		textFieldSecure.userInteractionEnabled = YES;
		
}
	
	
	
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	
	[textField resignFirstResponder];
	
    [[NSUserDefaults standardUserDefaults] setObject:textFieldNormal.text forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:textFieldSecure.text forKey:@"password"];

    return YES;
	
}

- (UITextField *)textFieldNormal
{
	if (textFieldNormal == nil)
	{
		CGRect frame = CGRectMake(110.0, 14.0, 190.0, 30.0);
		textFieldNormal = [[UITextField alloc] initWithFrame:frame];
		textFieldNormal.borderStyle = UITextBorderStyleNone;
		textFieldNormal.textColor = [UIColor blackColor];
		textFieldNormal.font = [UIFont systemFontOfSize:17.0];
		textFieldNormal.placeholder = @"Username";
		textFieldNormal.backgroundColor = [UIColor whiteColor];
		textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		textFieldNormal.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
		textFieldNormal.returnKeyType = UIReturnKeyDone;
		textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		textFieldNormal.tag = kUsernameTextField;		// tag this control so we can remove it later for recycled cells
		textFieldNormal.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	
	}
	
	return textFieldNormal;
}



- (UITextField *)textFieldSecure
{
	if (textFieldSecure == nil)
	{
		CGRect frame = CGRectMake(110.0, 14.0, 187.0, 30.0);
		textFieldSecure = [[UITextField alloc] initWithFrame:frame];
		textFieldSecure.borderStyle = UITextBorderStyleNone;
		textFieldSecure.textColor = [UIColor blackColor];
		textFieldSecure.font = [UIFont systemFontOfSize:17.0];
		textFieldSecure.placeholder = @"Password";
		textFieldSecure.backgroundColor = [UIColor whiteColor];
		textFieldSecure.keyboardType = UIKeyboardTypeDefault;
		textFieldSecure.returnKeyType = UIReturnKeyDone;	
		textFieldSecure.secureTextEntry = YES;	// make the text entry secure (bullets)
		textFieldSecure.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		textFieldSecure.tag = kPasswordTextField;
		textFieldSecure.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	}
	
	return textFieldSecure;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case (0):
			return 2;
			break;
        case (1):
			return 1;
			break;

    }
	
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case (0):
			return @"Pachube Login Details";
			break;
        case (1):
			return @"Pachube Log";
			break;

    }
	
    return nil;
}



- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"[%@ viewDidAppear:%d]", [self class], animated);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"[%@ viewWillDisappear:%d]", [self class], animated);
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
    
	[[NSUserDefaults standardUserDefaults] synchronize];
	self.view = nil;
	
	[super viewDidDisappear:animated];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad {
    [super viewDidLoad];

	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,400)style: UITableViewStyleGrouped];
	self.title = NSLocalizedString(@"Settings", @"");
	

	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UITextField", kSectionTitleKey,
							 @"TextFieldController.m: textFieldNormal", kSourceKey,
							 self.textFieldNormal, kUsernameTextField,
							 nil],

							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UITextField Secure", kSectionTitleKey,
							 @"TextFieldController.m: textFieldSecure", kSourceKey,
							 self.textFieldSecure, kPasswordTextField,
							 nil],

							nil];
	
	

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 50.0;
}

- (void)didReceiveMemoryWarning {
	
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
	self.tableView = nil;
	textFieldNormal = nil;
	textFieldSecure = nil;

	[textFieldNormal release];
	[textFieldSecure release];
	
}

- (void)dealloc {
	
	[textFieldNormal release];
	[textFieldSecure release];

    [super dealloc];
}


@end
