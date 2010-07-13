//
//  FirstViewController.h
//  pachubeTab
//
//  Created by Christopher  on 14/08/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PachubeCLController.h"
#import "pachubeTabAppDelegate.h"

@interface FirstViewController : UIViewController <UITextFieldDelegate> {

	IBOutlet UISlider *sliderCtl;
	IBOutlet UILabel *mainValue;
	
	IBOutlet UIActivityIndicatorView *spinner;
	IBOutlet UITextField *nameInput;
	IBOutlet UILabel *titleLabel;
	
	IBOutlet UILabel *topLabel;
	IBOutlet UILabel *botLabel;
	IBOutlet UILabel *topLabelNum;
	IBOutlet UILabel *botLabelNum;
	IBOutlet UILabel *statusLabel;
	IBOutlet UIButton *settings;
	IBOutlet UIImage *bg;
	
	NSMutableData *webData;
	
	NSMutableString *soapResults;
	
	NSString *pachubeLatitude;
	NSString *pachubeLongitude;
	NSString *pachubeAltitude;	
	
	NSXMLParser *xmlParser;
	BOOL *recordResults;
	int *keyValue;
    
	IBOutlet UIImageView *imageViewer;
	IBOutlet UIImage *image;
	IBOutlet UILabel *locationLabel;
	
	PachubeCLController *locationController;		

}

@property(nonatomic, retain) IBOutlet UILabel *locationLabel;
@property(nonatomic, retain) IBOutlet UITextField *nameInput;
@property(nonatomic, retain) IBOutlet UIImage *image;
@property(nonatomic, retain) IBOutlet UIButton *settings;
@property(nonatomic, retain) IBOutlet UIImageView *imageViewer;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
@property(nonatomic, retain) NSString *pachubeLongitude;
@property(nonatomic, retain) NSString *pachubeLatitude;
@property(nonatomic, retain) NSString *pachubeAltitude;
@property(nonatomic, retain) UILabel *mainValue;
@property(nonatomic, retain) UILabel *statusLabel;
@property(nonatomic, retain) UISlider *sliderCtl;
@property(nonatomic, retain) UIImage *bg;

@property(nonatomic, retain) IBOutlet UILabel *topLabelNum;
@property(nonatomic, retain) IBOutlet UILabel *botLabelNum;
@property(nonatomic, retain) IBOutlet UILabel *topLabel;
@property(nonatomic, retain) IBOutlet UILabel *botLabel;


//@property(nonatomic, getter=isSecureTextEntry) BOOL secureTextEntry;

@property (nonatomic, retain) UIActivityIndicatorView *spinner;

@property (nonatomic, retain) IBOutlet UIWebView *webWindow;


-(IBAction)buttonClick: (id) sender;
-(IBAction)button2Send: (id) sender;
-(IBAction)settingsButtonPressed: (id) sender;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
//- (void)refreshPrefs: (id) sender;

-(IBAction)sliderMoved: (id) sender;


@end
