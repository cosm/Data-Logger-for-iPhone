//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 0.27


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
#import "PachubeCLController.h"
#import "pachubeTabAppDelegate.h"


// Feed update is the view controller for updating a feed
// it loads the history and metadata by hiding and unhiding UI elements and changing the background image
// it loads SetUpViewController in edit mode as a sub view for editing the numeric values of the feed
// it loads FeedInfo as a subview for editing the metadata.


@interface FeedUpdate : UIViewController <UITextFieldDelegate, UIWebViewDelegate> {
	
	
	IBOutlet UIWebView *metadataWebView;
	
	IBOutlet UISegmentedControl *modeSelect;
	IBOutlet UIButton *updatePachubeButton;
	IBOutlet UITextField *descriptionLabel;

	IBOutlet UISlider *sliderCtl;
	IBOutlet UITextField *mainValueEntry;

	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UIActivityIndicatorView *locationSpinner;
	IBOutlet UIActivityIndicatorView *historySpinner;
	IBOutlet UITextField *titleLabel;
	IBOutlet UILabel *statusLabel;
	IBOutlet UIButton *settings;
	IBOutlet UIImageView *bg;
	
	IBOutlet UILabel *unitLabel;
	IBOutlet UIButton *plusOne;
	IBOutlet UIButton *minusOne;
	
	IBOutlet UIButton *modifyInfoButton;
	IBOutlet UIButton *modifyArrow;

	IBOutlet UISwitch *gpsSwitch;
	
// metadata labels:
		
	
	NSString *pachubeLatitude;
	NSString *pachubeLongitude;
	NSString *pachubeAltitude;
	
	int *LastMode;
	
	NSMutableData *webData;


	BOOL *proceed;
	BOOL *loading;

	
	int *keyValue;
	
	Boolean *createNew;
    

	IBOutlet UILabel *locationLabel;
	IBOutlet UILabel *timeLabel;
	

	IBOutlet UIProgressView *loadingBar;
	
	PachubeCLController *locationController;
	BOOL *floatMode;
	
	NSMutableDictionary *feedDictionary;
	NSString *mainFeedID;
	NSString *passedIndex;
	
	IBOutlet UIImageView *graph;
	IBOutlet UISwitch *geoLocate;
	IBOutlet UILabel *locate;
	
	NSMutableArray *tempArray;
	
}


@property(nonatomic, retain) NSMutableDictionary *feedDictionary;
@property(nonatomic, retain) NSString *mainFeedID;

@property(nonatomic, retain) NSString *passedIndex;


@property(nonatomic, readwrite) Boolean *createNew;

@property(nonatomic, retain) IBOutlet UILabel *locationLabel;
@property(nonatomic, retain) IBOutlet UILabel *timeLabel;

@property(nonatomic, retain) IBOutlet UIButton *settings;


@property(nonatomic, retain) IBOutlet UISegmentedControl *modeSelect;

@property(nonatomic, retain) IBOutlet UIButton *modifyInfoButton;
@property(nonatomic, retain) IBOutlet UIButton *modifyArrow;


@property(nonatomic, retain) IBOutlet UIButton *plusOne;
@property(nonatomic, retain) IBOutlet UIButton *minusOne;

@property(nonatomic, retain) IBOutlet UIButton *updatePachubeButton;
@property(nonatomic, retain) IBOutlet UISwitch *gpsSwitch;
@property(nonatomic, retain) IBOutlet UIImageView *graph;
@property(nonatomic, retain) IBOutlet UISwitch *geoLocate;
@property(nonatomic, retain) IBOutlet UILabel *unitLabel;

@property(nonatomic, retain) IBOutlet UITextField *titleLabel;
@property(nonatomic, retain) NSMutableData *webData;



@property(nonatomic, retain) NSString *pachubeLongitude;
@property(nonatomic, retain) NSString *pachubeLatitude;
@property(nonatomic, retain) NSString *pachubeAltitude;


@property(nonatomic, retain) IBOutlet UITextField *mainValueEntry;

@property(nonatomic, retain) UILabel *statusLabel;
@property(nonatomic, retain) UISlider *sliderCtl;
@property(nonatomic, retain) UIImageView *bg;
@property(nonatomic, retain) IBOutlet UIProgressView *loadingBar;


//metadata properties


@property(nonatomic, retain) IBOutlet UIWebView *metadataWebView;

//@property(nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;
@property (nonatomic, retain) UIActivityIndicatorView *locationSpinner;
@property (nonatomic, retain) UIActivityIndicatorView *historySpinner;

@property (nonatomic, retain) IBOutlet UIWebView *webWindow;


-(IBAction)buttonClick: (id) sender;
-(IBAction)minusOneValue: (id) sender;
-(IBAction)plusOneValue: (id) sender;


-(IBAction)infoButton: (id) sender;
-(IBAction)ValueEntry: (id) sender;

-(IBAction)button2Send: (id) sender;
-(IBAction)settingsButtonPressed: (id) sender;


- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

//- (void)modeChanged:(id)sender;
//- (void)refreshPrefs: (id) sender;

-(IBAction)sliderMoved: (id) sender;

@end

