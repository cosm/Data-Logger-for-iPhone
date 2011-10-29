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


#import "FeedUpdate.h"
#import "Constants.h"

#define kSliderTopDistance				142.0

@implementation FeedUpdate

@synthesize metadataWebView ,passedIndex, createNew, mainFeedID, feedDictionary, unitLabel;
@synthesize gpsSwitch, loadingBar, bg, titleLabel, webData, spinner, historySpinner, locationSpinner, pachubeLatitude, pachubeLongitude, sliderCtl, statusLabel;


#pragma mark Interface Functions

// below are the IB Actions for the functions connected to the buttons

-(IBAction)infoButton:(id)sender
{
	
	FeedInfo *infoController = [[FeedInfo alloc] initWithNibName:@"FeedInfo" bundle:[NSBundle mainBundle]];
	//send current values to editor
	infoController.feedNumber = passedIndex;

	[self.navigationController pushViewController:infoController animated:YES];
	[infoController release];
	infoController = nil;
	
}


-(void)loadEditPage
{	
	NSLog(@"load edit page loaded");

	SetUpViewController *editController = [[SetUpViewController alloc] initWithNibName:@"FeedNew" bundle:[NSBundle mainBundle]];
	
		NSLog(@"load edit page loaded2");
	editController.rowSelect = [feedDictionary objectForKey:@"fdPickerID"];
	
		NSLog(@"load edit page loaded3");
	
	editController.feedNumber = passedIndex;
	
		NSLog(@"load edit page loaded4");
	
	editController.editingMode = @"1";	
	NSLog(@"load edit page loaded2 ");
	[self.navigationController pushViewController:editController animated:YES];
	
	[editController release];
	editController = nil;
	NSLog(@"load edit page loaded 3");
}

-(void)infoPage {
	
	FeedInfo *infoController = [[FeedInfo alloc] initWithNibName:@"FeedInfo" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:infoController animated:YES];
	[infoController release];
	
	infoController.feedNumber = passedIndex;
	infoController = nil;
	
}


-(IBAction)button2Send:(id)sender
{
	
//	locationController = [[PachubeCLController alloc] init];
//	[locationController.locationManager startUpdatingLocation];
//	locationController.delegate = self;
	
	
	pachubeTabAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	if([delegate CheckReachability]){
		
	loading = YES;
		
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	[sliderCtl setEnabled:NO];
	// proceed is set to NO here to prevent anything but a 200 status call parsing the return XML
	proceed = NO;
	[loadingBar setHidden:NO];
	[loadingBar setProgress:0.0];
	statusLabel.text = @"Connecting to Pachube...";
	
	[spinner setHidden:NO];
	[spinner startAnimating];


	
	// get the value of the slider
	
	NSString *cV = @"";
	
	if (floatMode) {
		cV =[NSString stringWithFormat:@"%.2f",sliderCtl.value];

	} else {
	
		cV =[NSString stringWithFormat:@"%.0f",sliderCtl.value];

	}
	
	
	NSMutableArray *tempTags = [feedDictionary objectForKey:@"fdTags"];
	NSString *tagString = @"<tag>";
	
	
	for (int i = 0; i < [tempTags count]; i++) {
		
		NSString *tempRef = [NSString stringWithFormat:@"%@",[tempTags objectAtIndex:i]]; 
		tempRef = [tempRef stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];

		
		
		if (i < [tempTags count] - 1) {
			tempRef = [tempRef stringByAppendingString:@"</tag>\n<tag>"];
		} else {
				
			tempRef = [tempRef stringByAppendingString:@"</tag>\n"];
			
		}

		tagString = [tagString stringByAppendingString:tempRef];
		NSLog(@"%@",tagString);
	}
		
		NSString *gpsString = [NSString stringWithFormat:@""];
		NSString *locationString = [NSString stringWithFormat:@""];

		
	if ([gpsSwitch isOn] == YES) {
		
		
	locationString = [NSString stringWithFormat:
						  @"<lat>%@</lat>\n"
						  "<lon>%@</lon>\n"
						  "<ele>%@</ele>\n",
						  pachubeLatitude, 
						  pachubeLongitude, 
						  pachubeAltitude
						  ];

			
	gpsString = [NSString stringWithFormat:
							  @"<data id=\"1\">\n"
							   "<value>%@</value>\n"
							   "<tag>latitude</tag>\n"
							   "<tag>lat</tag>\n"
							   "</data>\n"
							   "<data id=\"2\">\n"
							   "<tag>longitude</tag>\n"
							   "<tag>lon</tag>\n"
							   "<value>%@</value>\n"
							   "</data>\n"
							   "<data id=\"3\">\n"
							   "<value>%@</value>\n"
							   "<tag>altitude</tag>\n"
							   "<tag>alt</tag>\n"
							   "<tag>elevation</tag>\n"
							   "</data>\n",
							   pachubeLatitude, 
							   pachubeLongitude, 
							   pachubeAltitude];
		
	}  
	
	NSLog(@"BEFORE XML CONCAT");
	
	NSString *pachubeXML = [NSString stringWithFormat:
							@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
							"<eeml xmlns=\"http://www.eeml.org/xsd/005\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd\">\n"
							"<environment>\n"
							"<title>%@</title>\n"
							"<description>%@</description>\n"
							"<website>%@</website>"
							"<location exposure=\"%@\" domain=\"%@\" disposition=\"%@\">\n"
							"<name>%@</name>\n"
							"%@"
							"</location>\n"
							"<data id=\"0\">\n"
							"%@"
							"<value minValue=\"%@\" maxValue=\"%@\">%@</value>\n"
							"<unit symbol=\"%@\">%@</unit>\n"
							"</data>\n"
							"%@"
							"</environment>\n"
							"</eeml>", 
							[feedDictionary objectForKey:@"fdTitle"],
							[feedDictionary objectForKey:@"fdDescription"],
							[feedDictionary objectForKey:@"fdURL"],
							[feedDictionary objectForKey:@"fdExposure"],
							[feedDictionary objectForKey:@"fdDomain"],
							[feedDictionary objectForKey:@"fdDisposition"],
							[feedDictionary objectForKey:@"fdLocation"],
							locationString,
							tagString,
							[feedDictionary objectForKey:@"fdMinNum"],
							[feedDictionary objectForKey:@"fdMaxNum"],
							cV, 
							[feedDictionary objectForKey:@"fdUnit"],
							[feedDictionary objectForKey:@"fdUnitLabel"],
							gpsString
							];
	
		
	NSLog(@"%@",pachubeXML);

	statusLabel.text = @"Processing Update";

	NSLog(@"MAIN FEED ID: %@",mainFeedID);
 	NSString* urlFull = [NSString stringWithFormat:@"http://api.pachube.com/v1/feeds/%@.xml", mainFeedID];

	
	NSString* usernameTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
	NSString* passwordTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
	NSLog(@"%@", urlFull);
	[loadingBar setProgress:0.1];
	
	
	
	NSURL *getUrl = [NSURL URLWithString:urlFull];
	
	
	statusLabel.text = @"Establishing Connection...";
	// set up the get request
	NSMutableURLRequest *theGetRequest = [NSMutableURLRequest requestWithURL:getUrl cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:3.0];
	
	// get the length of the body
	NSString *msgLength = [NSString stringWithFormat:@"%d", [pachubeXML length]];
	
	//this uses base64Encoding from the NSDatatAdditions class for encoding the username/password in the https header
	NSString *authString = [[[NSString stringWithFormat:@"%@:%@", usernameTemp, passwordTemp] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
	authString = [NSString stringWithFormat: @"Basic %@", authString];
	
	NSString *userAgent = [NSString stringWithFormat:@"DataLogger for iPhone (V. %@)", kDataLoggerVersion];
		
	NSLog(@"%@",userAgent);
	
	
	// set up the put request
	[theGetRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theGetRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theGetRequest addValue:authString forHTTPHeaderField:@"Authorization"];
	[theGetRequest setHTTPMethod:@"PUT"];
	[theGetRequest setHTTPBody: [pachubeXML dataUsingEncoding:NSUTF8StringEncoding]];
	[theGetRequest setValue:userAgent forHTTPHeaderField: @"User-Agent"];
	[theGetRequest setTimeoutInterval:4]; 
				
	NSURLConnection *theGetConnection = [[NSURLConnection alloc] initWithRequest:theGetRequest delegate:self];
	
	
	if( theGetConnection )
	{	
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theGetConnection is NULL");
		loading = NO;
[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

		}		
	}
		
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
		
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    //NSString status = [NSString stringWithFormat:@"%d", yourInteger];
    NSLog(@"STATUS CODE = %i", responseStatusCode );
	
	if (responseStatusCode == 200){
		
			statusLabel.text = @"Connection Established...";
		
		proceed = YES;
		[loadingBar setProgress:0.7];
		[webData setLength: 0];
		
		
	} else if (responseStatusCode == 400) {
		
		[self alertServerError];
		[self networkRequestFailed];
		statusLabel.text = @"Update Failed. Please Try Again...";
		
	} else if (responseStatusCode == 401) {
		
		[self alertWrongAuth];
		[self networkRequestFailed];
		statusLabel.text = @"Update Failed. Check Username/Password.";
		
	} else if (responseStatusCode == 403) {
		
		[self alertForbidden];
			[self networkRequestFailed];
	statusLabel.text = @"Cannot update: exceeds your Pachube account allowance.";
		
	} else if (responseStatusCode == 404) {
		
		[self alertNotFound];
			[self networkRequestFailed];
		statusLabel.text = @"Update Failed. This Feed May Have Been Deleted.";
		
	} else if (responseStatusCode == 422) {
		
		[self alertUnprocessable];
			[self networkRequestFailed];
		statusLabel.text = @"Update Failed. Please Check All Values Are Numeric.";
		
	} else if (responseStatusCode == 500) {
		
		[self alertServerError];
			[self networkRequestFailed];
		statusLabel.text = @"Update Failed. Please Try Again...";
		
	}
	else if (responseStatusCode == 503) {
	
		[self alertNoServerError];
			[self networkRequestFailed];
		statusLabel.text = @"Update Failed";
		
	} else {
		
		statusLabel.text = @"Update Failed";
		
	}

		[sliderCtl setEnabled:YES];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	[webData appendData:data];
}


-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[self alertNoNetwork];
	
	statusLabel.text = @"Connection Failed. Please Check Connection.";
	
	[spinner stopAnimating];
	[spinner setHidden:YES];
	[loadingBar setProgress:0.0];
	[loadingBar setHidden:YES];
	loading = NO;
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[connection release];
	[webData release];
	
}		


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	
	[loadingBar setProgress:0.7];
	
	if (proceed == YES) {
	
	statusLabel.text = @"Processing Response";	
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(theXML);
	[theXML release];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
		[loadingBar setProgress:1.0];
	[spinner stopAnimating];
	
	[self getTime];
	[connection release];
	[webData release];


	statusLabel.text = @"Feed Updated!";
		
	[feedDictionary setObject:[NSString stringWithFormat:@"%@",mainValueEntry.text] forKey:@"fdCurrentValue"];
	
		if (![[feedDictionary objectForKey:@"fdHasBeenUpdated"] isEqualToString:@"YES"]){
		
			NSLog(@"feed has been updated for the first time");
			[feedDictionary setObject:@"YES" forKey:@"fdHasBeenUpdated"];
			graph.image = nil;
		
		}
			
			
	} 
	
	[loadingBar setHidden:YES];
	[spinner setHidden:YES];
	loading = NO;
}




- (IBAction)settingsButtonPressed:(id)sender {
	NSLog(@"SETTINGSBUTTONPUSH");
}


-(IBAction)sliderMoved:(id)sender	

{
	float newValue = sliderCtl.value;
	if (floatMode){
	mainValueEntry.text =[NSString stringWithFormat:@"%.2f",newValue];
	} else{
	mainValueEntry.text =[NSString stringWithFormat:@"%.0f",newValue];

	}
}


#pragma mark Network Alerts

- (void)alertNoNetwork
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Pachube Log requires an active network connection. Please check your internet connection and retry."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}

- (void)alertWrongAuth

{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Wrong Username/Password. Please check your details are correct."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}

- (void)alertServerError
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Internal Server Error, Please Try Again."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}

- (void)alertForbidden
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feed Error" message:@"Cannot update: exceeds Pachube account allowance."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}
		
- (void)alertNotFound
		{
			// open a alert with an OK and cancel button
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feed Error" message:@"The Feed You Are Trying To Access No Longer Exsists"
														   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
			
			[alert show];
			[alert release];
		}		
		
- (void)alertUnprocessable
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"Error With Connection. Please Check Connection and Try Again"
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}
- (void)alertNoServerError
{
	// open a alert with an OK and cancel button
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server Error" message:@"Pachube Server Is Busy, Please Try Again."
												   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	[alert show];
	[alert release];
}

#pragma mark After The Call Has Failed

-(void)networkRequestFailed

{	
	[loadingBar setHidden:YES];
	
}





#pragma mark Editing Mode

- (void)turnOnEditing {

	SetUpViewController *editController = [[SetUpViewController alloc] initWithNibName:@"FeedNew" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:editController animated:YES];

	[editController release];
	editController = nil;
}


-(IBAction)plusOneValue:(id)sender {

	if (sliderCtl.maximumValue == sliderCtl.value) {
	
		[self alertIncreaseRangeByOne];
	
	} else {
		
		sliderCtl.value = sliderCtl.value + 1;
		float newValue = sliderCtl.value;
		mainValueEntry.text =[NSString stringWithFormat:@"%.0f",newValue];

	}
	
}

-(IBAction)minusOneValue:(id)sender {
	
	if (sliderCtl.minimumValue == sliderCtl.value) {
		
		[self alertDecreaseRangeByOne];
		
	} else {
		
		sliderCtl.value = sliderCtl.value - 1;
		float newValue = sliderCtl.value;
		mainValueEntry.text =[NSString stringWithFormat:@"%.0f",newValue];
		
	}
		
}

-(void)setValueMode{
	
	if(modeSelect.selectedSegmentIndex == 0 && !floatMode){
		
	[minusOne setHidden:NO];
	[plusOne setHidden:NO];
	CGRect newSlider = CGRectMake(50, kSliderTopDistance, 220, 23);
	[sliderCtl setFrame:newSlider]; 
		
	} else {
	
	[minusOne setHidden:YES];
	[plusOne setHidden:YES];
	CGRect newSlider = CGRectMake(18, kSliderTopDistance, 284, 23);
	[sliderCtl setFrame:newSlider]; 
		
	}
	
}



-(void)gpsSwitchMoved{
	
	
	if ([gpsSwitch isOn]) {
		
		NSLog(@"swtich turned on");
		[gpsSwitch setOn:TRUE animated:TRUE];

		[feedDictionary setObject:@"1" forKey:@"fdGPS"];
		
//		locationController = [[PachubeCLController alloc] init];
//		[locationController.locationManager startUpdatingLocation];
//		locationController.delegate = self;
		

		
	} else {
		NSLog(@"swtich turned offff");
		[feedDictionary setObject:@"0" forKey:@"fdGPS"];

		
	}
	
	[tempArray replaceObjectAtIndex:[passedIndex integerValue] withObject:feedDictionary];
	[[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"AllTheFeeds"];
	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	[super viewDidLoad];
	
	
	//handles the gps switch default from the userdefaults for that feed
	
	if ([[feedDictionary objectForKey:@"fdGPS"] isEqualToString:@"0"]){
		
		[gpsSwitch setOn:NO animated:NO];
		
	} else {
		
		[gpsSwitch setOn:YES];	
		
	}
	
	loading = NO;
	
	metadataWebView.delegate = self;
	[modeSelect addTarget:self action:@selector(modeChanged) forControlEvents:UIControlEventValueChanged];
	[gpsSwitch addTarget:self action:@selector(gpsSwitchMoved) forControlEvents:UIControlEventValueChanged];
	
	
	pachubeLatitude = @"";
	pachubeLongitude =  @"";
	pachubeAltitude =  @"";
	
	tempArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
	feedDictionary = [[tempArray objectAtIndex:[passedIndex integerValue]] mutableCopy];
	
	[historySpinner setHidden:YES];
	[metadataWebView setHidden:YES];
	
	mainValueEntry.delegate = self;
	
	
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(loadEditPage)];
	
	[loadingBar setHidden:YES];
	[spinner setHidden:YES];
	[mainValueEntry setHidden:NO];
	[descriptionLabel setEnabled:NO];
		
	[self modeChanged];
	
}


-(void)modeChanged {
	
	LastMode = modeSelect.selectedSegmentIndex;
	NSLog(@"MODE CHANGED %i", LastMode);
	
	if (LastMode == 1) {
	
	[self MetadataModeOff];
	[self historyModeOn];
		
		
	} else if (LastMode == 2) {
	[self historyModeOff];
	[self MetadataModeOn];

	
	} else {
		
	[self setValueMode];
	[self historyModeOff];	
	[self MetadataModeOff];
	[feedDictionary setObject:@"0" forKey:@"fdLastMode"];
	[locate setHidden:NO];
	[gpsSwitch setHidden:NO];
	[statusLabel setHidden:NO];
		
	if(loading == YES)
	
	{
			
			[loadingBar setHidden:NO];	
			[spinner setHidden:NO];
			
		}
		
		
		
	}
						
	
}


-(void)historyModeOn{
	
	
	[feedDictionary setObject:@"1" forKey:@"fdLastMode"];

	
	UIImage *newBG = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"historyBG" ofType:@"png"]];
	[bg setImage:newBG];
	
	
	// lots of UI management // needs to be refined
	
	[locate setHidden:YES];
	[gpsSwitch setHidden:YES];
	[loadingBar setHidden:YES];
	[statusLabel setHidden:YES];
	[spinner setHidden:YES];
	[unitLabel setHidden:YES];
	[mainValueEntry setHidden:YES];

	[sliderCtl setHidden:YES];
	[updatePachubeButton setHidden:YES];
	[locate setHidden:YES];
	[geoLocate setHidden:YES];
		
	[graph setHidden:NO];
	
	[historySpinner setHidden:NO];
	[historySpinner startAnimating];
	
	
	[plusOne setHidden:YES];
	[minusOne setHidden:YES];
	
	[historySpinner startAnimating];
	[historySpinner setHidden:NO];
	
	
	[self historyImage];
	[historySpinner stopAnimating];
	[historySpinner setHidden:YES];
	
	
	
}

-(void)historyImage

{
	
	// TODO: loading status from a separate network call
	// TODO: make use of the snazzy new graphs for different time spans
	
	pachubeTabAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
	
	if (![[feedDictionary objectForKey:@"fdHasBeenUpdated"] isEqualToString:@"YES"]){
		
		if(graph.image == nil){
		UIImage	*image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"graphHolder" ofType:@"png"]];
		graph.image = image;
		}
		
	} else {
		
		
		
		if (graph.image == nil) {
			
			if ([delegate CheckReachability]){
			NSString *imageURL = [NSString stringWithFormat:@"http://www.pachube.com/feeds/%@/datastreams/0/history.png?w=288&h=252&b=true&g=true", mainFeedID];
		
			NSURL *getUrlImage = [NSURL URLWithString:imageURL];
			UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:getUrlImage]];
			graph.image = image;
			
			} else {
				
			UIImage	*image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"graphHolder" ofType:@"png"]];
			graph.image = image;
				
			}
			
		}
		
	}

	
	
	if([delegate CheckReachability]) {
		
		
		
		
		} else {
			
			UIImage	*image = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"graphHolder" ofType:@"png"]];
			graph.image = image;
			
		}

			
}
	 
-(void)historyModeOff {
		 
	UIImage *newBG = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"mainBG" ofType:@"png"]];
	[bg setImage:newBG];
	
	[graph setHidden:YES];
	[historySpinner setHidden:YES];

	[unitLabel setHidden:NO];
	[mainValueEntry setHidden:NO];
	
	[sliderCtl setHidden:NO];
	[updatePachubeButton setHidden:NO];
	


	
}


// handles links for the meta data webview.

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request

 navigationType:(UIWebViewNavigationType)navigationType; {
	
	NSURL *requestURL =[ [ request URL ] retain ];
	// Check to see what protocol/scheme the requested URL is.
	if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ]
		  || [ [ requestURL scheme ] isEqualToString: @"https" ] )
		&& ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
		return ![ [ UIApplication sharedApplication ] openURL: [ requestURL autorelease ] ];
	}
	// Auto release
	[ requestURL release ];
	
	// If request url is something other than http or https it will open
	// in UIWebView. You could also check for the other following
	// protocols: tel, mailto and sms
	return YES;
}



-(void)MetadataModeOn {
	
	
	
	[feedDictionary setObject:@"2" forKey:@"fdLastMode"];

	
	UIImage *newBG = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"historyBG" ofType:@"png"]];
	[bg setImage:newBG];
	
	
	[locate setHidden:YES];
	[gpsSwitch setHidden:YES];
	
	
	[loadingBar setHidden:YES];
	[statusLabel setHidden:YES];
	
	
	[spinner setHidden:YES];
	[unitLabel setHidden:YES];
	[mainValueEntry setHidden:YES];
	[updatePachubeButton setHidden:YES];
	[locate setHidden:YES];
	[geoLocate setHidden:YES];

	[sliderCtl setHidden:YES];
	
	[plusOne setHidden:YES];
	[minusOne setHidden:YES];

	[modifyArrow setHidden:NO];
	[modifyInfoButton setHidden:NO];
	
	
	if ([[feedDictionary objectForKey:@"fdDescription"] length] < 80){
	
		
	}

	
	// generates an html string from the meta data for display in the metadata web view
	
	NSString *tempHTML =  [NSString stringWithFormat:@"<body><div style=\"font-size:15px; font-family:Arial\"><b>Status:</b> %@<br><b>Published By:</b> <a href=\"http://www.pachube.com/users/%@\">%@</a><br><b>Feed ID:</b> <a href=\"http://www.pachube.com/feeds/%@\">%@</a><br><b>Website:</b> %@<br><b>Location:</b> %@<br><b>Domain:</b> %@<br><b>Exposure:</b> %@<br><b>Disposition:</b> %@<br><b>Description:</b> %@</div></body>",
						  [feedDictionary objectForKey:@"fdStatus"],
						   [feedDictionary objectForKey:@"fdPublisher"], [feedDictionary objectForKey:@"fdPublisher"],
						  [feedDictionary objectForKey:@"fdID"],[feedDictionary objectForKey:@"fdID"],
						  [feedDictionary objectForKey:@"fdURL"],
						  [feedDictionary objectForKey:@"fdLocation"],
						  [feedDictionary objectForKey:@"fdDomain"],
						  [feedDictionary objectForKey:@"fdExposure"],
						  [feedDictionary objectForKey:@"fdDisposition"],
						  [feedDictionary objectForKey:@"fdDescription"]
						  ];
	
	

	[metadataWebView setHidden:NO];
	[metadataWebView loadHTMLString:tempHTML baseURL:nil];

	

}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
	modeSelect.enabled = NO;
	
}

-(void)textFieldDidFinishEditing:(UITextField *)textField {
	
	modeSelect.enabled = YES;
	
}

// called when the metadata window is closed

-(void)MetadataModeOff {
		
	[mainValueEntry setHidden:NO];
	[metadataWebView setHidden:YES];
	[modifyArrow setHidden:YES];
	[modifyInfoButton setHidden:YES];

}


// calls Core Location and gets the gps info

- (void)locationUpdate:(CLLocation *)location {
	
    if ([gpsSwitch isOn] == YES){
        locationLabel.text = [[NSString alloc] initWithFormat:@"Last Location: %.7g, %.7g", location.coordinate.latitude, location.coordinate.longitude];
    } else {
        locationLabel.text = @"Last Location: -";
    }
	pachubeLatitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.latitude];
	pachubeLongitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.longitude];
	pachubeAltitude = [[NSString alloc] initWithFormat:@"%g", location.altitude];
	NSLog(@"The accuracy of the altitude: %g", location.verticalAccuracy); 
}


// called when core location returns a booboo.

- (void)locationError:(NSError *)error {
    locationLabel.text = @"GPS Is Disabled. Feed Location Will Not Be Updated.";
}


// setPageValues is called everytime the page is loaded. handles the basic interface set up
// sets the labels and numeric values from 

-(void)setPageValues {

	
	// Check if the value is inputed as a float or integer
	// if IsFloat is 0 value is integer, if IsFloat is 1 then it's a float.
	if ([[feedDictionary objectForKey:@"fdIsFloat"] integerValue] == 0){
		
		// checks to see if float mode has been set to 0 
		// this ensures the default behaviour is to treat the input as a float
		
		floatMode = NO;
		
	} else {
		
		floatMode = YES;
	}
	
	// sets whether its a float or an integer
	
	[self setValueMode];
	
	
	// default values
	statusLabel.text = @"";
	locationLabel.text = [[NSString alloc] initWithFormat:@"Updating Location..."];
	mainValueEntry.text = [feedDictionary objectForKey:@"fdCurrentValue"];
	unitLabel.text = [feedDictionary objectForKey:@"fdUnit"];
	mainFeedID = [feedDictionary objectForKey:@"fdID"];
    // fix the old, corrupt fdId
    if ([mainFeedID hasPrefix:@"1/feeds"]) {
        mainFeedID = [mainFeedID lastPathComponent];
    }

	
	NSString *botLabelNumTemp = [feedDictionary objectForKey:@"fdMinNum"];
	NSString *topLabelNumTemp = [feedDictionary objectForKey:@"fdMaxNum"];
	NSString *currentValue = [feedDictionary objectForKey:@"fdCurrentValue"];
	
	NSLog(@"Min Num = %@",botLabelNumTemp);
	NSLog(@"Max Num = %@",topLabelNumTemp);
	NSLog(@"Current Value Num = %@",currentValue);
	
	sliderCtl.minimumValue = [botLabelNumTemp floatValue];
	sliderCtl.maximumValue = [topLabelNumTemp floatValue]; 
	sliderCtl.value = [currentValue floatValue];
	
	timeLabel.text = [NSString stringWithFormat:@"Last Updated: %@",[feedDictionary objectForKey:@"fdLastUpdate"]];

	[descriptionLabel setEnabled:NO];
	
	modeSelect.selectedSegmentIndex = [[feedDictionary objectForKey:@"fdLastMode"] integerValue];
	
	
	if ([[feedDictionary objectForKey:@"fdGPS"] isEqualToString:@"0"]){
	
		[gpsSwitch setOn:NO animated:NO];
	
	} else{
		
		[gpsSwitch setOn:YES animated:YES];
		
	}
	
}


// gets the time

-(void)getTime {

	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString* currentTime = [dateFormatter stringFromDate:[NSDate date]];
	timeLabel.text = [NSString stringWithFormat:@"Last Updated: %@",currentTime];
	//TODO Make the DATABASE STORE THE LAST UPDATED TIME
	
	[feedDictionary setObject:currentTime forKey:@"fdLastUpdate"];
	[dateFormatter release];
	
	
}


- (void)didReceiveMemoryWarning {
	
	NSLog(@"MEMORY WARNING");
	
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
	//	self.view = nil;
	
}




- (void)viewWillAppear:(BOOL)animated

	{		
		// starts the location call is gps is on
		
//		if ([gpsSwitch isOn] == YES){
			
			locationController = [[PachubeCLController alloc] init];
			[locationController.locationManager startUpdatingLocation];
			locationController.delegate = self;
			
//		}
		
		
		
		tempArray = nil;
		feedDictionary = nil;
		
		//loads the feed data from NSuserdefaults
		
		tempArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
		feedDictionary = [[tempArray objectAtIndex:[passedIndex integerValue]] mutableCopy];
		
		self.navigationItem.title = [feedDictionary objectForKey:@"fdTitle"];
		
		[self setPageValues];			
		[self modeChanged];

		
		NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
		[super viewWillAppear:animated];
		
}



- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"[%@ viewDidAppear:%d]", [self class], animated);

	[super viewDidAppear:animated];
	
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"[%@ viewWillDisappear:%d]", [self class], animated);
	

	[tempArray replaceObjectAtIndex:[passedIndex integerValue	] withObject:feedDictionary];
	[[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:@"AllTheFeeds"];
	
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
	
	[[NSUserDefaults standardUserDefaults] synchronize];
    [super viewDidDisappear:animated];
}
	

//the slider

- (UISlider *)sliderCtl
{
    if (sliderCtl == nil) 
    {
	        [sliderCtl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        
            sliderCtl.backgroundColor = [UIColor clearColor];
			sliderCtl.continuous = YES;
        
		    }
    return sliderCtl;
}



// actionsheet for alertViews
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

	
	if (actionSheet.tag == "OutOfRangeAlertTag"){
		
		if (buttonIndex == 0)
		{
			
			NSLog(@"Range NOT Increased");	
						
			
		} else {
			NSLog(@"Raenge Increased");
			[self IncreaseRange];
			
			sliderCtl.value = mainValueEntry.text.floatValue;
			
		}
	} else if (actionSheet.tag == "alertIncreaseRangeByOne"){
		
		if (buttonIndex == 1)
		{
			sliderCtl.maximumValue = sliderCtl.maximumValue + 1;
			float newValue = sliderCtl.maximumValue;
			mainValueEntry.text =[NSString stringWithFormat:@"%.0f",newValue];
					
		}
	}	else if (actionSheet.tag == "alertDecreaseRangeByOne"){
		
		if (buttonIndex == 1)
		{
			sliderCtl.minimumValue = sliderCtl.minimumValue - 1;
			float newValue = sliderCtl.minimumValue;
			mainValueEntry.text =[NSString stringWithFormat:@"%.0f",newValue];
			
		}
	}

}


//lots of alerts

- (void)makeOutOfRangeAlert
{
	UIAlertView *OutOfRangeAlert = [[UIAlertView alloc] initWithTitle:@"Pachube Alert" message:@"The new value is out of range. Do you wish to increase the range?" delegate:self cancelButtonTitle:@"No"  otherButtonTitles:@"Yes", nil];	
	
	OutOfRangeAlert.tag = "OutOfRangeAlertTag";
	[OutOfRangeAlert show];
	[OutOfRangeAlert release];
}

- (void)alertIncreaseRangeByOne
{
	UIAlertView *alertIncreaseRangeByOne = [[UIAlertView alloc] initWithTitle:@"Pachube Alert" message:@"The new value is out of range. Do you wish to increase the range?" delegate:self cancelButtonTitle:@"No"  otherButtonTitles:@"Yes", nil];	
	
	alertIncreaseRangeByOne.tag = "alertIncreaseRangeByOne";
	[alertIncreaseRangeByOne show];
	[alertIncreaseRangeByOne release];
}

- (void)alertDecreaseRangeByOne
{
	UIAlertView *alertDecreaseRangeByOne = [[UIAlertView alloc] initWithTitle:@"Pachube Alert" message:@"The new value is out of range. Do you wish to increase the range?" delegate:self cancelButtonTitle:@"No"  otherButtonTitles:@"Yes", nil];	
	
	alertDecreaseRangeByOne.tag = "alertDecreaseRangeByOne";
	[alertDecreaseRangeByOne show];
	[alertDecreaseRangeByOne release];
}


- (void)makeNotAValidNumber
{
	UIAlertView *NotAValidNumber = [[UIAlertView alloc] initWithTitle:@"Pachube Alert" message:@"This value is not a valid number." delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];	
	
	NotAValidNumber.tag = "NotAValidNumberTag";
	[NotAValidNumber show];
	[NotAValidNumber release];
}


-(void)IncreaseRange{
	
	
	NSLog(@"Increase Range Called");
	if (mainValueEntry.text.floatValue > sliderCtl.maximumValue)
	{
		NSLog(@"Increase Range Top. text:%@, ", mainValueEntry.text);
		sliderCtl.maximumValue = mainValueEntry.text.floatValue;
		sliderCtl.value = mainValueEntry.text.floatValue;
		
	}
	
	if ( mainValueEntry.text.floatValue < sliderCtl.minimumValue)
	
	{
		NSLog(@"Increase Range Bottom");
		sliderCtl.minimumValue = mainValueEntry.text.floatValue;
		sliderCtl.value = mainValueEntry.text.floatValue;
	}
}



- (BOOL) textFieldShouldReturn:(UITextField *)aTextField 
{
	
	// The return key is set to Done, so hide the keyboard
	[aTextField resignFirstResponder];
	
	if (aTextField == mainValueEntry){
	
		
		NSNumberFormatter * f = [[NSNumberFormatter alloc] init]; 
		NSNumber * n = [f numberFromString:aTextField.text]; 
		aTextField.text = [NSString stringWithFormat:@"%@", n];

		NSLog(@"THE TEXT FIELD IS: %@", aTextField.text);
		
		if (aTextField.text == @"(null)") {

		//NSLog(@"your number is bullshit");	
		//perhaps this should do something better than just complaining
		
			
		}
		
		// TODO: Check input value is a number
		// TODO: is input larger or smaller than current range then inrange 
		
		if (mainValueEntry.text.floatValue > sliderCtl.maximumValue || mainValueEntry.text.floatValue < sliderCtl.minimumValue ){
		[self makeOutOfRangeAlert];
		
		
		} else {
			
		[mainValueEntry setHidden:NO];
		sliderCtl.value = mainValueEntry.text.floatValue;
		
		}
	
	}
	return YES;
	

}


- (void)dealloc {
	
	NSLog(@"DEALLOC working three");

	[locationController release];	
  	[super dealloc];
	
	NSLog(@"DEALLOC working five");
}


@end
