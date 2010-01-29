//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

// This TextViewController is used to edit the description
// It is loaded as a sub view of FeedInfo


#import <UIKit/UIKit.h>
#import "pachubeTabAppDelegate.h"

@interface TextViewController : UIViewController <UITextViewDelegate>
{
	UITextView *textView;
	NSString *mainText;
	NSString *feedNumber;
}

@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) NSString *mainText;
@property (nonatomic, retain) NSString *feedNumber;

@end
