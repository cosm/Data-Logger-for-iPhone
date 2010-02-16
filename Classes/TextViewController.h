//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 0.27


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
