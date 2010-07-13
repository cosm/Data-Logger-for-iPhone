//
//  HistoryViewController.m
//  pachubeTab
//
//  Created by Christopher  on 19/08/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"


@implementation HistoryViewController

@synthesize graphView, image, mapSwitch, webGraph, titleLabel;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
		
//	NSString *fileName = @"logo";
//	NSString *urlString = [NSString stringWithFormat: @"http://www.google.com/intl/en_ALL/images/@%.gif", imageURL];
//	NSURL *url = [NSURL URLWithString: urlString];
//	UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: url]] retain];

	
//	NSString* feedidTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
	//NSString* streamidTemp = [[NSUserDefaults standardUserDefaults] stringForKey:@"streamid"]; 
	
//	NSString* urlTemp = [NSString stringWithFormat: @"http://www.pachube.com/feeds/2322/datastreams/0/history.png?w=296&h=250"];
//	NSURL *urlNew = [NSURL URLWithString: urlTemp];
	
	//image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlNew]]];
	
	[mapSwitch addTarget:self action:@selector(displayImage) forControlEvents:UIControlEventValueChanged];
	
	NSString* feedIDForTitle = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
	titleLabel.text = [NSString stringWithFormat:@"Pachube Feed: %@", feedIDForTitle];
	display = TRUE;
	webGraph.hidden = TRUE;
	[self displayImage];
    [super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)displayImage {
	
	
	if (display)
	{
		
		NSString* urlNumberImage = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
		NSString *urlFullImage = [NSString stringWithFormat:@"http://www.pachube.com/feeds/2605/datastreams/0/history.png?w=288&h=277"];
		NSURL *getUrlImage = [NSURL URLWithString:@"http://www.pachube.com/feeds/504/datastreams/1/history.png?w=288&h=277"];
		
	image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://www.pachube.com/feeds/2474/datastreams/0/history.png?w=288&h=277"]]];
	graphView.image = image;
		
		NSLog(@"DISPLAY ONE");
		display = FALSE;	
		//[webGraph loadRequest:NULL];
		webGraph.hidden = TRUE;
	} else {
		NSLog(@"DISPLAY TWO");
		webGraph.hidden = FALSE;
		display = TRUE;
		
		NSString* urlNumberGraph = [[NSUserDefaults standardUserDefaults] stringForKey:@"feedid"]; 
		//NSString* urlFullGraph = [NSString stringWithFormat:@"http://apps.pachube.com/trails/preview.php?feed=2605&lot=1&lon=2&d=3&w=280&h=240"];
		//NSURL *getUrlGraph = [NSURL URLWithString:urlFullGraph];
		//NSURLRequest *requestGraph = [NSURLRequest requestWithURL:getUrlGraph];

		
		NSString *HTMLData = @"<script type=\"text/javascript\" src=\"http://tile.cloudmade.com/wml/0.2/web-maps-lite.js\"></script><script type=\"text/javascript\" src=\"http://apps.pachube.com/trails/trails.js\"></script><script type=\"text/javascript\">createPachubeTrails(2605,0,1,2,280,180);</script>";
		//NSString *HTMLData = @"HI GUYS";
		
		[webGraph loadHTMLString:HTMLData baseURL:nil];
		
		//[webGraph loadRequest:requestGraph];
		
		graphView.image = NULL;
	}
	
}


- (void)dealloc {
    [super dealloc];
}


@end
