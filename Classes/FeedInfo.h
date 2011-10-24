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

#import <UIKit/UIKit.h>
#import "pachubeTabAppDelegate.h"

@interface FeedInfo : UITableViewController <UITextFieldDelegate> {
	
	IBOutlet UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
	
	UITableView *tableView;
	
	UITextField		*textFieldNormal;
	UITextField		*textFieldSecure;

	UIButton *detailDisclosureButtonType;
	
	UISegmentedControl *domainButton;
	UISegmentedControl *exposureButton;
	UISegmentedControl *positionButton;
	
	NSArray	*dataSourceArray;
	
	NSString *feedNumber;
	NSString *editMode;
	
	UIImageView *bG;
	
	NSMutableDictionary *feedDictionary;
	
	NSString *fdDomainTemp;
	NSString *fdExposureTemp;
	NSString *fdDispositionTemp;
	NSString *fdURLTemp;
	NSString *fdLocationTemp;
	
	NSMutableArray *feedList;
	
}

@property (nonatomic, retain) UISegmentedControl	*domainButton;
@property (nonatomic, retain) UISegmentedControl	*exposureButton;
@property (nonatomic, retain) UISegmentedControl	*positionButton;

@property (nonatomic, retain) UIButton	*detailDisclosureButtonType;

@property (nonatomic, retain) UITextField	*textFieldNormal;
@property (nonatomic, retain) UITextField	*textFieldSecure;

@property (nonatomic, retain) UIImageView	*bG;

@property (nonatomic, retain) NSArray *dataSourceArray;
@property (nonatomic, retain) NSString *feedNumber;
@property (nonatomic, retain) NSString *editMode;
 

@property (nonatomic, retain) NSString *fdDomainTemp;
@property (nonatomic, retain) NSString *fdExposureTemp;
@property (nonatomic, retain) NSString *fdDispositionTemp;
@property (nonatomic, retain) NSString *fdURLTemp;
@property (nonatomic, retain) NSString *fdLocationTemp;

@property (nonatomic, retain) NSMutableArray *feedList;
@property (nonatomic, retain) NSMutableDictionary *feedDictionary;

@end
