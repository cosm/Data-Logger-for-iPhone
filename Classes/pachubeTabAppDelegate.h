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



//	Makes use of External Classes:

//	Reachability.h
//  --------------
//	Keyvisuals - Reachibility Class Available here http://iphone.keyvisuals.com
//  The reachibility Class is used for testing for an active 3g or wifi connection


//  NSDataAdditions.h
//	-----------------
//	Used for encoding Base 64.
//	Copyright 2008 Kaliware, LLC. All rights reserved. Created by khammond on Mon Oct 29 2001. 
//	Formatted by Timothy Hatcher on Sun Jul 4 2004. Copyright (c) 2001 Kyle Hammond. All rights reserved.
//	Original development by Dave Winer.






#import <UIKit/UIKit.h>
#import "SetUpViewController.h"
#import "TextViewController.h"
#import "FeedInfo.h"
#import "PachubeCLController.h"
#import "FeedUpdate.h"
#import "SetUpViewController.h"
#import "FeedHistory.h"
#import "FeedInfo.h"
#import "TextViewController.h"
#import "Reachability.h"



@interface pachubeTabAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
   
	UIWindow *window;
    UITabBarController *tabBarController;
	NSMutableArray *AllTheFeeds;
	
	NetworkStatus remoteHostStatus;
    NetworkStatus internetConnectionStatus;
    NetworkStatus localWiFiConnectionStatus;
	
}



@property NetworkStatus remoteHostStatus;
@property NetworkStatus internetConnectionStatus;
@property NetworkStatus localWiFiConnectionStatus;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) NSMutableArray *AllTheFeeds;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

- (BOOL)CheckReachability;

@end
