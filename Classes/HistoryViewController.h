//
//  HistoryViewController.h
//  pachubeTab
//
//  Created by Christopher  on 19/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HistoryViewController : UIViewController {

	IBOutlet UIImageView *graphView;
	IBOutlet UILabel *titleLabel;
	IBOutlet UIImage *image;
		IBOutlet UIWebView *webGraph;
	IBOutlet UISegmentedControl *mapSwitch;
	BOOL *display;
	
}

@property (nonatomic, retain) IBOutlet UIImageView *graphView;
@property(nonatomic, retain) IBOutlet UIImage *image;
@property(nonatomic, retain) IBOutlet UILabel *titleLabel;
@property(nonatomic, retain) IBOutlet UIWebView *webGraph;
@property(nonatomic, retain) IBOutlet UISegmentedControl *mapSwitch;
//@property(nonatomic, retain) BOOL *display;

@end
