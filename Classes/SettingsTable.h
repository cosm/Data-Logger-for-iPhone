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
