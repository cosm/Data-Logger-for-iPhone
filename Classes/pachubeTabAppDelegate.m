//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

#import "pachubeTabAppDelegate.h"

@implementation pachubeTabAppDelegate

@synthesize window, AllTheFeeds;
@synthesize tabBarController;

@synthesize remoteHostStatus;
@synthesize internetConnectionStatus;
@synthesize localWiFiConnectionStatus;



- (void)didReceiveMemoryWarning {
	
	[super didReceiveMemoryWarning]; 

}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	[window addSubview:tabBarController.view];	
	[window makeKeyAndVisible];
	

	
	
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] == nil)
	{
		AllTheFeeds = [[NSMutableArray alloc] init];
		[[NSUserDefaults standardUserDefaults] setObject:AllTheFeeds forKey:@"AllTheFeeds"];
		tabBarController.selectedIndex = 2;
		[AllTheFeeds release];
	}
	
	

}


#pragma mark Reachability
- (NSString *)hostName
{
	return @"www.pachube.com";
}

- (BOOL)CheckReachability
{
	//[[Reachability sharedReachability] setHostName:[self hostName]];
	
	//self.remoteHostStatus           = [[Reachability sharedReachability] remoteHostStatus];
    self.internetConnectionStatus    = [[Reachability sharedReachability] internetConnectionStatus];
    self.localWiFiConnectionStatus    = [[Reachability sharedReachability] localWiFiConnectionStatus];
	
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Connection Error" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
	
	int flag = 0;//all ok
	
//	if (self.remoteHostStatus == NotReachable)
//	{
//		flag = 1;//remote host not reachable
//	}
	
	if (self.internetConnectionStatus == NotReachable && self.localWiFiConnectionStatus == NotReachable)
	{
		flag = 2;//2:No Carrier data network
	}
	
	if( flag == 0 )
	{
		//alert.title = @"Connection Available";
		//alert.message = @"Connected to the Internet";
		//[alert show];
		return TRUE;
	}
	else
	{

		alert.message = @"Data Logger requires an active internet connection. Please check your settings and try again.";
		[alert show];
		return FALSE;
		
	}
}





@end

