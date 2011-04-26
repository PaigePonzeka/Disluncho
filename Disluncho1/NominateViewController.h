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

@interface NominateViewController : UITableViewController {
     NSMutableArray *currentRestaurantsArray;
}
@property (nonatomic, retain) NSMutableArray *currentRestaurantsArray;
@end
