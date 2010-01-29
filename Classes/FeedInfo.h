//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

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
