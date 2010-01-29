//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.2.6

#import "AboutViewController.h"
#import "Constants.h"



@implementation AboutViewController

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request

navigationType:(UIWebViewNavigationType)navigationType; {
	
	NSURL *requestURL =[ [ request URL ] retain ];
	// Check to see what protocol/scheme the requested URL is.
	if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ]
		  || [ [ requestURL scheme ] isEqualToString: @"https" ] )
		&& ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
		return ![ [ UIApplication sharedApplication ] openURL: [ requestURL autorelease ] ];
	}
	// Auto release
	[ requestURL release ];
	// If request url is something other than http or https it will open
	// in UIWebView. You could also check for the other following
	// protocols: tel, mailto and sms
	return YES;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	
	aboutText.delegate = self;

	versionLabel.text = [NSString stringWithFormat:@"Version: %.2f", kDataLoggerVersion];

	[aboutText loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"]isDirectory:NO]]];
	
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	
	 //self.aboutText = nil;

}

- (void)dealloc {
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"[%@ viewDidAppear:%d]", [self class], animated);
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"[%@ viewWillDisappear:%d]", [self class], animated);
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
    [super viewDidDisappear:animated];
}

@end
