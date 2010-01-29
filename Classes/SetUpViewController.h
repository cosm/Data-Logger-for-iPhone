//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.2.6


#import <UIKit/UIKit.h>
#import "pachubeTabAppDelegate.h"	

@interface SetUpViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

{
	
	//network connection stuff
	NSMutableData *webData;
	
	//other stuff
	UIPickerView		*myPickerView;
	NSArray				*pickerViewArray;

	UILabel				*label;
	UIPickerView		*customPickerView;
	
	UIView				*currentPicker;
	
	UISegmentedControl	*buttonBarSegmentedControl;
	UISegmentedControl	*pickerStyleSegmentedControl;
	UILabel				*segmentLabeler;

	UITextField			*botRangeNum;
	UITextField			*topRangeNum;
	UITextField			*heading;
	UITextField			*tags;
	UITextField			*unit;
	UITextField			*unitFull;
	
	UISegmentedControl  *floatSwitch;
	
	UINavigationItem	*saveFeed;
	
	NSString			*tempFeedNumber;
	Boolean				*feedJustCreated;
	
	NSString			*editingMode;

	NSString			*mostRecentResponseCode;
	
	IBOutlet UIImageView			*disabledCover;
	IBOutlet UIActivityIndicatorView *creationSpinner;
	
	NSDictionary		*feedDictionary;
	NSString			*feedNumber;
	NSString			*rowSelect;
	
	BOOL				*hasBeenEdited;
	BOOL				*inEditingMode;
	
	NSMutableArray		*tempArray;
	NSMutableDictionary *newFeedDetails;
	
	
}

@property (nonatomic, retain) UIPickerView *myPickerView;
@property (nonatomic, retain) NSArray *pickerViewArray;

@property (nonatomic, retain) NSArray *tempArray;

@property (nonatomic, retain) NSMutableDictionary *newFeedDetails;
@property (nonatomic, retain) NSString *feedNumber;
@property (nonatomic, retain) NSString *rowSelect;

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) UIPickerView *customPickerView;
@property (nonatomic, retain) UIView *currentPicker;
@property (nonatomic, retain) UINavigationItem *saveFeed;

@property (nonatomic, retain) IBOutlet UISegmentedControl *floatSwitch;
@property (nonatomic, retain) IBOutlet UILabel *segmentLabeler;

@property (nonatomic, retain) IBOutlet UITextField *botRangeNum;
@property (nonatomic, retain) IBOutlet UITextField *topRangeNum;
@property (nonatomic, retain) IBOutlet UITextField *heading;
@property (nonatomic, retain) IBOutlet UITextField *tags;
@property (nonatomic, retain) IBOutlet UITextField *unit;
@property (nonatomic, retain) IBOutlet UITextField *unitFull;

@property (nonatomic, retain) UIImageView	*disabledCover;
@property (nonatomic, retain) UIActivityIndicatorView *creationSpinner;
		
//network stuff
@property(nonatomic, retain) NSMutableData *webData;
@property (nonatomic, retain) UIActivityIndicatorView *spinnerSetup;

@property (nonatomic, retain) NSString *tempFeedNumber;
@property (nonatomic, retain) NSString *mostRecentResponseCode;

@property (nonatomic, retain) NSString *editingMode;



- (IBAction)sendAndCreate:(id)sender;
- (IBAction)saveSetUp:(id)sender;		
@end

