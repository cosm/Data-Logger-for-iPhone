//
//  FeedUpdate.h
//  pachubeTabV2
//
//  Created by Christopher  on 29/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PachubeCLController.h"
#import "pachubeTabAppDelegate.h"


@interface FeedNew : UIViewController {
	
	IBOutlet UIButton *updatePachubeButton;
	
	IBOutlet UITextField *descriptionLabel;
	NSString *selectedCountry;
	
	IBOutlet UISlider *sliderCtl;
	IBOutlet UILabel *mainValue;
	
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UITextField *nameInput;
	IBOutlet UITextField *titleLabel;
	
	IBOutlet UITextField *topLabel; 
	IBOutlet UITextField *botLabel;
	IBOutlet UITextField *botLabelNum;
	IBOutlet UITextField *topLabelNum;
	IBOutlet UILabel *statusLabel;
	IBOutlet UIButton *settings;
	IBOutlet UIImageView *bg;
	
	IBOutlet UIButton *plusOne;
	IBOutlet UIButton *minusOne;
	
	IBOutlet UIButton *AddFeedToPachube;
	
	NSMutableData *webData;
	
	NSMutableString *soapResults;
	
	NSString *pachubeLatitude;
	NSString *pachubeLongitude;
	NSString *pachubeAltitude;
	
	NSXMLParser *xmlParser;
	BOOL *recordResults;
	int *keyValue;
	
	Boolean *createNew;
    
	IBOutlet UIImageView *imageViewer;
	IBOutlet UIImage *image;
	IBOutlet UILabel *locationLabel;
	IBOutlet UISegmentedControl *floatSwitch;
	IBOutlet UIProgressView *loadingBar;
	
	PachubeCLController *locationController;
	BOOL *floatMode;
	
	NSDictionary *feedDictionary;
	NSString *mainFeedID;
	NSInteger *passedIndex;
}


@property(nonatomic, retain) NSDictionary *feedDictionary;
@property(nonatomic, retain) NSString *mainFeedID;

@property(nonatomic, readwrite) NSInteger *passedIndex;

@property(nonatomic, readwrite) Boolean *createNew;



@property(nonatomic, retain) NSString *selectedCountry;
@property(nonatomic, retain) IBOutlet UILabel *locationLabel;
@property(nonatomic, retain) IBOutlet UITextField *nameInput;
@property(nonatomic, retain) IBOutlet UIImage *image;
@property(nonatomic, retain) IBOutlet UIButton *settings;
@property(nonatomic, retain) IBOutlet UISegmentedControl *floatSwitch;

@property(nonatomic, retain) IBOutlet UIButton *plusOne;
@property(nonatomic, retain) IBOutlet UIButton *minusOne;

@property(nonatomic, retain) IBOutlet UIButton *updatePachubeButton;
@property(nonatomic, retain) IBOutlet UIButton *AddFeedToPachube;


@property(nonatomic, retain) IBOutlet UIImageView *imageViewer;
@property(nonatomic, retain) IBOutlet UITextField *titleLabel;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, retain) NSString *pachubeLongitude;
@property(nonatomic, retain) NSString *pachubeLatitude;
@property(nonatomic, retain) NSString *pachubeAltitude;
@property(nonatomic, retain) UILabel *mainValue;
@property(nonatomic, retain) UILabel *statusLabel;
@property(nonatomic, retain) UISlider *sliderCtl;
@property(nonatomic, retain) UIImageView *bg;
@property(nonatomic, retain) IBOutlet UIProgressView *loadingBar;

@property(nonatomic, retain) IBOutlet UITextField *topLabelNum;
@property(nonatomic, retain) IBOutlet UITextField *botLabelNum;
@property(nonatomic, retain) IBOutlet UITextField *topLabel;
@property(nonatomic, retain) IBOutlet UITextField *botLabel;


//@property(nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@property (nonatomic, retain) IBOutlet UIWebView *webWindow;


-(IBAction)buttonClick: (id) sender;
-(IBAction)minusOneValue: (id) sender;
-(IBAction)plusOneValue: (id) sender;

-(IBAction)historyButton: (id) sender;
-(IBAction)button2Send: (id) sender;
-(IBAction)settingsButtonPressed: (id) sender;


- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
//- (void)refreshPrefs: (id) sender;

-(IBAction)sliderMoved: (id) sender;

@end

