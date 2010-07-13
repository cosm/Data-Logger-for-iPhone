//
//  FeedHistory.h
//  pachubeTabV2
//
//  Created by Christopher  on 30/09/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pachubeTabAppDelegate.h"

@interface FeedHistory : UIViewController {
	IBOutlet UIImageView *graphView;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIImage *image;

	IBOutlet UISegmentedControl *mapSwitch;
	BOOL *display;
	
}

@property (nonatomic, retain) IBOutlet UIImageView *graphView;
@property(nonatomic, retain) IBOutlet UIImage *image;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;

@property(nonatomic, retain) IBOutlet UISegmentedControl *mapSwitch;
//@property(nonatomic, retain) BOOL *display;

@end
