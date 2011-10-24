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



#import "FeedList.h"


@implementation FeedList

@synthesize ListArray, feedStringToDelete, deleteSpinner;




-(void)deleteFeed:(NSString *)feedID {


	[self waitingGraphicsOn];
	NSLog(@"deleteFeed is being called");
	
NSString* usernameTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"]; 
NSString* passwordTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"]; 
//

NSString* urlFull = [NSString stringWithFormat:@"https://www.pachube.com/api/%@.xml", feedID];

if (usernameTemp == NULL || usernameTemp == nil || usernameTemp == @"" || passwordTemp == NULL || passwordTemp == nil ||passwordTemp == @"") {
	
	
// if the password is wrong
	
} else {
	
	
	NSLog(@"username: %@", usernameTemp);
	NSLog(@"password: %@", passwordTemp);
	NSLog(@"%@", urlFull);

	
	NSURL *getUrl = [NSURL URLWithString:urlFull];
	NSMutableURLRequest *theDeleteRequest = [NSMutableURLRequest requestWithURL:getUrl];
	
	// get the length of the body
	//NSString *msgLength = [NSString stringWithFormat:@"%d", [pachubeXML length]];
	
	
	//this uses base64Encoding from the NSDatatAdditions class for		the username/password in the https header
	NSString *authString = [[[NSString stringWithFormat:@"%@:%@", usernameTemp, passwordTemp] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];
	authString = [NSString stringWithFormat: @"Basic %@", authString];
	
	
	// set up the DELETE request
	[theDeleteRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theDeleteRequest addValue:authString forHTTPHeaderField:@"Authorization"];
	[theDeleteRequest setHTTPMethod:@"DELETE"];

	
	NSURLConnection *theDeleteConnection = [[NSURLConnection alloc] initWithRequest:theDeleteRequest delegate:self];

	
	if( theDeleteConnection )
		{	
			webData = [[NSMutableData data] retain];
		}
	else
		{
			NSLog(@"theGetConnection is NULL");
		}
	

	}	

}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
	
	NSLog(@"STATUS CODE = %i", responseStatusCode );
	//mostRecentResponseCode = responseStatusCode;
	
	

	
	[self waitingGraphicsOff];
	
	if (responseStatusCode == 200) {
	
			
		
			NSLog(@"so the feed should have deleted");
			[ListArray removeObjectAtIndex:feedToDelete];
			[[NSUserDefaults standardUserDefaults] setObject:ListArray forKey:@"AllTheFeeds"];
			[self.tableView reloadData];
	
	}	else if (responseStatusCode == 404) {
		
		NSLog(@"feed wasn't found on pachube so it has been deleted anyway");
		[ListArray removeObjectAtIndex:feedToDelete];
		[[NSUserDefaults standardUserDefaults] setObject:ListArray forKey:@"AllTheFeeds"];
		[self.tableView reloadData];
		[self alert404];
		
		
	}	else if (responseStatusCode == 401) {
		
		[self alert401];
		
		
	} else {
		
		
		
		NSLog(@"connectiong BP: 5");
		
	//	[self alertStatusResponse];
		
	}
	
	NSLog(@"connectiong BP: 6");
	
	[webData setLength: 0];

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

}


-(void)waitingGraphicsOn{
	
	deleteSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	int spinnerHeight = feedToDelete;

	
	[deleteSpinner setCenter:CGPointMake(160,(spinnerHeight * 80) + 40)]; // I do this because I'm in landscape mode
	[self.view addSubview:deleteSpinner];
	[deleteSpinner startAnimating];
	
	self.tableView.scrollEnabled = NO;
	self.tableView.userInteractionEnabled = NO;
	
}

-(void)waitingGraphicsOff{
	
	[deleteSpinner stopAnimating];
	self.tableView.scrollEnabled = YES;
	self.tableView.userInteractionEnabled = YES;
	

	[deleteSpinner release];

}


- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	
	if (actionSheet.tag == @"alertConfirmFeedDeletion"){
		
		if (buttonIndex == 1) {
			[self deleteFeed:feedStringToDelete];
		}
			
	} 
	
	
}

- (void)alertConfirmFeedDeletion
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Are you sure you wish to delete this feed and all its data from Pachube.com?" delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:@"Yes", nil];
	
	alert.tag = @"alertConfirmFeedDeletion";											   
	[alert show];
	[alert release];
}


-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"DONE. Received Bytes: %d", [webData length]);	
	
	[connection release];
	[webData release];
		
}


- (void)alert404
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feed Error" message:@"The feed your trying to delete does not exist on Pachube.com. It may already have been deleted." delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alert404";											   
	[alert show];
	[alert release];
}


- (void)alert401
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Check Your username and password and try again." delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alert401";											   
	[alert show];
	[alert release];
}

- (void)alert403
{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Check Your username and password and try again." delegate:self cancelButtonTitle:@"Cancel"  otherButtonTitles:nil, nil];
	
	alert.tag = @"alert403";											   
	[alert show];
	[alert release];
}



- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
	CGRect CellFrame = CGRectMake(0, 0, 300, 80);
	
	
	NSLog(@"THE CELL IS BEING CREATED oh boy: %@", cellIdentifier);
	
	CGRect Label1Frame = CGRectMake(10, 5, 280, 35);
	CGRect Label2Frame = CGRectMake(10, 35, 280, 15);
	CGRect Label3Frame = CGRectMake(10, 50, 280, 15);

	UILabel *lblTemp;
	
	UITableViewCell *cell = [[[UITableViewCell alloc] initWithFrame:CellFrame reuseIdentifier:cellIdentifier] autorelease];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
	lblTemp.font = [UIFont boldSystemFontOfSize:22];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
	lblTemp.textColor = [UIColor lightGrayColor];
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label3Frame];
	lblTemp.tag = 3;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
	lblTemp.textColor = [[UIColor alloc] initWithRed:0.39 green:0.59 blue:0.39 alpha:1.0];
	
	 
	
	[cell.contentView addSubview:lblTemp];
	[lblTemp release];
	
	
	return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
	NSNumber *quick = 1;
	return quick;
	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	return [ListArray count];
	
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if(cell == nil)
		cell = [self getCellContentView:CellIdentifier];
	
	UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
	UILabel *lblTemp3 = (UILabel *)[cell viewWithTag:3];

	
	CGRect Label1Frame = CGRectMake(10, 5, 280, 35);
	CGRect Label2Frame = CGRectMake(10, 35, 280, 15);
	CGRect Label3Frame = CGRectMake(10, 50, 280, 15);
	
	if(self.editing)
		
	{
		Label1Frame = CGRectMake(10, 5, 200, 35);
		Label2Frame = CGRectMake(10, 35, 200, 15);
		Label3Frame = CGRectMake(10, 50, 200, 15);
		
	}
	
	lblTemp1.frame = Label1Frame;
	lblTemp2.frame = Label2Frame;
	lblTemp3.frame = Label3Frame;

	NSDictionary *newDict = [ListArray objectAtIndex:indexPath.row];
	
	NSString *titleTemp = [newDict objectForKey:@"fdTitle"];
	NSString *descTemp = [newDict objectForKey:@"fdDescription"];
	NSString *fdCVTemp = [newDict objectForKey:@"fdCurrentValue"];
	NSString *fdUnitTemp = [newDict objectForKey:@"fdUnit"];
		
	lblTemp1.text = titleTemp;
	lblTemp2.text = descTemp;
	lblTemp3.text = [NSString stringWithFormat:@"Current Value: %@ %@", fdCVTemp,fdUnitTemp];
	
	cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
	
	
	
	return cell;
}

-(IBAction)AddNewFeed: (id) sender;

{

	if ([ListArray count] < 20){
	
	 SetUpViewController *dvController = [[SetUpViewController alloc] initWithNibName:@"FeedNew" bundle:[NSBundle mainBundle]];
	 //dvController.editingMode = NO;
	dvController.rowSelect =  @"2";
	dvController.editingMode = @"0";
	
		dvController.feedNumber = [NSString stringWithFormat:@"%i",[ListArray count]];
		
		
	 [self.navigationController pushViewController:dvController animated:YES];
	 [dvController release];
	 dvController = nil;
	
		
	} else {
	
		[self alertFeedCountLimit];
		
	}
		
}

-(void)alertFeedCountLimit{
	
	
		// open a alert with an OK and cancel button
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Feed Creation Error" message:@"You Have Reached The Maximum Number of Feeds"
													   delegate:self cancelButtonTitle:@"OK"  otherButtonTitles:nil, nil];
		
	
	alert.tag = @"alertFeedCountLimit";
		[alert show];
		[alert release];
	
	
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	FeedUpdate *dvController = [[FeedUpdate alloc] initWithNibName:@"FeedController" bundle:[NSBundle mainBundle]];
	NSString *tempIndex = [NSString stringWithFormat:@"%i", indexPath.row];
	NSLog(@"THE INDEX BEING PASSED:%@",[NSString stringWithFormat:@"%i", indexPath.row]);
	dvController.createNew = NO;
	dvController.passedIndex = tempIndex;
	 
	[self.navigationController pushViewController:dvController animated:YES];
	
	[dvController release];
	 dvController = nil;
	
}

- (void)viewWillAppear:(BOOL)animated {
	[self editingFinished];

	
	feedToDelete = -1;
	ListArray = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
	
    NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
		
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"[%@ viewDidAppear:%d]", [self class], animated);
	
	[self.tableView reloadData];
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"[%@ viewWillDisappear:%d]", [self class], animated);
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
	
	[self editingFinished];
	
    [super viewDidDisappear:animated];
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 75;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
	
	- (void)viewDidLoad {
		[super viewDidLoad];
		
		
		pachubeTabAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
		[delegate CheckReachability];
		
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(EditTable:)];
		[self.navigationItem setLeftBarButtonItem:addButton];

		
		letUserSelectRow = YES;
		
	}
	
	//dealloc method declared in RootViewController.m
- (void)dealloc {
		
	//[ListArray release];
		[super dealloc];
		
	}

- (IBAction) EditTable:(id)sender{
	if(self.editing)
	{
		

		[self editingFinished];
		[self.tableView reloadData];
	
	}
	else
	{
	

		[self editingStarted];
		[self.tableView reloadData];
	}
}


-(void)editingStarted

{
	
	[super setEditing:YES animated:YES];
	[self.tableView  setEditing:YES animated:YES];
	[self.tableView  reloadData];
	[self.navigationItem.leftBarButtonItem setTitle:@"Done"];
	[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
	
	
}

-(void)editingFinished{
	
	[super setEditing:NO animated:YES];
	[self.tableView setEditing:NO animated:YES];
	[self.tableView  reloadData];
	[self.navigationItem.leftBarButtonItem setTitle:@"Edit"];
	[self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStylePlain];
	
	
	
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		
		NSLog(@"it is as least getting here");
		
		NSLog(@"row test:%i", indexPath.row);
	
		feedToDelete = indexPath.row;
		feedStringToDelete = [[ListArray objectAtIndex:indexPath.row] objectForKey:@"fdID"];
		[self alertConfirmFeedDeletion];
		
	} 
	
}


#pragma mark Row reordering
// Determine whether a given row is eligible for reordering or not.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

// Process the row move. This means updating the data model to correct the item indices.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
	
	toIndexPath:(NSIndexPath *)toIndexPath {	
	NSString *item = [[ListArray objectAtIndex:fromIndexPath.row] retain];
	[ListArray removeObject:item];
	[ListArray insertObject:item atIndex:toIndexPath.row];

	[[NSUserDefaults standardUserDefaults] setObject:ListArray forKey:@"AllTheFeeds"];
	[item release];

}

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

- (void)viewDidUnload {
	
	NSLog(@"view UNLOADED ONE");
	[[NSUserDefaults standardUserDefaults] synchronize];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}




@end
