//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 1.0.01


//	This file is part of Data Logger for iPhone.
//
//	Data Logger for iPhone is free software: you can redistribute it and/or modify
//	it under the terms of the GNU General Public License as published by
//	the Free Software Foundation, either version 3 of the License, or
//	(at your option) any later version.
//
//	Data Logger for iPhone is distributed in the hope that it will be useful,
//	but WITHOUT ANY WARRANTY; without even the implied warranty of
//	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//	GNU General Public License for more details.
//
//	You should have received a copy of the GNU General Public License
//	along with Data Logger for iPhone.  If not, see <http://www.gnu.org/licenses/>.


#import "FeedInfo.h"


@implementation FeedInfo

static NSString *kSectionTitleKey = @"sectionTitleKey";
static NSString *kSourceKey = @"sourceKey";
static NSString *kViewKey = @"viewKey";

//const NSInteger kViewTag = 1;

#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0
#define kTextFieldHeight		30.0

#define kTextFieldWidth			260.0

@synthesize editMode, textFieldNormal, textFieldSecure, dataSourceArray, fdDomainTemp, fdDispositionTemp, fdExposureTemp, fdURLTemp, fdLocationTemp;
@synthesize domainButton, positionButton, exposureButton, detailDisclosureButtonType, feedNumber, feedList;


//RootViewController.m
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	return 45;
		
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if ([indexPath section] == 1 && [indexPath row] == 0) {
	
		[self getDesc];
		
	}
}

- (void)getDesc 

{
	
	TextViewController *textController = [[TextViewController alloc] initWithNibName:@"DescriptionEditor" bundle:[NSBundle mainBundle]];
	textController.mainText = [feedDictionary objectForKey:@"fdDescription"];
	textController.feedNumber = feedNumber;
	
	[self.navigationController pushViewController:textController animated:YES];
	[textController release];
	textController = nil;
		
}



- (UIButton *)detailDisclosureButtonType
{
	if (detailDisclosureButtonType == nil)
	{
		// create a UIButton (UIButtonTypeDetailDisclosure)
		
		detailDisclosureButtonType = [[UIButton buttonWithType:UIButtonTypeDetailDisclosure] retain];
		detailDisclosureButtonType.frame = CGRectMake(270.0, 8.0, 25.0, 25.0);
		detailDisclosureButtonType.backgroundColor = [UIColor clearColor];
		[detailDisclosureButtonType addTarget:self action:@selector(getDesc) forControlEvents:UIControlEventTouchUpInside];
		
}

	return detailDisclosureButtonType;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	NSUInteger row = [indexPath row];
	NSUInteger section = [indexPath section];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Set up the cell...
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	//cell.backgroundColor = [UIColor clearColor];
	
	//NSString *cellValue = [listOfItems objectAtIndex:indexPath.row];
	if (section == 0){	
	
		if (row == 0){
			
			NSString *cellValue = @"            URL";
			cell.text = cellValue;
			
			UITextField *textField = textFieldNormal;
			textField.text = fdURLTemp;
			[cell.contentView addSubview:textField];
			
		} else if (row == 1){
				
			NSString *cellValue = @"    Location";
			cell.text = cellValue;
			
				UITextField *textField = textFieldSecure;
				textField.text = fdLocationTemp;
				[cell.contentView addSubview:textField];
				
			} else if (row == 2){
				
				NSString *cellValue = @"      Domain";
				cell.text = cellValue;
				
				UISegmentedControl *button = domainButton;
				[button addTarget:self action:@selector(storeButtonValues:) forControlEvents:UIControlEventValueChanged];
				[cell.contentView addSubview:button];
				
			} else if (row == 4){
				
				NSString *cellValue = @"   Exposure";
				cell.text = cellValue;
				
				UISegmentedControl *button = exposureButton;
				[button addTarget:self action:@selector(storeButtonValues:) forControlEvents:UIControlEventValueChanged];

				[cell.contentView addSubview:button];
				
			} else if (row == 3){
			NSString *cellValue = @"Disposition";
			cell.text = cellValue;
			
			UISegmentedControl *button = positionButton;
				[button addTarget:self action:@selector(storeButtonValues:) forControlEvents:UIControlEventValueChanged];

			[cell.contentView addSubview:button];
				}
		
		} else if (section == 1){
			
				NSString *cellValue = @"Description";
				cell.text = cellValue;
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				UIButton *button = detailDisclosureButtonType;
				
				[cell.contentView addSubview:button];
				
		} else {
			
			if (row == 0)	{
				NSString *cellValue = @"Update Locations";
				cell.text = cellValue;
			}
	}

	return cell;
	
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	
	// the user pressed the "Done" button, so dismiss the keyboard
	

	if (textField.tag == @"url") {

		NSLog(@"saving the url...");
		[feedDictionary setObject:textField.text forKey:@"fdURL"];
		
		
	}
	
	if (textField.tag == @"location") {
		
		NSLog(@"saving the location..");
		[feedDictionary setObject:textField.text forKey:@"fdLocation"];
		
	}

	[textField resignFirstResponder];
	
	return YES;
}



-(void)storeButtonValues:(UISegmentedControl *)segButton{

	NSLog(@"some thing is being called here");
	
	if (segButton.tag == @"domain") {
	
		if (segButton.selectedSegmentIndex == 0){
			
			fdDomainTemp = @"Physical";
			NSLog(@"fdDomainTemp is %@: ",fdDomainTemp);
	
		} else {
			
			fdDomainTemp = @"Virtual";
			NSLog(@"fdDomainTemp is %@: ",fdDomainTemp);
		}

		
	} else if (segButton.tag == @"position") {
		
		if (segButton.selectedSegmentIndex == 0){
			
			fdDispositionTemp = @"Fixed";
			NSLog(@"fdDispositionTemp is %@: ",fdDispositionTemp);
		
		} else {
			
			fdDispositionTemp = @"Mobile";
			NSLog(@"fdDispositionTemp is %@: ",fdDispositionTemp);
		}
		
		
	} else if (segButton.tag == @"exposure") {
		if (segButton.selectedSegmentIndex == 0){
			
			fdExposureTemp = @"Indoor";
			NSLog(@"fdExposureTemp is %@: ",fdExposureTemp);
		} else {
			
			fdExposureTemp = @"Outdoor";
			NSLog(@"fdExposureTemp is %@: ",fdExposureTemp);
		}
		
		
	}
	
}

- (UITextField *)textFieldNormal
{
	if (textFieldNormal == nil)
	{
		CGRect frame = CGRectMake(114.0, 12.0, 180.0, 30.0);
		textFieldNormal = [[UITextField alloc] initWithFrame:frame];
		
		textFieldNormal.borderStyle = UITextBorderStyleNone;
		textFieldNormal.textColor = [UIColor blackColor];
		textFieldNormal.font = [UIFont systemFontOfSize:17.0];
		
		textFieldNormal.placeholder = @"(optional)";
		textFieldNormal.text = fdURLTemp;
		textFieldNormal.backgroundColor = [UIColor whiteColor];
		textFieldNormal.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
		
		textFieldNormal.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
		textFieldNormal.returnKeyType = UIReturnKeyDone;
		
		textFieldNormal.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		textFieldNormal.tag = @"url";		// tag this control so we can remove it later for recycled cells
		textFieldNormal.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
		
	}
	
	return textFieldNormal;
}

- (UISegmentedControl *)domainButton
{
	if (domainButton == nil)
	{

		NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Physical", @"Virtual", nil];
		domainButton = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
		
		domainButton.tag = @"domain";
		CGRect frame = CGRectMake(115, 5, 180, 35);
		domainButton.frame = frame;
		
		if ([fdDomainTemp isEqualToString:@"Physical"]) {
		domainButton.selectedSegmentIndex = 0;	
			
		} else {
			
			NSLog(@"the domain buttong is virtual");
			domainButton.selectedSegmentIndex = 1;	
		}
		

	}
	
	return domainButton;
}

- (UISegmentedControl *)positionButton
{
	if (positionButton == nil)
	{
		
		NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Fixed", @"Mobile", nil];
		positionButton = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
		positionButton.tag = @"position";
		
		CGRect frame = CGRectMake(115, 5, 180, 35);
		positionButton.frame = frame;
		//[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
		
		if ([fdDispositionTemp isEqualToString:@"Fixed"]) {
			
			positionButton.selectedSegmentIndex = 0;			
			
			} else {
			
			NSLog(@"the dispo buttong is mobile");
			positionButton.selectedSegmentIndex = 1;	
			}
		}
	
	return positionButton;
}

- (UISegmentedControl *)exposureButton
{
	if (exposureButton == nil)
	{
		
		NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Indoor", @"Outdoor", nil];
		exposureButton = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
		exposureButton.tag = @"exposure";
		
		CGRect frame = CGRectMake(115, 5, 180, 35);
		exposureButton.frame = frame;
		//[segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
		if ([fdExposureTemp isEqualToString:@"Indoor"]) {
			exposureButton.selectedSegmentIndex = 0;				
		} else {
			
			NSLog(@"the expsousre buttong is outdoor");
			exposureButton.selectedSegmentIndex = 1;	
		}
		
	}
	
	return exposureButton;

}


- (UITextField *)textFieldSecure
{
	if (textFieldSecure == nil)
	{
		CGRect frame = CGRectMake(114.0, 12.0, 180.0, 30.0);
		textFieldSecure = [[UITextField alloc] initWithFrame:frame];
		textFieldSecure.borderStyle = UITextBorderStyleNone;
		textFieldSecure.textColor = [UIColor blackColor];
		textFieldSecure.font = [UIFont systemFontOfSize:17.0];
		textFieldSecure.placeholder = @"(optional)";
		textFieldSecure.backgroundColor = [UIColor whiteColor];
		
		textFieldSecure.keyboardType = UIKeyboardTypeDefault;
		textFieldSecure.returnKeyType = UIReturnKeyDone;	
		
		textFieldSecure.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
		textFieldSecure.tag = @"location";
		
		textFieldSecure.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
	}
	
	return textFieldSecure;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	
	if(textField.tag == @"location")
		
	{
		textFieldNormal.userInteractionEnabled = NO;
		
	}	else if(textField.tag == @"url"){
		
		textFieldSecure.userInteractionEnabled = NO;
		
	}
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
	
	textFieldNormal.userInteractionEnabled = YES;
	textFieldSecure.userInteractionEnabled = YES;
	
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case (0):
			return 5;
			break;
        case (1):
			return 1;
			break;


    }
	
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {

		case (0):
			return @"Feed Details";
			break;
		
    }
	
    return nil;
}



-(void)saveWithRootReturn{
	
	
	[self saveEdit];
	[self.navigationController popToRootViewControllerAnimated:YES];
	
	
}

-(void)saveWithPageReturn{
	
	[self saveEdit];
	[self.navigationController popViewControllerAnimated:YES];
		
}

-(void)saveEdit {
	
	
	[feedDictionary setObject:fdDomainTemp forKey:@"fdDomain"];
	[feedDictionary setObject:fdExposureTemp forKey:@"fdExposure"];
	[feedDictionary setObject:fdDispositionTemp forKey:@"fdDisposition"];

	[feedList replaceObjectAtIndex:[feedNumber integerValue] withObject:feedDictionary];
	[[NSUserDefaults standardUserDefaults] setObject:feedList forKey:@"AllTheFeeds"];
			
}


- (void)viewWillAppear:(BOOL)animated {
	
	
	feedList = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AllTheFeeds"] mutableCopy];
	feedDictionary =[[feedList objectAtIndex:[feedNumber integerValue]] mutableCopy];
	
	fdDomainTemp = [feedDictionary objectForKey:@"fdDomain"];
	fdExposureTemp = [feedDictionary objectForKey:@"fdExposure"];
	fdDispositionTemp = [feedDictionary objectForKey:@"fdDisposition"];
	fdURLTemp = [feedDictionary objectForKey:@"fdURL"];
	fdLocationTemp = [feedDictionary objectForKey:@"fdLocation"];
	
	
	
	NSLog(@"DOMAIN IS: %@",fdDomainTemp);
	NSLog(@"DISPO IS: %@",fdDispositionTemp);
	NSLog(@"EXPO IS: %@",fdExposureTemp);

	NSLog(@"Feed number is:%@ and edit mode is:%@", feedNumber, editMode);
	
	if (editMode == @"newFeed"){
		
		NSLog(@"edit mode is on");
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(saveWithRootReturn)];
		[self.navigationItem setLeftBarButtonItem:addButton];	
		
	} else {
		
		NSLog(@"edit mode is off");
		UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(saveWithPageReturn)];
		[self.navigationItem setLeftBarButtonItem:addButton];	
		
	}
	
	
		
	NSLog([feedDictionary description]);
	
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,320,400)style: UITableViewStyleGrouped];
	self.title = NSLocalizedString(@"Edit Metadata", @"");
	
	self.dataSourceArray = [NSArray arrayWithObjects:
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UITextField", kSectionTitleKey,
							 @"TextFieldController.m: textFieldNormal", kSourceKey,
							 self.textFieldNormal, kViewKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UITextField Secure", kSectionTitleKey,
							 @"TextFieldController.m: textFieldSecure", kSourceKey,
							 self.textFieldSecure, kViewKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UISegmentControl", kSectionTitleKey,
							 @"FeedInfo.m: domainButton", kSourceKey,
							 self.domainButton, kViewKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UISegmentControl", kSectionTitleKey,
							 @"FeedInfo.m: exposureButton", kSourceKey,
							 self.exposureButton, kViewKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UIButton", kSectionTitleKey,
							 @"FeedInfo.m: exposureButton", kSourceKey,
							 self.detailDisclosureButtonType, kViewKey,
							 nil],
							
							[NSDictionary dictionaryWithObjectsAndKeys:
							 @"UISegmentControl", kSectionTitleKey,
							 @"FeedInfo.m: positionButton", kSourceKey,
							 self.positionButton, kViewKey,
							 nil],
							
							
							nil];

	

	
	
	
	
	[self.tableView reloadData];
	
    NSLog(@"[%@ viewWillAppear:%d]", [self class], animated);
	
	
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"[%@ viewDidAppear:%d]", [self class], animated);
	
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"[%@ viewWillDisappear:%d]", [self class], animated);
	
	
	[self saveEdit];
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
	
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning {
    
	[super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
	
	self.tableView = nil;
	textFieldNormal = nil;
	textFieldSecure = nil;
	
	self.view = nil;
	
	[feedList release];
	[feedDictionary release];
	
	[textFieldNormal release];
	[textFieldSecure release];
	
}

- (void)dealloc {
	
	[textFieldNormal release];
	[textFieldSecure release];
	
    [super dealloc];
}


@end
