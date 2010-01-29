//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. All rights reserved.
//	Version 0.27

#import <UIKit/UIKit.h>
#import "PachubeCLController.h"
#import "pachubeTabAppDelegate.h"

@interface FeedList : UITableViewController {
	
	BOOL searching;
	BOOL letUserSelectRow;
	
	NSMutableArray *ListArray;
		
	NSMutableData *webData;
	NSUInteger *feedToDelete;
	NSString *feedStringToDelete;
	
	IBOutlet UIActivityIndicatorView *deleteSpinner;

}

@property (nonatomic, retain) 	NSMutableArray *ListArray;
@property (nonatomic, retain) 	NSString *feedStringToDelete;
@property (nonatomic, retain) 	UIActivityIndicatorView *deleteSpinner;

-(IBAction)AddNewFeed: (id) sender;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;
- (IBAction) EditTable:(id)sender;

@end
