//
//  SettingsViewController.h
//  pachubeTab
//
//  Created by Christopher  on 19/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController : UIViewController <UITextFieldDelegate>
	{
		
			IBOutlet UITextField *userName;
		IBOutlet UITextField *passWord;
		IBOutlet UITextField *feedNumber;
		IBOutlet UITextField *streamNumber;
		
		
	}


@property(nonatomic, retain) IBOutlet UITextField *userName;
@property(nonatomic, retain) IBOutlet UITextField *passWord;
@property(nonatomic, retain) IBOutlet UITextField *feedNumber;
@property(nonatomic, retain) IBOutlet UITextField *streamNumber;


- (IBAction)savePrefs:(id)sender;		

	@end
	
