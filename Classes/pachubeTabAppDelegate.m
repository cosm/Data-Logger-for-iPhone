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

