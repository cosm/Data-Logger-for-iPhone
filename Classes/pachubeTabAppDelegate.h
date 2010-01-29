//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27


// makes use of:
//	Keyvisuals - Reachibility Class Available here http://iphone.keyvisuals.com

//  The reachibility Class is used for testing for an active 3g or wifi connection

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
