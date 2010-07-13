//
//  FeedUpdate.m
//  pachubeTabV2
//
//  Created by Christopher  on 29/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FeedNew.h"

#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0
#define kTextFieldHeight		30.0

@implementation FeedNew

@synthesize createNew, passedIndex, selectedCountry, mainFeedID, feedDictionary;



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
@synthesize floatSwitch, loadingBar, bg, titleLabel, nameInput, webData, soapResults, xmlParser, spinner, image, imageViewer, pachubeLatitude, pachubeLongitude, sliderCtl, mainValue, statusLabel, topLabelNum, botLabel, botLabelNum, topLabel;


-(IBAction)historyButton:(id)sender
{
	
	FeedHistory *hisController = [[FeedUpdate alloc] initWithNibName:@"FeedHistory" bundle:[NSBundle mainBundle]];
	//dvController.selectedCountry = selectedCountry;
	[self.navigationController pushViewController:hisController animated:YES];
	[hisController release];
	hisController = nil;
	
}



-(IBAction)button2Send:(id)sender
{
	[loadingBar setHidden:NO];
	[loadingBar setProgress:0.0];
	//[self refreshPrefs];
	[spinner setHidden:NO];
	[spinner startAnimating];
	recordResults = FALSE;
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	// get the value of the slider
	float newValue = sliderCtl.value;
	NSString *cV =[NSString stringWithFormat:@"%.2f",newValue];
	
	[prefs setObject:cV forKey:@"currentvalue"];
	[prefs synchronize];
	
	// the put request body. A chunk of EEML.
	
	NSString *pachubeXML = [NSString stringWithFormat:
							@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
							"<eeml xmlns=\"http://www.eeml.org/xsd/005\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.eeml.org/xsd/005 http://www.eeml.org/xsd/005/005.xsd\">\n"
							"<environment>\n"
                            "<location exposure=\"indoor\" domain=\"physical\" disposition=\"fixed\">\n"
                            "<name>iPhone Pachube Feed</name>\n"
                            "<lat>%@</lat>\n"
                            "<lon>%@</lon>\n"
                            "<ele>%@</ele>\n"
							"</location>"
							"<data id=\"0\">\n"
							"<tag>Coffee,Logic,Controller,London</tag>"
							"<value minValue=\"0.0\" maxValue=\"100.0\">%.2f</value>\n"
							"</data>\n"
							"<data id=\"1\">\n"
							"<value>%@</value>\n"
							"</data>\n"
							"<data id=\"2\">\n"
							"<value>%@</value>\n"
							"</data>\n"
							"<data id=\"3\">\n"
							"<value>%@</value>\n"
							"</data>\n"
							"</environment>\n"
							"</eeml>",pachubeLatitude,pachubeLongitude, pachubeAltitude, sliderCtl.value,pachubeLatitude,pachubeLongitude,pachubeAltitude
							];
	NSLog(pachubeXML);
	
	//the url
	
	NSString* urlNumber = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
	NSString* urlFull = [NSString stringWithFormat:@"https://www.pachube.com/api/%@.xml", urlNumber];
	
	NSString* usernameTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
	NSString* passwordTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
	NSString* streamidTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"streamid"]; 
	
	//
	NSLog(@"WHY THE: %@", urlNumber);
	NSLog(@"username: %@", usernameTemp);
	NSLog(@"password: %@", passwordTemp);
	NSLog(@"streamID: %@", streamidTemp);
	
	
	//
	NSLog(@"%@", urlFull);
	//NSURL *getUrl = [NSURL URLWithString:@"https://www.pachube.com/api/2605.xml"];
	
	[loadingBar setProgress:0.1];
	
	NSURL *getUrl = [NSURL URLWithString:urlFull];
	
	NSMutableURLRequest *theGetRequest = [NSMutableURLRequest requestWithURL:getUrl];
	
	// get the length of the body
	NSString *msgLength = [NSString stringWithFormat:@"%d", [pachubeXML length]];
	
	//NSString *email = [NSString stringWithFormat:@"%s",usernameTemp];
	//NSString *password2 = [NSString stringWithFormat:@"%s",passwordTemp];
	
	
	//this uses base64Encoding from the NSDatatAdditions class for encoding the username/password in the https header
	NSString *authString = [[[NSString stringWithFormat:@"%@:%@", usernameTemp, passwordTemp] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
	authString = [NSString stringWithFormat: @"Basic %@", authString];
	
	
	// set up the put request
	[theGetRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theGetRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theGetRequest addValue:authString forHTTPHeaderField:@"Authorization"];
	[theGetRequest setHTTPMethod:@"PUT"];
	[theGetRequest setHTTPBody: [pachubeXML dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLConnection *theGetConnection = [[NSURLConnection alloc] initWithRequest:theGetRequest delegate:self];
	
	
	if( theGetConnection )
	{	
		webData = [[NSMutableData data] retain];
	}
	else
	{
		NSLog(@"theGetConnection is NULL");
	}
	
	[nameInput resignFirstResponder];
	
}




-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    //NSString status = [NSString stringWithFormat:@"%d", yourInteger];
    NSLog(@"STATUS CODE = %i", responseStatusCode );
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	statusLabel.text = "Cannot Connect to Pachube. \nPlease Check Your Internet Connection";
	[connection release];
	[webData release];
}		

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[loadingBar setProgress:0.6];
	[spinner stopAnimating];
	NSLog(@"DONE. Received Bytes: %d", [webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSLog(theXML);
	[theXML release];
	
	if( xmlParser )
	{
		[xmlParser release];
	}
	
	xmlParser = [[NSXMLParser alloc] initWithData: webData];
	[xmlParser setDelegate: self];
	[xmlParser setShouldResolveExternalEntities: YES];
	[xmlParser parse];
	
	[connection release];
	[webData release];
	//	[spinner stopAnimating];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
	if( [elementName isEqualToString:@"data"])
		
		//keyValue = [[attributeDict objectForKey:@"id"] integerValue];
		
	{
		if(!soapResults)
		{
			soapResults = [[NSMutableString alloc] init];
		}
		recordResults = TRUE;
	}
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if( recordResults )
	{
		[soapResults appendString: string];
	}
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if( [elementName isEqualToString:@"data"])
	{
		recordResults = FALSE;
		titleLabel.text = soapResults;
		[soapResults release];
		soapResults = nil;
	}
}


- (IBAction)settingsButtonPressed:(id)sender {
	NSLog(@"SETTINGSBUTTONPUSH");
}


-(IBAction)sliderMoved:(id)sender	

{
	float newValue = sliderCtl.value;
	mainValue.text =[NSString stringWithFormat:@"%.0f",newValue];
}

- (void)turnOnEditing {
	[self.navigationItem.rightBarButtonItem release];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(turnOffEditing)];
	NSLog(@"EDITING NOW");
	
	sliderCtl.enabled = NO;
	//bg.hidden = YES;
	botLabelNum.borderStyle = UITextBorderStyleRoundedRect;
	topLabelNum.borderStyle = UITextBorderStyleRoundedRect;
	botLabel.borderStyle = UITextBorderStyleRoundedRect;
	topLabel.borderStyle = UITextBorderStyleRoundedRect;
	descriptionLabel.borderStyle = UITextBorderStyleRoundedRect;
	
	[plusOne setEnabled:NO];
	[minusOne setEnabled:NO];
	
	[botLabelNum setEnabled:YES];
	[topLabelNum setEnabled:YES];
	[botLabel setEnabled:YES];
	[topLabel setEnabled:YES];
	[descriptionLabel setEnabled:YES];
	
	
	
	[floatSwitch setHidden:NO];
	//CGRect newSlider = CGRectMake(40, 136, 240, 23);
	//[sliderCtl setFrame:newSlider]; 
	UIImage *newBG = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"editing" ofType:@"png"]];
	[bg setImage:newBG];
	
	[self setEditing:YES animated:YES];
}

- (void)turnOffEditing {
	[self.navigationItem.rightBarButtonItem release];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(turnOnEditing)];
	
	[floatSwitch setHidden:YES];
	UIImage *newBG = [UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"v2" ofType:@"png"]];
	[bg setImage:newBG];
	botLabelNum.borderStyle = UITextBorderStyleNone;
	topLabelNum.borderStyle = UITextBorderStyleNone;
	botLabel.borderStyle = UITextBorderStyleNone;
	topLabel.borderStyle = UITextBorderStyleNone;
	descriptionLabel.borderStyle = UITextBorderStyleNone;
	
	
	[botLabelNum setEnabled:NO];
	[topLabelNum setEnabled:NO];
	[botLabel setEnabled:NO];
	[topLabel setEnabled:NO];
	[descriptionLabel setEnabled:NO];
	//	CGRect newSlider = CGRectMake(18, 136, 284, 23);
	//	[sliderCtl setFrame:newSlider]; 
	
	[plusOne setEnabled:YES];
	[minusOne setEnabled:YES];
	sliderCtl.enabled = YES;
	NSLog(@"STOPPED EDITING NOW");
	
	
	
	
	
	
	
	
	NSDictionary *newFeedDetails = [[NSMutableDictionary alloc] init];
	
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", topLabelNum.text] forKey:@"fdMaxNum"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", topLabel.text] forKey:@"fdMaxLabel"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", botLabelNum.text] forKey:@"fdMinNum"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", botLabel.text] forKey:@"fdMinLabel"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"%@", titleLabel.text] forKey:@"fdTitle"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"0"] forKey:@"fdIsFloat"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"50"] forKey:@"fdCurrentValue"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"2300"] forKey:@"fdID"];
	[newFeedDetails setObject:[NSString stringWithFormat:@"Full Test Description"] forKey:@"fdDescription"];
	
	
	
	pachubeTabAppDelegate *feedDelegate = [[UIApplication sharedApplication] delegate];
	
	NSArray *tempArray = feedDelegate.AllTheFeeds;
	[tempArray insertObject:newFeedDetails atIndex:passedIndex];
	
	NSLog(@"Changes Logged");
	
	
	[self setEditing:NO animated:YES];
}


-(IBAction)plusOneValue:(id)sender {
	
	
	sliderCtl.value = sliderCtl.value + 1;
	float newValue = sliderCtl.value;
	mainValue.text =[NSString stringWithFormat:@"%.0f",newValue];
	
}

-(IBAction)minusOneValue:(id)sender {
	
	
	sliderCtl.value = sliderCtl.value - 1;
	float newValue = sliderCtl.value;
	mainValue.text =[NSString stringWithFormat:@"%.0f",newValue];
	
}



-(void)setValueMode{
	
	NSLog(@"FLOAT CHANGED");
	int segControl = 	floatSwitch.selectedSegmentIndex;
	if (segControl == 0){
	floatMode = YES;}
	else { 
		floatMode = NO;
	} 
	if (floatMode) {
		
		[minusOne setHidden:YES];
		[plusOne setHidden:YES];
		CGRect newSlider = CGRectMake(18, 136, 284, 23);
		[sliderCtl setFrame:newSlider]; 
		
	} else {
		
		[minusOne setHidden:NO];
		[plusOne setHidden:NO];
		CGRect newSlider = CGRectMake(50, 136, 220, 23);
		[sliderCtl setFrame:newSlider]; 
		
	}
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	
	[super viewDidLoad];
	
	if (createNew){
		
		[self viewLoadedToCreate];
		
	} else{
		
		[self viewLoadedToUpdate];
	}
	
	
	
}




- (void)locationUpdate:(CLLocation *)location {
	//  NSString *latitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.latitude];
	//locationLabel.text = [location description];
	locationLabel.text = [[NSString alloc] initWithFormat:@"Latitude: %g, Longitude: %g, Altitude: %g", location.coordinate.latitude, location.coordinate.longitude, location.altitude];
	pachubeLatitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.latitude];
	pachubeLongitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.longitude];
	pachubeAltitude = [[NSString alloc] initWithFormat:@"%g", location.altitude];
	
}

- (void)locationError:(NSError *)error {
    locationLabel.text = [error description];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)viewLoadedToCreate {
	
	[AddFeedToPachube setHidden:NO];
	[AddFeedToPachube setEnabled:YES];
	
	[updatePachubeButton setEnabled:NO];
	[updatePachubeButton setHidden:YES];
	
	[floatSwitch setEnabled:YES];
	[floatSwitch setHidden:NO];
	
	
	
	pachubeTabAppDelegate *feedDelegate = [[UIApplication sharedApplication] delegate];
	
	NSArray *tempArray = feedDelegate.AllTheFeeds;
	feedDictionary = [tempArray objectAtIndex:0];
	
	//botLabel.text = [feedDictionary objectForKey:@"fdMinLabel"];
	//topLabel.text = [feedDictionary objectForKey:@"fdMaxLabel"];
	//botLabelNum.text = [feedDictionary objectForKey:@"fdMinNum"];
	//topLabelNum.text = [feedDictionary objectForKey:@"fdMaxNum"];
	
	//	NSLog(@"My Special Test: %@",botLabel.text);
	
	//	[feedTest setObject:fdTitle forKey:@"fdTitle"];
	//	[feedTest setObject:fdDescription forKey:@"fdDescription"];
	//	[feedTest setObject:fdID forKey:@"fdID"];
	//	[feedTest setObject:fdMinNum forKey:@"fdMinNum"];
	//	[feedTest setObject:fdMaxNum forKey:@"fdMaxNum"];
	//	[feedTest setObject:fdMinLabel forKey:@"fdMinLabel"];
	//	[feedTest setObject:fdMaxLabel forKey:@"fdMaxLabel"];
	//	[feedTest setObject:fdIsFloat forKey:@"fdIsFloat"];
	
	
	
	self.navigationItem.title = @"Create A Feed";
	
	[floatSwitch addTarget:self
					action:@selector(setValueMode)
		  forControlEvents:UIControlEventValueChanged];
	
	floatMode = NO;
	floatSwitch.selectedSegmentIndex = 1;
	
	[botLabelNum setEnabled:YES];
	[topLabelNum setEnabled:YES];
	[botLabel setEnabled:YES];
	[topLabel setEnabled:YES];
	[descriptionLabel setEnabled:YES];
	
	botLabelNum.borderStyle = UITextBorderStyleRoundedRect;
	topLabelNum.borderStyle = UITextBorderStyleRoundedRect;
	botLabel.borderStyle = UITextBorderStyleRoundedRect;
	topLabel.borderStyle = UITextBorderStyleRoundedRect;
	descriptionLabel.borderStyle = UITextBorderStyleRoundedRect;
	
	
	[self setValueMode];
	[floatSwitch setHidden:YES];
	[loadingBar setHidden:YES];
	//[minusOne setHidden:YES];
	//[plusOne setHidden:YES];
	
	NSLog(@"%@", selectedCountry);
	descriptionLabel.text = selectedCountry;
	
	//self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(turnOnEditing)];
	
	[spinner setHidden:YES];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *botRangeNumTemp = @"0.0";
	[prefs setObject:botRangeNumTemp forKey:@"lowrangevalue"];
	
	NSString *topRangeNumTemp = @"100.0";
	[prefs setObject:topRangeNumTemp forKey:@"highrangevalue"];
	
	
	
	//NSString *mainTitleText =[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"]; 	
	[prefs setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"] forKey:@"mainTitle"];
	
	NSString *mainTitleTemp =[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"]; 	
	titleLabel.text = mainTitleTemp;
	
	
	NSString *botLabelNumTemp = [feedDictionary objectForKey:@"fdMinNum"];
	NSString *topLabelNumTemp = [feedDictionary objectForKey:@"fdMaxNum"];
	
	NSString *currentValue = [feedDictionary objectForKey:@"fdCurrentValue"];
	mainValue.text = currentValue;
	
	
	NSLog(@"Min Num = %@",[botLabelNumTemp floatValue]);
	NSLog(@"Max Num = %@",[botLabelNumTemp floatValue]);
	NSLog(@"Current Value Num = %@",[botLabelNumTemp floatValue]);
	
	sliderCtl.minimumValue = [botLabelNumTemp floatValue];
	sliderCtl.maximumValue = [topLabelNumTemp floatValue]; 
	sliderCtl.value = [currentValue floatValue];
	
	
	// Example 1, loading the content from a URLNSURL
	//NSURL *url = [NSURL URLWithString:@"http://dblog.com.au"];
	
	//	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	//	[webView loadRequest:request];
	
	// Example 2, loading the content from a string
	//NSString *HTMLData = @"<script type=\"text/javascript\" src=\"http://tile.cloudmade.com/wml/0.2/web-maps-lite.js\"></script><script type=\"text/javascript\" src=\"http://apps.pachube.com/trails/trails.js\"></script><script type=\"text/javascript\">createPachubeTrails(2322,1,2,3,280,240);</script>";
	
	
	//  NSString *HTMLData = @"http://apps.pachube.com/trails/preview.php?feed=2322&lot=1&lon=2&d=3&w=280&h=240";
	
	//[webWindow loadHTMLString:HTMLData baseURL:nil];
	
	//	locationController = [[PachubeCLController alloc] init];
	//	[locationController.locationManager startUpdatingLocation];
	//	locationController.delegate = self;
	
	
}

- (void)viewLoadedToUpdate {
	[AddFeedToPachube setHidden:YES];
	[AddFeedToPachube setEnabled:NO];
	
	pachubeTabAppDelegate *feedDelegate = [[UIApplication sharedApplication] delegate];
	
	NSArray *tempArray = feedDelegate.AllTheFeeds;
	feedDictionary = [tempArray objectAtIndex:0];
	
	botLabel.text = [feedDictionary objectForKey:@"fdMinLabel"];
	topLabel.text = [feedDictionary objectForKey:@"fdMaxLabel"];
	botLabelNum.text = [feedDictionary objectForKey:@"fdMinNum"];
	topLabelNum.text = [feedDictionary objectForKey:@"fdMaxNum"];
	
	//	NSLog(@"My Special Test: %@",botLabel.text);
	
	//	[feedTest setObject:fdTitle forKey:@"fdTitle"];
	//	[feedTest setObject:fdDescription forKey:@"fdDescription"];
	//	[feedTest setObject:fdID forKey:@"fdID"];
	//	[feedTest setObject:fdMinNum forKey:@"fdMinNum"];
	//	[feedTest setObject:fdMaxNum forKey:@"fdMaxNum"];
	//	[feedTest setObject:fdMinLabel forKey:@"fdMinLabel"];
	//	[feedTest setObject:fdMaxLabel forKey:@"fdMaxLabel"];
	//	[feedTest setObject:fdIsFloat forKey:@"fdIsFloat"];
	
	
	
	self.navigationItem.title = @"Update Feed";
	
	[floatSwitch addTarget:self
					action:@selector(setValueMode)
		  forControlEvents:UIControlEventValueChanged];
	
	floatMode = NO;
	floatSwitch.selectedSegmentIndex = 1;
	
	[botLabelNum setEnabled:NO];
	[topLabelNum setEnabled:NO];
	[botLabel setEnabled:NO];
	[topLabel setEnabled:NO];
	[descriptionLabel setEnabled:NO];
	
	[self setValueMode];
	[floatSwitch setHidden:YES];
	[loadingBar setHidden:YES];
	//[minusOne setHidden:YES];
	//[plusOne setHidden:YES];
	
	NSLog(@"%@", selectedCountry);
	descriptionLabel.text = selectedCountry;
	
	//self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(turnOnEditing)];
	
	[spinner setHidden:YES];
	
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *botRangeNumTemp = @"0.4";
	[prefs setObject:botRangeNumTemp forKey:@"lowrangevalue"];
	
	NSString *topRangeNumTemp = @"135.33";
	[prefs setObject:topRangeNumTemp forKey:@"highrangevalue"];
	
	
	
	//NSString *mainTitleText =[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"]; 	
	[prefs setObject:[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"] forKey:@"mainTitle"];
	
	NSString *mainTitleTemp =[[NSUserDefaults standardUserDefaults] stringForKey:@"mainTitle"]; 	
	titleLabel.text = mainTitleTemp;
	
	
	//	NSString* botLabelTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"lowrangename"]; 
	//	botLabel.text = botLabelTemp;
	//	
	//	NSString* botLabelNumTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"lowrangevalue"]; 
	//	botLabelNum.text = botLabelNumTemp;
	
	// make this read only?
	//	NSString* currentValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentvalue"]; 
	// 
	
	//	NSString* topLabelTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"highrangename"]; 
	//	topLabel.text = topLabelTemp;
	//	
	//	NSString* topLabelNumTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"highrangevalue"]; 
	//	topLabelNum.text = topLabelNumTemp;
	
	
	NSString *botLabelNumTemp = [feedDictionary objectForKey:@"fdMinNum"];
	NSString *topLabelNumTemp = [feedDictionary objectForKey:@"fdMaxNum"];
	
	NSString *currentValue = [feedDictionary objectForKey:@"fdCurrentValue"];
	mainValue.text = currentValue;
	
	
	NSLog(@"Min Num = %@",[botLabelNumTemp floatValue]);
	NSLog(@"Max Num = %@",[botLabelNumTemp floatValue]);
	NSLog(@"Current Value Num = %@",[botLabelNumTemp floatValue]);
	
	sliderCtl.minimumValue = [botLabelNumTemp floatValue];
	sliderCtl.maximumValue = [topLabelNumTemp floatValue]; 
	sliderCtl.value = [currentValue floatValue];
	
	
	// Example 1, loading the content from a URLNSURL
	//NSURL *url = [NSURL URLWithString:@"http://dblog.com.au"];
	
	//	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	//	[webView loadRequest:request];
	
	// Example 2, loading the content from a string
	//NSString *HTMLData = @"<script type=\"text/javascript\" src=\"http://tile.cloudmade.com/wml/0.2/web-maps-lite.js\"></script><script type=\"text/javascript\" src=\"http://apps.pachube.com/trails/trails.js\"></script><script type=\"text/javascript\">createPachubeTrails(2322,1,2,3,280,240);</script>";
	
	
	//  NSString *HTMLData = @"http://apps.pachube.com/trails/preview.php?feed=2322&lot=1&lon=2&d=3&w=280&h=240";
	
	//[webWindow loadHTMLString:HTMLData baseURL:nil];
	
	locationController = [[PachubeCLController alloc] init];
	[locationController.locationManager startUpdatingLocation];
	locationController.delegate = self;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (UISlider *)sliderCtl
{
    if (sliderCtl == nil) 
    {
		//     CGRect frame = CGRectMake(174.0, 12.0, 120.0, 4.0);
		//     sliderCtl = [[UISlider alloc] initWithFrame:frame];
        [sliderCtl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
        
        // in case the parent view draws with a custom color or gradient, use a transparent color
        sliderCtl.backgroundColor = [UIColor clearColor];
        
		//  sliderCtl.minimumValue = 0.0;
		//  sliderCtl.maximumValue = 100.0;
        sliderCtl.continuous = YES;
        
		
		// sliderCtl.tag = kViewTag;	// tag this view for later so we can remove it from recycled table cells
    }
    return sliderCtl;
}


- (void)dealloc {
	
	[nameInput release];
	[settings release];
	[spinner release];
	
	[locationController release];
	
    [super dealloc];
}


@end
