//
//  NominateViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoteViewController.h"
#import "AddRestaurantViewController.h"
#import "Disluncho1AppDelegate.h"


@interface NominateViewController : UITableViewController {
	NSMutableArray *currentRestaurants;//2D array holds results from database

	Disluncho1AppDelegate *root;

	//index into array
	int PLACEUNID;
	int PLACENAME;
	int PLACEPHOTO;
}
@property (nonatomic, retain) NSMutableArray *currentRestaurants;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
