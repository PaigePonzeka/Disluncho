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
     NSMutableArray *currentRestaurantsArray;
	Disluncho1AppDelegate *root;

}
@property (nonatomic, retain) NSMutableArray *currentRestaurantsArray;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
