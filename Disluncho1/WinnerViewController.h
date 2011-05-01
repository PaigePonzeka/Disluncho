//
//  WinnerViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupsViewController.h"
#import "Disluncho1AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface WinnerViewController : UITableViewController {
    NSMutableArray *nomineesArray;
	Disluncho1AppDelegate *root;

    BOOL waiting_for_votes;
}
@property (nonatomic, retain) NSMutableArray *nomineesArray;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
