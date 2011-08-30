//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 0.27


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

#import "SetUpViewController.h"


#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0
#define kTweenMargin			10.0
#define kTextFieldHeight		20.0


@implementation SetUpViewController

@synthesize floatSwitch, mostRecentResponseCode, saveFeed, segmentLabeler, currentPicker, topRangeNum, botRangeNum, tags, unit, unitFull;
@synthesize tempArray, tempFeedNumber, myPickerView, editingMode, pickerViewArray, label, rowSelect, feedNumber, disabledCover, creationSpinner;





#pragma mark -
#pragma mark UIPickerView

- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
								   screenRect.size.height - 88 - size.height,
								   size.width,	
								   size.height);
	return pickerRect;
}

- (void)createPicker
{     
	pickerViewArray = [[NSArray arrayWithObjects:
						@"Custom",
						@"Humidity (%)", 
						@"Temperature (°C)", 
						@"Temperature (°F)",
						@"Resistance (Ω)",
						@"Volts (V)",
						@"Current (A)",
						@"Power (W)", 
						@"Cups of Coffee",
						@"Number of Pigeons Sighted",
						@"Mood Map",
						nil] retain];
	//unitArray = [[NSArray arrayWithObjects:
	//					@"°C", @"kW", @"%", @"kg", @"Custom",nil] retain];
	// note we are using CGRectZero for the dimensions of our picker view,
	// this is because picker views have a built in optimum size,
	// you just need to set the correct origin in your view.
	
	// position the picker at the bottom
	myPickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
	CGSize pickerSize = [myPickerView sizeThatFits:CGSizeZero];
	myPickerView.frame = [self pickerFrameWithSize:pickerSize];
	
	myPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	myPickerView.showsSelectionIndicator = YES;	// note this is default to NO
	
	// this view controller is the data source and delegate
	myPickerView.delegate = self;
	myPickerView.dataSource = self;
	
	// add this picker to our view controller, initially hidden
	myPickerView.hidden = YES;
	[self.view addSubview:myPickerView];
}

// return the picker frame based on its size, positioned at the bottom of the page


#pragma mark -

- (void)showPicker:(UIView *)picker
{
	// hide the current picker and show the new one
	if (currentPicker)
	{
		currentPicker.hidden = YES;
		label.text = @"";
	}
	
	picker.hidden = NO;
	currentPicker = picker;	// remember the current picker so we can remove it later when another one is chosen
}


#pragma mark -
#pragma mark UIPickerViewDelegate

// This code isn't very effiecient
// but sets up the defaults.


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	
	
	[self checkEdit];
	
	
	
	if (row == 1){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"100.00";
		heading.text = @"Relative Humidity";
		tags.text = @"relative humidity";
		unit.text = @"%";
		unitFull.text = @"Percentage";
		floatSwitch.selectedSegmentIndex = 1;
		
	} else if (row == 2){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"100.00";
		heading.text = @"Temperature";
		tags.text = @"temperature";
		unit.text = @"°C";
		unitFull.text = @"Celsius";
		floatSwitch.selectedSegmentIndex = 1;
		
	}	else if (row == 3){
		
		botRangeNum.text = @"32.00";
		topRangeNum.text = @"451.00";
		heading.text = @"Temperature";
		tags.text = @"temperature";
		unit.text = @"°F";
		unitFull.text = @"Fahrenheit";
		floatSwitch.selectedSegmentIndex = 1;
		
	}	else if (row == 4){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"1024.00";
		heading.text = @"Resistance";
		tags.text = @"resistance";
		unit.text = @"Ω";
		unitFull.text = @"Ohms";
		floatSwitch.selectedSegmentIndex = 1;
		
	}	else if (row == 5){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"10000.00";
		heading.text = @"Voltage";
		tags.text = @"voltage";
		unit.text = @"V";
		unitFull.text = @"Volts";
		floatSwitch.selectedSegmentIndex = 1;
		
	}	else if (row == 6){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"400.00";
		heading.text = @"Current";
		tags.text = @"current";
		unit.text = @"A";
		unitFull.text = @"Amps";
		floatSwitch.selectedSegmentIndex = 1;
		
	}   else if (row == 7){
		
		botRangeNum.text = @"0.00";
		topRangeNum.text = @"3000.00";
		heading.text = @"Power";
		tags.text = @"power";
		unit.text = @"W";
		unitFull.text = @"Watts";
		floatSwitch.selectedSegmentIndex = 1;
		
	}	else if (row == 8){
		
		botRangeNum.text = @"0";
		topRangeNum.text = @"25";
		heading.text = @"Cups of Coffee Today";
		tags.text = @"coffee";
		unit.text = @"";
		unitFull.text = @"Cups";
		floatSwitch.selectedSegmentIndex = 0;
		
	} else if (row == 9){
		
		botRangeNum.text = @"0";
		topRangeNum.text = @"150";
		heading.text = @"Number of Pigeons";
		tags.text = @"pigeons, sightings, birds";
		unit.text = @"";
		unitFull.text = @"Pigeons";
		floatSwitch.selectedSegmentIndex = 0;
		
	}	else if (row == 10){
		
		botRangeNum.text = @"0";
		topRangeNum.text = @"100";
		heading.text = @"Mood Map";
		tags.text = @"mood, contentment, psychogeography";
		unit.text = @"";
		unitFull.text = @"";
		floatSwitch.selectedSegmentIndex = 0;
		
	} else if ( [pickerViewArray objectAtIndex:[pickerView selectedRowInComponent:0]] == @"Custom"){
		
		
		
		botRangeNum.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"customMinNum"];
		topRangeNum.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"customMaxNum"];
		heading.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"customTitle"];
		
		unit.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"customUnit"];
		unitFull.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"customUnitLabel"];
		
		// TODO: possibly store the tags a user adds in the custom section
		tags.text = @"";
		
		
	} else{
		
		botRangeNum.text = @"";
		topRangeNum.text = @"";
		heading.text = @"";
		tags.text = @"";
		
		label.text = [NSString stringWithFormat:@"%@",
					  [pickerViewArray objectAtIndex:[pickerView selectedRowInComponent:0]]];
		
	}
}



#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	if (pickerView == myPickerView)
	{
		if (component == 0)
		{
			returnStr = [pickerViewArray objectAtIndex:row];
		}
		else
		{
			
		}
	}
	
	return returnStr;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	CGFloat componentWidth = 0.0;
	
	if (component == 0)
		componentWidth = 300.0;	// first column size is wider to hold names
	else
		componentWidth = 30.0;	// second column is narrower to show numbers
	
	return componentWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	return 35.0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [pickerViewArray count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}


#pragma mark -
#pragma mark UIViewController delegate methods


// called after this controller's view will appear


- (void)viewWillAppear:(BOOL)animated {
	
    NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
    [super viewWillAppear:animated];
	
	pickerStyleSegmentedControl.hidden = YES;
	[self showPicker:myPickerView];
	
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
	
	[heading resignFirstResponder];
	[botRangeNum resignFirstResponder];
	[topRangeNum resignFirstResponder];
	[unit resignFirstResponder];
	[unitFull resignFirstResponder];
	[tags resignFirstResponder];
	
	
	self.view = nil;
	self.myPickerView = nil;
	self.pickerViewArray = nil;
	self.label = nil;
	
	
	
    [super viewDidDisappear:animated];
}




- (BOOL) textFieldShouldReturn:(UITextField *)aTextField 
{
	
	// The return key is set to Done, so hide the keyboard
	[aTextField resignFirstResponder];
	
	
	[self checkEdit];
	
	
	[myPickerView selectRow:0 inComponent:0 animated:YES];
	
	
	
	if (aTextField.tag == @"topRangeNum") {
		
		NSNumberFormatter * f = [[NSNumberFormatter alloc] init]; 
		NSNumber * n = [f numberFromString:aTextField.text]; 
		aTextField.text = [NSString stringWithFormat:@"%@", n];
		
		if ([aTextField.text floatValue] < [botRangeNum.text floatValue] || aTextField.text == @"" || aTextField.text == @"(null)" || aTextField.text == nil || [aTextField.text isEqualToString:@""]) {
			
			[self alertTopRangeIsInvalid];
			topRangeNum.text = [feedDictionary objectForKey:@"fdMaxNum"];
			
			
			
		}
		[f release];		
	} else if (aTextField.tag == @"botRangeNum") {
		
		NSNumberFormatter * f = [[NSNumberFormatter alloc] init]; 
		NSNumber * n = [f numberFromString:aTextField.text]; 
		aTextField.text = [NSString stringWithFormat:@"%@", n];
		
		if ([aTextField.text floatValue] > [topRangeNum.text floatValue] || aTextField.text == @"" || aTextField.text == @"(null)" || aTextField.text == nil || [aTextField.text isEqualToString:@""]) {
			
			[self alertBottomRangeIsInvalid];
		  	botRangeNum.text = [feedDictionary objectForKey:@"fdMinNum"];
			
			
			
		}
		
		
		[f release];
		
	}
	
	//	[prefs setInteger:[myPickerView selectedRowInComponent:0] forKey:@"fdPickerID"];
	
	return YES;
	
}


-(void)alertBottomRangeIsInvalid{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Range Error" message:@"The Range You Have Entered Is Invalid. The Upper Value Must Be More Than the Lower Value."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	
	//topRangeNum.text = [feedDictionary objectForKey:@"fdMaxNum"];
	
	alert.tag = @"alertBottomRangeIsInvalid";
	[alert show];
	[alert release];
	
	
}

-(void)alertTopRangeIsInvalid{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Range Error" message:@"The Range You Have Entered Is Invalid. The Lower Value Must Be Less Than the Upper Value."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	
	
	alert.tag = @"alertBottomRangeIsInvalid";
	[alert show];
	[alert release];
	
	
}


-(void)disableTextBoxes

{
	
	
	[disabledCover setHidden:NO];
	disabledCover.userInteractionEnabled = NO;
	self.currentPicker.userInteractionEnabled = NO;
	[botRangeNum setEnabled:NO];
	[topRangeNum setEnabled:NO];
	[heading setEnabled:NO];
	[tags setEnabled:NO];
	[unit setEnabled:NO];
	[unitFull setEnabled:NO];
	[floatSwitch setEnabled:NO];
	
	
	
	
}

-(void)enableTextBoxes

{
	self.currentPicker.userInteractionEnabled = YES;
	[creationSpinner setHidden:YES];
	[disabledCover setHidden:YES];
	[botRangeNum setEnabled:YES];
	[topRangeNum setEnabled:YES];
	[heading setEnabled:YES];
	[tags setEnabled:YES];
	[unit setEnabled:YES];
	[unitFull setEnabled:YES];
	[floatSwitch setEnabled:YES];	
	
}



#pragma mark Feed Post
-(void)createNewFeed
{
	
	pachubeTabAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if([delegate CheckReachability]){
		
		
		
		self.navigationItem.hidesBackButton = YES;
		
		[creationSpinner setHidden:NO];
		[creationSpinner startAnimating];
		[self disableTextBoxes];
		[self disableTextBoxes];
		
		
		// the POST request body. A chunk of EEML.
		
		NSString *pachubeXML = [NSString stringWithFormat:
								@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
								"<eeml xmlns=\"http://www.eeml.org/xsd/005\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd\">\n"
								"<environment>\n"
								"<title>%@</title>\n"
								"</environment>\n"
								"</eeml>", heading.text
								];
		//NSLog(pachubeXML);
		
		//the url
		
		//NSString* urlFull = [NSString stringWithFormat:@""];
		NSString* urlFull = [NSString stringWithFormat:@"https://api.pachube.com/v1/feeds.xml"];
		
		NSString* usernameTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
		NSString* passwordTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
		//
		
		if (usernameTemp == NULL || usernameTemp == nil || usernameTemp == @"" || passwordTemp == NULL || passwordTemp == nil ||passwordTemp == @"") {
			
			
			[self resetGraphics];
			[self alert401];
			
			
		} else {
			
			
			NSLog(@"username: %@", usernameTemp);
			NSLog(@"password: %@", passwordTemp);
			
			
			NSLog(@"%@", urlFull);
			
			NSURL *getUrl = [NSURL URLWithString:urlFull];
			NSMutableURLRequest *theGetRequest = [NSMutableURLRequest requestWithURL:getUrl];
			
			// get the length of the body
			NSString *msgLength = [NSString stringWithFormat:@"%d", [pachubeXML length]];
			
			
			//this uses base64Encoding from the NSDatatAdditions class for		the username/password in the https header
			NSString *authString = [[[NSString stringWithFormat:@"%@:%@", usernameTemp, passwordTemp] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
			authString = [NSString stringWithFormat: @"Basic %@", authString];
			
			
			// set up the POST request
			[theGetRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
			[theGetRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
			[theGetRequest addValue:authString forHTTPHeaderField:@"Authorization"];
			[theGetRequest setHTTPMethod:@"POST"];
			[theGetRequest setHTTPBody: [pachubeXML    dataUsingEncoding:NSUTF8StringEncoding]];
			[theGetRequest setTimeoutInterval:4]; 
			
			NSURLConnection *theGetConnection = [[NSURLConnection alloc] initWithRequest:theGetRequest delegate:self];
			
			
			if( theGetConnection )
			{	
				webData = [[NSMutableData data] retain];
			}
			else
			{
				NSLog(@"theGetConnection is NULL");
			}
			
			//[nameInput resignFirstResponder];	
		}	
		
	}
	
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
	
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
	
	NSLog(@"STATUS CODE = %i", responseStatusCode );
	
	mostRecentResponseCode = responseStatusCode;
	
	NSLog(@"connectiong BP: 2");
	
	if (mostRecentResponseCode == 201) {
		
		if ([httpResponse respondsToSelector:@selector(allHeaderFields)]) {
			
			
			NSDictionary *httpDictionary = [httpResponse allHeaderFields];
			NSLog([httpDictionary description]);
			
			// hard code this in defaults
			NSString *location = [httpDictionary objectForKey:@"Location"];

			//gets the integer value of the feed returned in the http header
			tempFeedNumber = [location lastPathComponent];
			
			NSLog(@"Attempts: %i", [tempFeedNumber integerValue]);
			NSLog(@"AS NORMAL = %@", tempFeedNumber);
			
            [newFeedDetails setObject:tempFeedNumber forKey:@"fdID"];
            
			// open a alert with an OK and cancel button
			
			//NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
			//[prefs setInteger:[httpDictionary objectForKey:@"Location"] forKey:@"initialFeed"];
			
			
		}
		
	}	else if (mostRecentResponseCode == 404) {
		
		[self alert404];
		
		
	}	else if (mostRecentResponseCode == 401) {
		
		[self alert401];
		
		
	} else {
		
		NSLog(@"connectiong BP: 5");
		
		[self alertStatusResponse];
		
	}
	
	NSLog(@"connectiong BP: 6");
	
	[webData setLength: 0];
	
	[self resetGraphics];
}

-(void)resetGraphics{
	
	[self enableTextBoxes];
	
	self.navigationItem.hidesBackButton = NO;
	
	[creationSpinner setHidden:YES];
	[creationSpinner stopAnimating];
	
	
}


-(void)infoPage {
	
	FeedInfo *infoController = [[FeedInfo alloc] initWithNibName:@"FeedInfo" bundle:[NSBundle mainBundle]];
	
	//NSLog(@"%i",[tempArray count]);
	
	infoController.feedNumber = feedNumber;
	//infoController.feedNumber = [NSString stringWithFormat:@"%i",[tempArray count]];
	infoController.editMode = @"newFeed";
	[self.navigationController pushViewController:infoController animated:YES];
	
	
	[infoController release];
	
	
	//	infoController.feedNumber;
	infoController = nil;
	
}



-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	NSLog(@"Ok its getting something");
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	//TODO: ADD A ALERT ABOUT AN ERROR WITH THE CONNECTION
	NSLog(@"ERROR with theConenction");
	[connection release];
	[webData release];
	[self resetGraphics];
	[self alertCheckConnection];
	
}		

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	[connection release];
	[webData release];
	
	if(mostRecentResponseCode == 201) {
		
		[self makeNewFeedDict];
		
	}
	
}


#pragma mark Save Feed Edit

-(void)saveEdit:(id)sender {
	
	NSLog(@"THE EDIT TO THE FEED HAS BEEN SAVED");
	
	if(hasBeenEdited){
		[self alertSaveEdit];
	}
}



#pragma mark Alert View

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (actionSheet.tag == @"alertFeedCreationFinished"){
		
		NSLog(@"feedCreation Finsihed");	
		[self infoPage];
		
	} else if (actionSheet.tag == @"alertConfirmFeedCreation" && buttonIndex == 1){
		
		[self createNewFeed];
		
	} else if (actionSheet.tag == @"alertSaveEdit"){
		
		[self makeNewFeedDict];
		
		
	}	else if (actionSheet.tag == @"alertPageExit"){
		
		if (buttonIndex == 2) {
			NSLog(@"Exit no changes");
		} else if (buttonIndex == 1){
			
			NSLog(@"Save with changes");
			
			[self makeNewFeedDict];
		}
		
	} else if (actionSheet.tag == @"alertStatusResponse") {
		NSLog(@"STATUS ALERT");
	}
	
	[actionSheet resignFirstResponder];
	
	
}

#pragma mark Alert Functions


-(void)makeNewFeedDict
{
	
	// this funciton is called when a new feed has been succesfully created
	// or a user decides to save changes to a feed edit
	
	// gets the current dictionary from the app delegate (located in an array called 'AllTheFeeds'
	// changes the relevant objects inside the dictionary
	
	
	// if the feed is being edited it gets a copy of the the current dictionary from the app delegate
	// this dictionary is located in an array called 'AllTheFeeds'
	// and changes the relevant objects inside the dictionary
	// before switching it back in
	
	// if the feed is new, a new dictionary is created
	// and placed at the end of the array 'AllTheFeeds'
	
	
	
	
	if (inEditingMode == YES){
		
		NSLog(@"makenewDict BP: 1.4");
		newFeedDetails = [[tempArray objectAtIndex:[feedNumber integerValue]] mutableCopy];
		
		NSLog([newFeedDetails description]);
		
		NSLog(@"makenewDict BP: 1.5");
	} else {
		
		
		//check if it is a new feed being made
		// if so - add a defualt description
		// and a current value for the slider to move in range.
		// and defualts for feed metadata
		
		NSLog(@"makenewDict BP: 2");
		
		
		[newFeedDetails setObject:[NSString stringWithFormat:@"This feed was created using Data Logger for iPhone."] forKey:@"fdDescription"];
		
		[newFeedDetails setObject:@"NO" forKey:@"fdHasBeenUpdated"];
		[newFeedDetails setObject:@"Mobile" forKey:@"fdDisposition"];
		[newFeedDetails setObject:@"Physical" forKey:@"fdDomain"];
		[newFeedDetails setObject:@"Outdoor" forKey:@"fdExposure"];
		[newFeedDetails setObject:@"" forKey:@"fdURL"];
		[newFeedDetails setObject:@"" forKey:@"fdLocation"];
		[newFeedDetails setObject:@"Live" forKey:@"fdStatus"];
		
		[newFeedDetails setObject:@"0" forKey:@"fdLastMode"];
		[newFeedDetails setObject:@"1" forKey:@"fdGPS"];
		[newFeedDetails setObject:@"Feed Has Not Been Updated Yet" forKey:@"fdLastUpdate"];
		
		
		[newFeedDetails setObject:[NSString stringWithFormat:@"%.0f", botRangeNum.text] forKey:@"fdCurrentValue"];
		[newFeedDetails setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] forKey:@"fdPublisher"];
		
	}
	
	NSLog(@"makenewDict BP: 3");
	
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", topRangeNum.text] forKey:@"fdMaxNum"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", botRangeNum.text] forKey:@"fdMinNum"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", heading.text] forKey:@"fdTitle"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", unit.text] forKey:@"fdUnit"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", unitFull.text] forKey:@"fdUnitLabel"];
	
	
	//split the tags by comma into array for new feed dictionary
	
	NSString *tagsString = tags.text;
	tagsString = [tagsString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSMutableArray *fdTags = [tagsString componentsSeparatedByString:@","];
	NSLog(@"%@", tagsString);
	//[tagsString release];
	
	
	
	[newFeedDetails setObject:fdTags forKey:@"fdTags"];
	
	[newFeedDetails setObject:[NSString stringWithFormat:@"%i",[myPickerView selectedRowInComponent:0]] forKey:@"fdPickerID"];
	
	
	// check the float switch
	
	if (floatSwitch.selectedSegmentIndex == 0) {
		
		[newFeedDetails setObject:[NSString stringWithFormat:@"0"] forKey:@"fdIsFloat"];
		
	} else {
		
		[newFeedDetails setObject:[NSString stringWithFormat:@"1"] forKey:@"fdIsFloat"];
	}
	
	
	
	// un comment to see the full description of the feed being edited or created
	NSLog([newFeedDetails description]);
	
	
	
	// all feed data has been added to the temporary new dictionary	
	// so we add the new dictionary back to the feed list
	
	// if its a new feed we add it at the end
	
	
	if(inEditingMode != YES){
		
		
		
		//if its new we add it at the end by counting the array with the feeds listed
		[tempArray insertObject:newFeedDetails atIndex:[tempArray count]];
		[[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"AllTheFeeds"];
		
		[self alertFeedCreationFinished];
		
	} else{
		
		// otherwise we put it back in its original place;
		
		[tempArray replaceObjectAtIndex:[feedNumber integerValue] withObject:newFeedDetails];
		[[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"AllTheFeeds"];
		[self.navigationController popViewControllerAnimated:YES];
		
		
	}
	
	[tempArray release];
	[newFeedDetails release];
	
}



- (void)alertConfirmFeedCreation
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you sure you want to create a new Pachube feed?" delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:@"Yes", nil];
	
	alert.tag = @"alertConfirmFeedCreation";											   
	[alert show];
	[alert release];
}


- (void)alertSaveEdit
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Save Changes To This Feed?" delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:@"Yes", nil];
	
	alert.tag = @"alertSaveEdit";											   
	[alert show];
	[alert release];
}

- (void)alertPageExit
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Save Changes To This Feed?" delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:@"Save Changes","Abandon Changes", nil];
	
	alert.tag = @"alertPageExit";											   
	[alert show];
	[alert release];
}

- (void)alert404
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feed Error" message:@"The Feed Your Trying To Access Does Not Exist" delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alert404";											   
	[alert show];
	[alert release];
}


- (void)alert401
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Check Your Username and Password and try again." delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alert401";											   
	[alert show];
	[alert release];
}



- (void)alertStatusResponse
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:[NSString stringWithFormat:@"The Status Code is %i	",mostRecentResponseCode] delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alertStatusResponse";	
	[alert show];
	[alert release];
}


- (void)alertFeedCreationFinished
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pachube Feed Created!" message:@"A new pachube feed has been successfully created!" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alertFeedCreationFinished";
	[alert show];
	[alert release];
	
	
	
}



- (void)alertCheckConnection
{
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Cannot Create New Feed. \n Please Check Internet Connection and Try Again." delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alertCheckConnection";
	[alert show];
	[alert release];
	
}


- (void)alertInsertFeedTitle
{
	UIAlertView *titleAlert = [[UIAlertView alloc]initWithTitle:@"Pachube Alert" message:@"Please Give The Feed A Title" delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil , nil];	
	
	[titleAlert show];
	[titleAlert release];
}


- (IBAction)sendAndCreate:(id)sender{
	
	NSLog(@"save function");
	
	if ([heading.text isEqualToString:@""]){
		
		[self alertInsertFeedTitle]; 
		
	} else if ([botRangeNum.text isEqualToString:@""]) {
		
		[self alertBottomRangeIsInvalid];
		
	} else if ([topRangeNum.text isEqualToString:@""]) {
		
		[self alertTopRangeIsInvalid];
		
	} else {
		
		[self alertConfirmFeedCreation];
		
	}
	
}


-(void)floatSwitchAction:(id)sender{
	
	NSLog(@"switched changed");
	[self checkEdit];
	
	
}



//run checkEdit to determine if the edit page has been edited
// changes "hasBeenEdited" when editing a feed, does nothing when creating a new feed
// adds a save button to the page in edit mode.

-(void)checkEdit {
	
	if(inEditingMode){
		
		hasBeenEdited = YES;
		
		if(self.navigationItem.rightBarButtonItem == nil){
			UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveEdit:)];
			[self.navigationItem setRightBarButtonItem:saveButton];
		}
		
	}
	
	
}

-(void)exitPageLeft:(id)sender{
	
	NSLog(@"LEAVING PAGE");
	
	if (editingMode){
		if (hasBeenEdited){
			
			[self alertPageExit];
			
		} else {
			[self.navigationController popViewControllerAnimated:YES];
		}
		
	} else {
		
		// only exits with out warning if no edits have been made or no new feed has been created
		
		NSLog(@"PAGE exit started");
		[self.navigationController popViewControllerAnimated:YES];
		NSLog(@"page exit finishe");
	}	
	
}


- (void)viewDidLoad
{		
	[super viewDidLoad];
	
	//[self.navigationController.navigationBar setNeedsDisplay];
	
	
	NSLog(@"edited loaded");
	
	tempFeedNumber = @"0";
	
	[floatSwitch addTarget:self action:@selector(floatSwitchAction:) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.hidesBackButton = NO;
	
	
	inEditingMode = NO;
	
	tempArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
	newFeedDetails = [[NSMutableDictionary alloc] init];
	
	//[myPickerView selectRow:[rowSelect integerValue] inComponent:0 animated:NO];
	
	
	[self enableTextBoxes];
	
	feedJustCreated = NO;
	
	// Set Text field's delegate status (so they return the keyboard)
	topRangeNum.delegate = self;
	botRangeNum.delegate = self;
	
	heading.delegate = self;
	unit.delegate = self;
	unitFull.delegate = self;
	tags.delegate = self;
	
	
	topRangeNum.tag = @"topRangeNum";
	botRangeNum.tag = @"botRangeNum";
	
	heading.tag = @"heading";
	unit.tag = @"unit";
	unitFull.tag = @"unitFull";
	tags.tag = @"tags";
	
	
	// label for picker selection output, place it right above the picker
	CGRect labelFrame = CGRectMake(	kLeftMargin,
								   myPickerView.frame.origin.y - kTextFieldHeight,
								   self.view.bounds.size.width - (kRightMargin * 2.0),
								   kTextFieldHeight);
	
	
	[self createPicker];
	
	[myPickerView selectRow:0 inComponent:0 animated:NO];
	
	
	if ([editingMode integerValue] == 1){
		
		NSLog(@"Editing MODE");
		
		inEditingMode = YES;
		
		feedDictionary = [tempArray objectAtIndex:[feedNumber integerValue]];
		NSString *fdPickerID = [feedDictionary objectForKey:@"fdPickerID"];
		
		floatSwitch.selectedSegmentIndex = [[feedDictionary objectForKey:@"fdIsFloat"] integerValue];
		
		//	if ([rowSelect integerValue] == 0) {
		// get custom values
		
		NSLog(@"previously selected custom mode");
		
		botRangeNum.text = [feedDictionary objectForKey:@"fdMinNum"];
		topRangeNum.text = [feedDictionary objectForKey:@"fdMaxNum"];
		heading.text = [feedDictionary objectForKey:@"fdTitle"];
		
		unit.text = [feedDictionary objectForKey:@"fdUnit"];
		unitFull.text = [feedDictionary objectForKey:@"fdUnitLabel"];
		floatSwitch.selectedSegmentIndex = [[feedDictionary objectForKey:@"fdIsFloat"] integerValue];
		
		NSMutableArray *tempTags = [feedDictionary objectForKey:@"fdTags"];
		NSString *tagString = @"";
		
		
		for (int i = 0; i < [tempTags count]; i++) {
			
			NSString *tempRef = [NSString stringWithFormat:@"%@",[tempTags objectAtIndex:i]]; 
			tempRef = [tempRef stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
			
			if (i < [tempTags count] - 1) {
				tempRef = [tempRef stringByAppendingString:@", "];
			}
			
			tagString = [tagString stringByAppendingString:tempRef];
			NSLog(@"%@",tagString);
		}
		
		tags.text = tagString;
		
		
		
		
		
		//	[myPickerView selectRow:0 inComponent:0 animated:YES];
		
		
		
		
		
		//	} else {
		
		
		[myPickerView selectRow:[rowSelect integerValue] inComponent:0 animated:YES];
		
		NSLog(@"previously selected preset mode");
		
		
		//	}
		
		self.navigationItem.title = @"Edit Feed";
		self.navigationItem.rightBarButtonItem = nil;
		
		
	} else  {
		
		[myPickerView selectRow:[rowSelect integerValue] inComponent:0 animated:YES];
		self.navigationItem.title = @"Create A Feed";
		
		self.navigationItem.rightBarButtonItem = nil;
		UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(sendAndCreate:)];
		[self.navigationItem setRightBarButtonItem:saveButton];
		
	}
	
	
	
	hasBeenEdited = NO;
	
	
	
}
// called after the view controller's view is released and set to nil.
// For example, a memory warning which causes the view to be purged. Not invoked as a result of -dealloc.
// So release any properties that are loaded in viewDidLoad or can be recreated lazily.
//
- (void)viewDidUnload
{
	
	if (editingMode){
		if (hasBeenEdited){
			
			[self alertSaveEdit];
		}
	}
	
	[super viewDidUnload];
	
}

- (void)dealloc
{
	[super dealloc];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


@end

