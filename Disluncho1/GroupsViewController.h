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
    NSMutableArray *usersGroupsArray;
	Disluncho1AppDelegate *root;
	
	int GROUPNAME;
	int GROUPID;

}
@property (nonatomic, retain) NSMutableArray *usersGroupsArray;
@property (nonatomic, retain) Disluncho1AppDelegate *root;

@end
