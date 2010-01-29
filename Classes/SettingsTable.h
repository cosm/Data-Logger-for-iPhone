//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

//  Settings is a tableViewController for the settings page. Actually only loads user name and password currently
//  Any future global settings can be added to the table.


#import <UIKit/UIKit.h>
#import "pachubeTabAppDelegate.h"

@interface SettingsTable : UITableViewController <UITextFieldDelegate> {
		
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	pachubeTabAppDelegate *theDelegate;

	UITableView *tableView;
	
	UITextField		*textFieldNormal;
	UITextField		*textFieldSecure;
	
	NSArray			*dataSourceArray;
	
	UIImageView *bG;
}

@property (nonatomic, retain, readonly) UITextField	*textFieldNormal;
@property (nonatomic, retain, readonly) UITextField	*textFieldRounded;
@property (nonatomic, retain, readonly) UITextField	*textFieldSecure;
@property (nonatomic, retain, readonly) UITextField	*textFieldLeftView;
@property (nonatomic, retain) UIImageView	*bG;
@property (nonatomic, retain) NSArray *dataSourceArray;


@end
