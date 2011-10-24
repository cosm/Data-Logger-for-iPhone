//  -------------------
//  Pachube Data Logger
//  -------------------
//
//  Created by Christopher Burman on 01/12/2009.
//  Copyright 2009 Connected Environments Ltd. 
//	Version 0.28


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


@protocol PachubeCLControllerDelegate 
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end



@interface PachubeCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (nonatomic, assign) id  delegate;

- (void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
didFailWithError:(NSError *)error;

@end
