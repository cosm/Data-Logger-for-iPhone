//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController <UIWebViewDelegate> {
	
	IBOutlet UIWebView *aboutText;
	IBOutlet UILabel *versionLabel;
	
}


@property (nonatomic, retain) IBOutlet UIWebView *aboutText;
@property (nonatomic, retain) IBOutlet UILabel *versionLabel;


@end
