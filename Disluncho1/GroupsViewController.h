//
//  GroupsViewController.h
//  Disluncho1
//
//  Created by Paige Ponzeka on 4/26/11.
//  Copyright 2011 NYU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NominateViewController.h"
#import "AddGroupViewController.h"
#import "GroupDetailsViewController.h"
#import "Disluncho1AppDelegate.h"


@interface GroupsViewController : UITableViewController {
	NSMutableArray* usersGroups;//2D name/id array of results from database
	
	Disluncho1AppDelegate *root;
	
	//index into the results array
	int GROUPNAME;
	int GROUPID;
	int GROUPPHOTO;
	int ROUNDID;

}
@property (nonatomic, retain) NSMutableArray *usersGroups;
@property (nonatomic, retain) Disluncho1AppDelegate *root;
@property (nonatomic, assign) int GROUPID;
@end
